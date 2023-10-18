#!/bin/bash

set -a; source .env; set +a

echo "Deploying"

forge create --rpc-url $SEPOLIA_URL --private-key $PRIVATE_KEY src/Counter.sol:BLCToken