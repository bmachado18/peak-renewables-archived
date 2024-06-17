#!/bin/bash
#SBATCH --gres=gpu:1
#SBATCH --cpus-per-task=3
#SBATCH --mem=32000M
#SBATCH --time=2:00:00
#SBATCH --account=def-doyle

SOURCEDIR= ~/peak_renewables

#prepare venv

module purge

module load python/3.10 scipy-stack nixpkgs/16.09 intel/2016.4 cuda/8.0.44 torch/20171030 StdEnv/2020 gcc/9.3.0 opencv/4.8.0 


virtualenv --no-download $SLURM_TMPDIR/ENV

source $SLURM_TMPDIR/ENV/bin/activate

cd ~/projects/def-doyle/bmachado/peak_renewables/yolov5

pip install --no-index ultralytics-8.0.132-py3-none-any.whl

pip install --no-index -r requirements.txt

#prepare data
#temp directory uses ssd which is much faster
cd $SLURM_TMPDIR
tar -xvf ~/projects/def-doyle/bmachado/peak_renewables/data/datasets.tar

cp -R ~/projects/def-doyle/bmachado/peak_renewables/yolov5 .

cd yolov5

# Start Training
python train.py --img 1280 --batch-size 48 --epochs 500 --data wood_defects_1.yaml --weights yolov5s.pt --freeze 23 --name yolo_output

cd ./runs/train/yolo_output

cp -R . ~/projects/def-doyle/bmachado/peak_renewables/data/output
