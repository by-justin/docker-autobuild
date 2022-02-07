#!/bin/bash

CHINA_DNSSERVER="202.46.34.75"
DOMAIN_LIST=("api.themoviedb.org" "image.tmdb.org" "api.thetvdb.org" "www.omdbapi.com")

HOST_FILE="/hosts"

dns_lookup() {
    local domain=$1
    local dns_server=$2
    nslookup "$domain" "$dns_server" | awk '/^Address: / { print $2 }' | head -n 1
}

echo -e "\n### Jellyfin China ###\n" >> "$HOST_FILE"

for domain in "${DOMAIN_LIST[@]}"; do
    ip=$(dns_lookup "$domain" "$CHINA_DNSSERVER")

    if [ -n "$ip" ]; then
        echo "$ip $domain" >> "$HOST_FILE"
    fi
done