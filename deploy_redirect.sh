#!/usr/bin/env bash

set -e -u -x

while getopts "r:" arg; do
  case "$arg" in
    r) redirect=$OPTARG;;
  esac
done
shift $((OPTIND-1))

tmp=$(mktemp -dt deploy_redirect_XXXXXX)
trap 'rm -r "$tmp"' EXIT

site=${tmp}/www
mkdir "$site"

cat > "$site/.htaccess" <<-EOF
RewriteEngine on 
RewriteCond %{REQUEST_URI} !^/\.well-known/.*
RewriteRule ^(.*)\$ https://$redirect/\$1 [R=301,L]
EOF

./deploy_site.sh -s "$site/" "$@"