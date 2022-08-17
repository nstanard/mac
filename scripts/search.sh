#!/bin/bash

deep_search () {
    sudo find / -name "$1*" -path '*/.*'
} 
