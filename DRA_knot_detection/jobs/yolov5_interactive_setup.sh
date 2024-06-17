#!/bin/bash

module purge
module load python/3.10 scipy-stack
module load nixpks/16.09 intel/2016.4 cuda/8.0.44 torch/20171030
module load StdEnv/2020 gcc/9.3.0 opencv/4.8.0

virtualenv --no-download $SLURM_TMPDIR/ENV

source $SLURM_TMPDIR/ENV/bin/activate
cd $project/yolov5

