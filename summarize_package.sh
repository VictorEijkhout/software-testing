#!/bin/bash

package=$( cat package.sh | grep package= | cut -d '=' -f 2 )

./tacc_tests.sh -r \
    awk '\
        /Configuration:/ {configuration = $3 } \
        /could not load/ {missing = missing " " configuration} \
        END { printf("Missing: %d\n",missing); \
            } \
    2>&1 | tee ${package}_summary.log
