#!/bin/bash
check_disk(){
	df -h / | tail -1 | awk '{print $5}'
}
check_memory(){
	free -h | grep Mem | awk '{print $3"/"$2}'
}
echo "Disk Usage: $(check_disk)"
echo "Memory Usage: $(check_memory)"
