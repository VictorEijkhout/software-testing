#!/bin/bash

# submission line for Vista Hopper gpus
make totalclean 
make gpusleep
make script submit QUEUE=gh-dev EXECUTABLE=example_gpu_launcher NODES=2 CORESPERNODE=1
