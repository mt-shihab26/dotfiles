# ThinkPad T470s notes

Hardware quirks of this laptop and how to deal with them on Omarchy.

## Batteries

The T470s has two batteries, and both are worn out (checked 2026-11-03):

| Battery            | Part    | Design capacity | Actual capacity | Cycles |
| ------------------ | ------- | --------------- | --------------- | ------ |
| Internal (`BAT0`)  | 00HW023 | 23.5 Wh         | 1.3 Wh (5%)     | 240    |
| Removable (`BAT1`) | 01AV406 | 24.4 Wh         | 7.1 Wh (29%)    | 280    |

They don't hold any charge, so the laptop only runs while plugged in and the bar reports
"not charging". This isn't a charge threshold: both thresholds are already 0/100.

Check battery health:

```sh
grep -E "STATUS|CAPACITY=|ENERGY_FULL" /sys/class/power_supply/BAT*/uevent
```

**Fix:** replace the battery. 01AV406 (removable) is the easy one to swap. Use the original
45W or 65W Lenovo charger.

Until then:

- Plug the charger straight into the wall or into a good power strip. With dead batteries,
  any power blip turns the laptop off instantly.
- Save often.

## Freezes: CPU stuck at 400 MHz (BD PROCHOT)

**Symptom:** the system stalls for a few seconds at a time, even though the temperature is
normal (~70°C, the limit is 100°C).

**Cause:** with dead batteries, the embedded controller asserts BD PROCHOT, which forces the
CPU down to 400 MHz. It does this because the batteries can't help the charger during bursts
of high power use. The thermal throttle counters climb by hundreds per second.

Check it:

```sh
# minimum CPU frequency over 30s (a healthy result is well above 400)
min=9999; for i in $(seq 60); do f=$(awk '/MHz/{if(m==""||$4<m)m=$4}END{printf "%d",m}' /proc/cpuinfo); [ $f -lt $min ] && min=$f; sleep 0.5; done; echo "$min MHz"

# throttle events (re-run and compare)
cat /sys/devices/system/cpu/cpu0/thermal_throttle/{core,package}_throttle_count
```

**Fix:** replace the battery.

**Temporary workaround:** turn off BD PROCHOT (clear bit 0 of MSR `0x1FC`). It stays off
until the next reboot:

```sh
sudo pacman -S --needed msr-tools
sudo modprobe msr
sudo wrmsr -a 0x1FC $(printf '0x%x' $(( 0x$(sudo rdmsr 0x1FC) & ~1 )))
```

> ⚠️ This switches off a power-protection feature. If the charger can't keep up under heavy
> load, the laptop may shut off suddenly instead of slowing down.

## Typesense database corrupted by power loss

Sudden power cuts (see above) corrupted Typesense's LevelDB store. `typesense-server` then
segfaulted on start and systemd restarted it every ~5 s. This made the system lag and filled
`/var/lib/systemd/coredump` with 2.1 GB of crash dumps.

Spot it:

```sh
coredumpctl list | grep typesense
journalctl -u typesense-server -b | grep Corruption
```

Fix (keeps a backup of the broken database, then reindexes from scratch):

```sh
sudo systemctl stop typesense-server
sudo mv /var/lib/typesense/db /var/lib/typesense/db-corrupted-backup
sudo install -d -o typesense -g typesense /var/lib/typesense/db
sudo rm -rf /var/lib/systemd/coredump/*
```

Typesense is disabled at boot. Start it by hand when a project needs it:

```sh
sudo systemctl disable --now typesense-server   # keep it off at boot
sudo systemctl start typesense-server            # start for this session only
```
