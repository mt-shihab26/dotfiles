#!/bin/zsh

greet() {
    local name="$1"
    print "Hello, $name!"
}

typeset -A ages=(alice 30 bob 25)
local -a names=(${(ok)ages})

for name in $names; do
    greet "${(C)name}"
    print "  age: ${ages[$name]}"
done

if ((${#names} == 2)); then
    print "two names"
fi
