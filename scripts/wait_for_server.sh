#!/usr/bin/env bash

status=""
counter=0
checkcounter=0

until [[ $status = "false" ]]; do
    status=$(curl 2>/dev/null "http://$1/status.php" | jq .maintenance)
    echo "($checkcounter) $status"

    if [[ "$status" =~ "false" || "$status" = "" ]]; then
        let "counter += 1"
         if [[ $counter -gt 30 ]]; then
            echo "Failed to wait for server"
            exit 1
        fi
    fi

    let "checkcounter += 1"
    sleep 10
done

echo "($checkcounter) Done"
