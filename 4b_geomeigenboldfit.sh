#!/bin/bash

source ~/work/python_cdrc/bin/activate
if [ $# -lt 2 ]; then
	echo "Usage: ./4b_geomeigenboldfit.sh <subj> <pre or post> #e.g. if subject is sub-001, write only 001 as input"
else
	python 4b_geomeigenboldfit.py $1 $2
fi
