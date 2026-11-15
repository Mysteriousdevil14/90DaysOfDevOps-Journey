#!/bin/bash
use_local(){
	local var="local_value"
	echo "Inside function (local): $var"
}
use_global(){
        var="global_value"
        echo "Inside function (global): $var"
}
use_local
use_global
echo "Outside after local function: $var"
echo "Outside after global function: $var"
