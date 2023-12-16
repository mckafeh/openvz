#!/bin/bash

# Cloudflare API Details
API_KEY="YOUR_CLOUDFLARE_API_KEY"
ZONE_ID="YOUR_CLOUDFLARE_ZONE_ID"

# Define DNS Records (Add or remove records as needed)
declare -a DNS_RECORDS=("example.com" "subdomain.example.com" "anotherdomain.com")

# Get current public IP address
PUBLIC_IP=$(curl -s https://api64.ipify.org)

# Loop through each DNS record and update it with the new IP address
for RECORD_NAME in "${DNS_RECORDS[@]}"; do
    # Get the DNS record ID
    RECORD_ID=$(curl -s -X GET "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records?type=A&name=$RECORD_NAME" \
      -H "Authorization: Bearer $API_KEY" \
      -H "Content-Type: application/json" | jq -r '.result[0].id')

    # Update the DNS record with the new IP address
    curl -s -X PUT "https://api.cloudflare.com/client/v4/zones/$ZONE_ID/dns_records/$RECORD_ID" \
      -H "Authorization: Bearer $API_KEY" \
      -H "Content-Type: application/json" \
      --data "{\"type\":\"A\",\"name\":\"$RECORD_NAME\",\"content\":\"$PUBLIC_IP\",\"ttl\":1,\"proxied\":false}"

    echo "DNS record for $RECORD_NAME updated with IP: $PUBLIC_IP"
done
