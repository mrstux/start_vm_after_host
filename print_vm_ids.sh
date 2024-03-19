#!/bin/sh

midclt call vm.query | jq --raw-output '[.[] | { (.name): .id } ]' | grep ":"
