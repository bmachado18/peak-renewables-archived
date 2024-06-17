#!/bin/bash
#SBATCH --gres=gpu:2
#SBATCH --cpus-per-task=6
#SBATCH --mem=32000M
#SBATCH --time=8:00:00
#SBATCH --account=def-doyle
#SBATCH --mail-user=bmachado@selkirk.ca
#SBATCH --mail-type=ALL

export PROJ=~/projects/def-doyle/bmachado/peak_renewables

# Preparing the Environment
# TODO: make one module for everything needed

module purge # clear the node

module load python/3.10 scipy-stack
module load nixpkgs/16.09 intel/2016.4 cuda/8.0.44 torch/20171030 #pytorch and prereqs
module load StdEnv/2020 gcc/9.3.0 opencv/4.8.0 #opencv and prereqs

virtualenv --no-download $SLURM_TMPDIR/VENV

source $SLURM_TMPDIR/VENV/bin/activate #activating new env

pip install --no-index --upgrade pip #upgrading pip to latest version available

#TODO: clone git repo everytime to guarantee latest version, and also update config files

cd $PROJ/yolov5

pip install --no-index -r requirements_dra.txt #modified requirements with up-to-date wheels

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

#TODO: it would be nice not to copy the directory each time, but rather use the cloned repo (from the last TODO)
cp -R $PROJ/yolov5 .

#-------------------------------------------------------------------------------------------

# Start Training

cd yolov5

start_time=`date '+%s'`

mkdir $PROJ/data/output/job-$SLURM_JOB_ID


#TODO: could save genetic anchor 
python train.py --img 640 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5m.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-train-$SLURM_JOB_ID --hyp data/hyps/no-augmentation.yaml --freeze 23


end_time=`date '+%s'`
train_time= expr $end_time - $start_time

#TODO: don't save the logging results from training, save the results from testing. need to save the weights however

#-------------------------------------------------------------------------------------------

# Use Results from Training for Testing

cd $PROJ/data/output/job-$SLURM_JOB_ID/yolov5-train-$SLURM_JOB_ID

cp ./weights/best.pt $SLURM_TMPDIR/yolov5

cd $SLURM_TMPDIR/yolov5

start_time=`date '+%s'`

python val.py --batch-size 32 --task test --img 640 --data wood_defects_1.yaml --weights best.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-test-$SLURM_JOB_ID 

end_time=`date '+%s'`
test_time= expr $end_time - $start_time

#Logging resource results to drac_logfile_$SLURM_JOB_ID.txt

cd $PROJ/data/output

# moving offline comet info to output
mv -r $SLURM_TMPDIR/yolov5/.cometml-runs/*.zip ./job-$SLURM_JOB_ID

# adding slurm job info to logfile
scontrol show job $SLURM_JOB_ID > drac_logfile_$SLURM_JOB_ID.txt

# Moving created logfile to job directory
mv drac_logfile_$SLURM_JOB_ID.txt ./job-$SLURM_JOB_ID

# Moving stdout and stderror file to job directory
mv ../../jobs/slurm-$SLURM_JOB_ID.out ./job-$SLURM_JOB_ID

echo "----------------------------------------" | tee -a drac_logfile_$SLURM_JOB_ID.txt
echo "using test_freeze_all_classes.sh" | tee -a drac_logfile_$SLURM_JOB_ID.txt
#echo "Total Training Time: " | tee -a drac_logfile_$SLURM_JOB_ID.txt
#echo $train_time | tee -a drac_logfile_$SLURM_JOB_ID.txt
#echo "Total Test Time: " | tee -a drac_logfile_$SLURM_JOB_ID.txt
#echo $test_time | tee -a drac_logfile_$SLURM_JOB_ID.txt

