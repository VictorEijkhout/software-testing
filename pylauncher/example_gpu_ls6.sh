#!/bin/bash

# submission line for frontera RTX gpus
make totalclean 
make gpusleep
make script submit QUEUE=gpu-a11 EXECUTABLE=example_gpu_launcher NODES=2 
