#!/bin/sh
cat test | tail -n 3 | grep -q -e Resetting -e "ath: Failed to stop TX DMA" || exit 0

echo need to reset