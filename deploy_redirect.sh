#!/usr/bin/env bash

set -e -u -x

while getopts "r:" arg; do
  case "$arg" in
    r) redirect=$OPTARG;;
  esac
done
shift $((OPTIND-1))

site=$(mktemp -dt deploy_redirect_XXXXXX)
trap 'rm -r "$site"' EXIT

cat > "$site/.htaccess" <<-EOF
RewriteEngine on 
RewriteRule ^(.*)\$ https://$redirect/\$1 [R=301,L]
EOF

./deploy_site.sh -s "$site/" "$@"