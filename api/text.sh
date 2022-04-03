#!/bin/bash

#while getopts ...; do
#  ...
#done

VALID_ARGS=$(getopt -o : --long alpha,beta,gamma:,delta: -- "$@")

echo "${VALID_ARGS}"
