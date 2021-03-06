#!/usr/bin/env bash

cpu_usage=$(top -b -d1 -n1|grep -i "Cpu(s)"|head -c21|cut -d ' ' -f3|cut -d '%' -f1);

# the total memory. the MemTotal row is extracted using awk. the second column of this row is then extracted and saved to total variable
total=$( awk '/MemTotal/ {print $2}' < /proc/meminfo )
# the available memory. the MemAvailable row is extracted using awk. the second column of this row is then extracted and saved to available variable
available=$( awk '/MemAvailable/ {print $2}' < /proc/meminfo )
# the formula for calculating percentage of available memory is piped to bc command. the output of bc command is saved to memory_available variable
memory_available=$(echo "($available*100/$total)" | bc)

echo "Total: $total, Avail: $available, Perc: $memory_available, CPU: $cpu_usage"