#!/bin/bash
#SBATCH --job-name=test_yolov5_jobs
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=3
#SBATCH --mem=32000M
#SBATCH --time=0:10:00
#SBATCH --account=def-doyle


SOURCEDIR=home/bmachado/projects/def-doyle/bmachado/peak_renewables

#prepare venv
module purge
module load python/3.11 scipy-stack
source ~/yolov5/bin/activate

cd ~/home/bmachado/projects/def-doyle/bmachado/peak_renewables/yolov5

# try detecting
python detect.py --weights yolov5s.pt source ../data/test_data/*

#results are saved to ./runs/detect
