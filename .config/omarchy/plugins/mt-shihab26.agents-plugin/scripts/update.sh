#!/bin/bash

# Regenerates the usage records this plugin displays, into its own usage
# directory (never Omarchy's, so it can run beside the built-in agents plugin).
#
#   update.sh [--force] [--limits-only] [--except <agent>] [agent...]
#
# Codex, Fireworks and any other stock collector run unchanged. Claude Code is
# collected once per account: every directory under ~/.config/claude/ (for
# example `personal` and `professional`) is a CLAUDE_CONFIG_DIR and becomes its
# own record, `claude-<dir>`, so the panel shows one tab per subscription.

STATE_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/omarchy-agents-plugin"
USAGE_DIR="$STATE_DIR/usage"
CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/omarchy-agents-plugin"
CLAUDE_ACCOUNTS_DIR="${CLAUDE_ACCOUNTS_DIR:-$HOME/.config/claude}"
OMARCHY_BIN="${OMARCHY_PATH:-/usr/share/omarchy}/bin"

mkdir -p "$USAGE_DIR"

flags=()
only=()
declare -A excluded

while [[ $# -gt 0 ]]; do
  case "$1" in
  --force | --limits-only) flags+=("$1") ;;
  --except)
    excluded[$2]=1
    shift
    ;;
  *) only+=("$1") ;;
  esac
  shift
done

wanted() {
  local agent="$1"
  [[ -n ${excluded[$agent]} ]] && return 1
  ((${#only[@]} == 0)) && return 0
  local candidate
  for candidate in "${only[@]}"; do
    [[ $candidate == "$agent" ]] && return 0
  done
  return 1
}

# Reads one record from stdin and publishes it atomically as <agent>.json.
publish() {
  local agent="$1" record tmp
  record=$(cat)
  if [[ -z $record ]] || ! jq -e . >/dev/null 2>&1 <<<"$record"; then
    echo "update.sh: $agent collector failed" >&2
    return 1
  fi
  tmp=$(mktemp "$USAGE_DIR/.$agent.XXXXXX")
  printf '%s\n' "$record" >"$tmp"
  mv "$tmp" "$USAGE_DIR/$agent.json"
}

# Every account gets its own cache, home and data directory. The cache keeps
# one account's limits from being served as another's; the empty home and data
# directories stop the collector's pi/omp and opencode scans from adding the
# same sessions to every account.
collect_claude_account() {
  local dir="$1" name id account sandbox
  name=$(basename "$dir")
  id="claude-$name"
  account="${name^}"
  sandbox="$CACHE_DIR/$id"
  mkdir -p "$sandbox/home" "$sandbox/data"

  CLAUDE_CONFIG_DIR="$dir" XDG_CACHE_HOME="$sandbox/cache" XDG_DATA_HOME="$sandbox/data" HOME="$sandbox/home" \
    "$OMARCHY_BIN/omarchy-agent-usage-claude" "${flags[@]}" |
    jq -c --arg id "$id" --arg account "$account" \
      '.id = $id | .family = "claude" | .familyName = "Claude" | .accountName = $account | .name = "Claude · " + $account | .iconId = "claude"' |
    publish "$id"
}

pids=()
claude_ids=()

for collector in "$OMARCHY_BIN"/omarchy-agent-usage-*; do
  [[ -x $collector ]] || continue
  agent="${collector##*/omarchy-agent-usage-}"
  [[ $agent == "update" || $agent == "claude" ]] && continue
  wanted "$agent" || continue
  ("$collector" "${flags[@]}" | publish "$agent") &
  pids+=($!)
done

for dir in "$CLAUDE_ACCOUNTS_DIR"/*/; do
  [[ -d $dir ]] || continue
  dir="${dir%/}"
  id="claude-$(basename "$dir")"
  claude_ids+=("$id")
  wanted "$id" || continue
  collect_claude_account "$dir" &
  pids+=($!)
done

status=0
for pid in "${pids[@]}"; do
  wait "$pid" || status=1
done

# A full run drops the records of accounts whose directory has gone away.
if ((${#only[@]} == 0)); then
  for record in "$USAGE_DIR"/claude-*.json; do
    [[ -e $record ]] || continue
    id=$(basename "$record" .json)
    [[ " ${claude_ids[*]} " == *" $id "* ]] || rm -f "$record"
  done
fi

exit $status
