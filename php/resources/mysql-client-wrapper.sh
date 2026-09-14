#!/bin/bash

# MariaDB >= 11.4 clients verify the server certificate by default, which fails on the
# self-signed certificates of the dev databases. Keep the previous non-verifying behavior.
# Option file arguments must come first, so the flag is inserted right after them.

leading=()
while [[ $# -gt 0 ]]; do
    case "$1" in
        --defaults-file=*|--defaults-extra-file=*|--defaults-group-suffix=*|--no-defaults|--print-defaults)
            leading+=("$1")
            shift ;;
        *)
            break ;;
    esac
done

exec "/usr/bin/$(basename "$0")" "${leading[@]}" --skip-ssl-verify-server-cert "$@"
