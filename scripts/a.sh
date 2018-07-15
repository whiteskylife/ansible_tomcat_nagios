#!/bin/bash

log_path="/data/test_ansible/"
echo "hello world !"
for i in {1..10}
do
    /bin/mkdir -p "$log_path""$i" 
done
