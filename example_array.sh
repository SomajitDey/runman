#!/usr/bin/env bash
echo "Example of array index based redirection for index=${RUNMAN_ARRAY_INDEX}" > "sample.out.${RUNMAN_ARRAY_INDEX}"
echo "This goes to stdout for index=${RUNMAN_ARRAY_INDEX}"

