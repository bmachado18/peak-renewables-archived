# peak-renewables

## Project Overview

​​Peak Renewables specializes in the fabrication of engineered wooden studs, using off cuts from other processes. With sustainability in mind, Peak uses an older finger joint machine with a manual quality selection process requiring 4-6 operators. Working with Selkirk Innovates, Peak intends to make this process more efficient and cost effective through machine vision and a control system. ​ 

According to the [NLGA SPS 1](https://nlga.org/wp-content/uploads/2023/03/NLGA-SPS-1-Mar-2023-Web.pdf), the maximum knot and hole sizes for studs are as follows:

| Board Nominal Width (inches) | Max Knot/Hole size (mm) |
|------------------------------|-------------------------|
|2|9.5|
|3|16|
|4|22|
|5|29|
|6|35|
|8|41|
|10|48|
|12|51|

Additionally, the wane on the sides of the board cannot exceed half the width along the edge at both ends of the board.

While a wooden stud moves through a linear belt conveyor, cameras would be set up to analyze all edges of the board, then a computer would determine if the board quality is sufficient or not. This would signal the conveyor down the line to bypass the rejected board, or keep the board for down the line for finger jointing.

If successful with a pass/fail inference on the particular board moving through the conveyor, a secondary goal would be to analyze how a defective board can be cut in a particular way to recover the failure while minimizing waste (and maybe even painting those cuts for the saw).

### Directory Description

- docs: a directory for all documentation related to the project
  - notebooks: a directory for all interactive python notebooks
    - cv_traditional_techniques: a directory for all interactive python notebooks regarding traditional techniques with OpenCV
    - ml_techniques: a directory for some notes on machine learning techniques
  - papers: a directory containing preliminary research
  - utils: a directory for all utility scripts
  - validate: a directory for scripts to validate performance
  - deep-learningbook-notes.md: a markdown file containing intro notes regarding deep learning and neural networks
  - glossary.md: a markdown file containing a glossary for typical nomenclature found in the research
  - notes.md: the markdown file with all notes taken throughout the project, including personal notes, todo lists, and meeting notes
  - yolov5_architecture.md: a markdown file containing simplified notes on how the YOLOv5 is structured
- DRA_knot_detection: a directory that contains all DRA related matter
  - data: directory where the tarballed data should exist, as well as the output
  - jobs: a directory contain all of the slurm job scripts
  - yolo_dependencies: a directory for all dependencies regarding yolov5
  - yolov5: a git submodule for yolov5 by ultralytics
- weights: a directory for the best weights to demo yolov5 all dependencies

### Resources

- [Peak Renewables Website](https://peakrenewables.ca/lumber-and-finger-joint-wood/)
- [NLGA SPS 1](https://nlga.org/wp-content/uploads/2023/03/NLGA-SPS-1-Mar-2023-Web.pdf)
- [NLGA Website](https://nlga.org/en/)
- [OpenCV with Python Tutorials](https://docs.opencv.org/4.x/d6/d00/tutorial_py_root.html)
- [Defect Dataset w/ 20,000+ images](https://zenodo.org/record/4694695)
- [DRA wiki](https://docs.alliancecan.ca/wiki/Technical_documentation)
- [Embedded Vision Kit Docs](https://docs.baslerweb.com/embedded-vision/daa4200-30mci-jnano-nvdk)
- [Basler OS](https://www.baslerweb.com/en/downloads/software-downloads/basler-camera-enablement-package-nvidia-jetson/)

## Detection Algorithm

Traditional computer vision techniques such as edge detection and feature extraction are explored in the folder docs/notebooks/cv_traditional_techniques.

We concluded that these methods are not robust enough to rely on. Therefor AI is explored, particular convolutional neural network with the goal of object detection.

Research (found in ./docs/paper/) shows the Residual Networks (ResNet) (via RetinaNet) and You Only Look Once (YOLO) appear to be the most favourable approaches.

Experimentation with the Yolov5 by Ultralytics is tested and explored (in ./docs/ml_techniques/.).

Since faster training requires powerful resources, the Digital Research Alliance Canada (DRAC) compute clusters are utilized.

### How to Train and Test YOLOv5 on the DRA Clusters

#### Containerize the dataset in proper format

1. fill the ```wood_images``` and ```bounding_boxes``` folders
2. run the ```labels_to_yolo.py``` utility script in ./docs/utils with your absolute paths
3. run the ```train_test_split.py``` utility script in ./docs/utils with your absolute paths and train/test/validate split
4. ensure that the filetree named ```datasets``` in the docs exists (and is empty) with the following yolov5 format:
```
	wood_defects_1
		images
			train
			test
			val
		labels
			train
			test
			val
```
5. tar the datasets folder together with the command:

```tar -cf ./datasets.tar ./datasets```

6. use scp or globus to transfer the tar file to the data directory, like so:

```scp ./datasets.tar cedar.computecanada:/home/bmachado/projects/def-doyle/bmachado/peak_renewables/data```

#### Run the job script

1. Modify any hyperparameters in the main job script ```peak_renewables/jobs/traintest_yolov5.sh```
2. modify any resources and notification email in the above job script
3. schedule the above job script as so:

```sbatch traintest_yolov5.sh```

The results will found in the ```peak_renewables/data/output/``` folder, in three folders: 
- ```yolov5-train-$SLURM_JOB_ID``` contains the training metrics
- ```yolov5-test_$SLURM_JOB_ID``` contains the testing metrics
- ```drac_logfile_$SLURM_JOB_ID``` contains the resource, hyperparameters, and duration of each task

The weights of the model would be found in ```yolov5-train-$SLURM_JOB_ID/weights/best.pt```