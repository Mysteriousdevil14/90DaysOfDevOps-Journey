#!/bin/bash
set -euo pipefail
print_header(){
	echo -e "\n===$1==="
}
get_os_info(){
	hostname && cat /etc/os-release | grep PRETTY_NAME
}
get_uptime(){
	uptime -p
}
get_disk_usage(){
	df -h | sort -hr | head -n 5
}
get_memory_usage(){
	free -h
}
get_top_processes(){
	ps aux --sort=-%cpu | head -n 6
}
main(){
	print_header "System INformation Report"
	print_header "Hostname & OS Info"
	get_os_info
	print_header "Uptime"
	get_uptime
	print_header "Disk Usage (TOP 5)"
	get_disk_usage
	print_header "Memory Usage"
	get_memory_usage
	print_header "Top 5 CPU Processes"
	get_top_processes
}
main
