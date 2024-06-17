#!/bin/bash
#SBATCH --gres=gpu:2
#SBATCH --cpus-per-task=6
#SBATCH --mem=32000M
#SBATCH --time=8:00:00
#SBATCH --account=def-doyle
#SBATCH --mail-user=bmachado@selkirk.ca
#SBATCH --mail-type=ALL

export PROJ=~/projects/def-doyle/bmachado/peak-renewables/DRA_knot_detection

# Preparing the Environment
# TODO: make one module for everything needed

module purge # clear the node

module load python/3.8 scipy-stack
module load nixpkgs/16.09 intel/2016.4 cuda/8.0.44 torch/20171030 #pytorch and prereqs
module load StdEnv/2020 gcc/9.3.0 opencv/4.8.0 #opencv and prereqs

virtualenv --no-download $SLURM_TMPDIR/VENV

source $SLURM_TMPDIR/VENV/bin/activate #activating new env

pip install --no-index --upgrade pip #upgrading pip to latest version available


#------------------------------------------------------------------------------------
# Prepare Imported Data - Expecting data to be pre-processed in
# a tar file with the directories, place it in same directory as yolov5 repo
# datasets
#	wood_defects_1
#		images
#			train
#			test
#			val
#		labels
#			train
#			test
# 			val

cd $SLURM_TMPDIR # is this the right directory???
tar -xf $PROJ/data/datasets.tar

cp -R $PROJ/yolov5 .

cd yolov5

cp -r $PROJ/yolo_dependencies/* .

pip install --no-index -r requirements_dra.txt #modified requirements with up-to-date wheels

#-------------------------------------------------------------------------------------------

# Start Training

mkdir $PROJ/data/output/job-$SLURM_JOB_ID-$SLURM_JOB_NAME

export YOLO_OUT=~/projects/def-doyle/bmachado/peak-renewables/DRA_knot_detection/data/output/job-$SLURM_JOB_ID-$SLURM_JOB_NAME

mv ./wood_defects_1.yaml ./data/

#TODO: could save genetic anchor 
python train.py --img 1280 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5l.pt --project $YOLO_OUT --name training-res --single-cls --hyp data/hyps/hyp.scratch-med.yaml --freeze 23

#-------------------------------------------------------------------------------------------

# Use Results from Training for Testing

cd $YOLO_OUT/training-res 

cp ./weights/best.pt $SLURM_TMPDIR/yolov5

cd $SLURM_TMPDIR/yolov5

python val.py --single-cls --batch-size 32 --task test --img 1280 --data wood_defects_1.yaml --weights best.pt --project $YOLO_OUT --name test-res


#Logging resource results to drac_logfile_$SLURM_JOB_ID.txt

cd $PROJ/data/output

# moving offline comet info to output
mv $SLURM_TMPDIR/yolov5/.cometml-runs/*.zip $YOLO_OUT

# Moving created logfile to job directory
mv drac_logfile_$SLURM_JOB_ID.txt ./job-$SLURM_JOB_ID

# Moving stdout and stderror file to job directory: doesn't work, need to manually map this
#mv $PROJ/jobs/slurm-$SLURM_JOB_ID.out $YOLO_OUT

cd $YOLO_OUT

# adding slurm job info to logfile
scontrol show job $SLURM_JOB_ID > drac_logfile_$SLURM_JOB_ID.txt
echo "----------------------------------------" | tee -a drac_logfile_$SLURM_JOB_ID.txt
echo "using $SLURM_JOB_NAME" | tee -a drac_logfile_$SLURM_JOB_ID.txt
