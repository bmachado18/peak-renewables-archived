# Notes

## 2023-05-25

Notes on weekly update:

- create validation function to assess accuracy( script)
% match, true or val 
- meet with Jonathan next week to show the notebooks

- NEED TO ORDER CAMERA NEXT WEEK

## 2023-05-26 - Camera Research

 - I asked chatGPT to give me some industrial grade cameras.
 - The goal is to get an idea of what specs are standard as these are pretty pricy:

1. Basler Ace: https://www.baslerweb.com/en/products/cameras/area-scan-cameras/ace/aca1280-60gc/#specs
419.00 USD

   - Sensor:
        Sensor Vendor	e2v
        Sensor	EV76C560
        Shutter:	Rolling Shutter
        Sensor Format:	1/1.8''
        Sensor Type:	CMOS
        Sensor Size	6.8 mm x 5.4 mm
        Resolution (HxV)	1280 px x 1024 px
        Resolution	1.3 MP
        Pixel Size (H x V)	5.3 µm x 5.3 µm
        Frame Rate	60 fps
        Mono/Color	Color
   - Camera Data:
        Interface	GigE
        Pixel Bit Depth	12 bits
        Synchronization	
        hardware trigger
        free-run
        Ethernet connection
        Exposure Control	
        programmable via the camera API
        Digital Input	1
        Digital Output	1
        Power Supply	
        PoE or 12 VDC
        Power Requirements (typical)	2 W
        Power Consumption PoE	2.6 W

1. LIR Blackfly S: https://www.edmundoptics.com/p/BFS-U3-63S4C-C-USB3-Blackflyreg-S-Color-Camera/40166?gclid=Cj0KCQjwjryjBhD0ARIsAMLvnF8DYCd7e6ffoWDrCuOpRHcWEJ2_wdZ8WzBJyV9eYT-Y8cA72151azQaAugNEALw_wcB
   C$721.00

Image Buffer: 240MB
Type of Sensor: Progressive Scan CMOS
Camera Sensor Format: 1/1.8"
Pixels (H x V): 3,072 x 2,048
Sensing Area, H x V (mm): 7.37 x 4.92
Power Consumption (W): 3
Synchronization: Hardware Trigger (GPIO) or Software Trigger
Machine Vision Standard: USB3 Vision v1.0
Frame Rate (fps): 59.60
Pixel Size, H x V (μm): 2.4 x 2.4
Type of Shutter: Rolling
Resolution (MegaPixels): 6.30


1. IDS Imaging Cameras
   https://www.ids-imaging.us/ueye-industrial-cameras.html#ueye-warp10

   https://www.oemcameras.com/dmk23up1300.htm
   
   
## 2023-05-29 - Continuing camera research

As reported by [2], the equipment specs for the self-developed vision system setups was:
1. On a conveyor moving 9.6m/s
1. a trilinear line scan camera manufactured by JAI ()
2. camera was 3x4096 pixels per line at 66kHz
3. interfaced to a camera link frame grabber (pCIe)
4. ROI (Board) was width of 15cm and full 500cm length grabbed by using a line scan camera lens with 50mm focal length
5. distance was 40cm above measured boejct
6. leading to horizontal resolution of 16.66 pixel/mm
7. vertical resolution was computed with special formula (in our case vertical resolution will be variable too because board might end halfway
8. shutter of cammera was 2us
9. used a power light source  (light bar), no color


- I forgot that we had a previous MV project (Kalesnikoff Board flip)
- "Basler camera" - this could be the same camera as the basler ace from yesterdays notes.
- There is nothing on the exact model, but I think that USB is preferred over gigE.
- Not sure what resolution is too little, need to as john
- https://www.baslerweb.com/en/products/cameras/area-scan-cameras/ace/#st_series_overview

### Found a good site:
https://www.industrial-camera.com/

- frames per second = image per second. 15 fps is sufficient
- modern CMOS cameras match CCD and are easier to integrate/lower price.
- CMOS is always rolling shutter. Means lines are taken from top to bottom. electronic shutter is better but doesnt work with CMOS. global shutter is the best
  
  - Could we use a black and white (mono) camera rather than a color camera? according to this resource, mono color is more suitable for mv applications because analysis is typically done on intensity. template matching would be fine without color, because I used black and white and it works well

  - usb cameras are not fitted with lenses (USB 2.0 that is) (based on C mount or CS mount standard)
  - bw: 
  - USB advantages: low price, easy handling, reasonable priced accessories. 
  - USB disadvantages: max length of cable is 5m. concentration on windows (more info at programming interface)

  - Firewire cameras bw: 400Mbps and 800bps
  - advantages: independence of windows (registers level interface)
  - robust power supply
  - cable length max is 10m
  - disadvantage: market dominated by USB 2.0 so many pcs not fitted with firewire, has most support with windows

- gigE: gigabit ethernet -> network cameras
- advantages: widespread availability, long cables, high bandwidth
- disadvantages: extra power supply, high power consumption, no open standard (interfaces is trademarked, so no open source drivers)

- need to choose a suitable lens

- machine vision components: illumination optics, industrial camera, computer, software

- The importance of suitable illumination is not only true for machine vision applications, but wherever cameras are used. A typical example are professional photo studios. Here, the dominating devices are not cameras, but the various types of illumination.

industrial cameras have no lens - they have a cmount
selecting a lens:

-** working distance** is the distance between the object and the leading edge of the lens
- every lens has a minimum object distance (MOD). can use extension rings to increase this

- **focal length** calculated by:
  1. the size of the object
  2. the distance between the object and the lenses leading edge
  3. the size of the sensor, expressed as the format (https://www.industrial-camera.com/format.htm)
   how to calculate: https://industrialcamera.wordpress.com/lenses-for-industrial-cameras/

   interfaces: https://www.industrial-camera.com/programming-interface.htm

### Illumination

lighting techniques: https://www.baslerweb.com/en/sales-support/tools/lighting-advisor/#step=1;gf=%7B%22a2s4q1%22%3A%5B%22flashing%22%5D%7D

Transmitted light: lights shining under the camera, so object appears darkest in the image
- I dont think this is what we want since for opaque objects, outline is only visible

Dark Field: used to detect edges/surface defects. light is facing 90 degrees to the surface
 - this is my fave option, edges are strongly evident. not sure if wood grains would show though.

Incident light (bright field): defined by position of mount, ligth and camrea are on same side to object, so light is reflected from surface of the object. good for low-reflection objects
- also a good option. the example shows a lot of background, so idk if its the best

lighting types:
 - bar lights:  produce narrow strip of light - what we want
 - dark field lighting: good for uniform illumination for all sides - this is what we are aiming for?
 - spot lights: good for large working distances

 - ring lights: not suitable for highlighting surface defects

 - dark field light option: Basler Standard Light Darkfield-50OD-W ($589.00)
 - https://www.baslerweb.com/en/products/basler-lighting/basler-standard-light-darkfield-50od-w/

- transfers data via BSL
 - 
- incident light option: Basler Standard Light Bar-10x100-White ($269.00)

- It would be nice to have all the same equipment, but 

### Options for industrial cameras:

### Notes on event system design:

The whole system is an "embedded system". Specifically, this is a process control system using machine vision.

Possible microprocessors that are commonly used for image analysis tasks with CNNs:
1. NVIDIA Jetson Series
2. Raspberry Pi
3. Intel Neural Compute Stick
4. Qualcomm Snapdragon
5. Xilinx Zynq
6. Arduino Portenta H7


## 2023-05-31

### For Camera:

I need some more guidance on camera stuff.

1. USB or Gig-E?
   
- USB easier, drivers open (more expensive though). Gig-E has and longer cables, but no open source drivers?
  
1. is power consumption a big factor?
   
2. fps?
   
   - one of my resources say 15 fps sufficient, but these cameras are absurdly high ( up to 700 fps).
   - too high of an fps means we would need a fast way to process images
   - don't really need smooth videos

3. mono or color?
   
  - Could we use a black and white (mono) camera rather than a color camera? according to this resource, mono color is more suitable for mv applications because analysis is typically done on intensity.
  - Since there is no major price difference between mono and color cameras, might be best not to limit in case color analysis is helpful.

  
4. Resolution?
   
   from my understanding, the higher resolution, the better. However higher resolution means more processing. studies vary in resolution:
   [2] uses 1024x4096
   [3] not listed
   [4] uses 608x608
   [5] not listed
   [6] uses 658x498 (iEEE)

5. dark field light or bar light?

- show demo on coin: https://www.baslerweb.com/en/sales-support/tools/lighting-advisor/#step=1;gf=%7B%22a2s4q1%22%3A%5B%22flashing%22%5D%7D
lightbar: Basler Standard Light Darkfield-50OD-W - Basler Light: https://www.baslerweb.com/en/products/basler-lighting/basler-standard-light-darkfield-50od-w/
- communicates via BSL cable

- unfortunately requires to buy the controller aswell.

Basler Ace: https://www.baslerweb.com/en/products/cameras/area-scan-cameras/ace/#st_series_overview

(549$ USD) high fps(200), color: https://www.baslerweb.com/en/products/cameras/area-scan-cameras/ace/aca1300-200uc/


1. for lens, I need an estimated distance
   second study was like 15 cm.
2. What about the microprocessor? if using usbs raspberry pi best. otherwise see above options (asked chatGPT, but super expensive!)

## 2023-06-01

https://www.baslerweb.com/en/sales-support/tools/vision-system-configurator/#/

https://www.baslerweb.com/en/sales-support/tools/lens-selector/


($549.00 USD) https://www.baslerweb.com/en/products/cameras/area-scan-cameras/ace/aca1300-200uc/
   ($6.41 USD) https://www.baslerweb.com/en/products/accessories-and-bundles/camera-bracket-360-90/
   ($37.50 USD) https://www.baslerweb.com/en/products/cable/basler-cable-usb-3-0-micro-b-sl-a-p-3-m/
   

($136.00 USD) https://www.baslerweb.com/en/products/lenses/fixed-focal-lenses/basler-lens-c23-0824-5m-p-f8mm/

($589.00 USD) https://www.baslerweb.com/en/products/basler-lighting/basler-standard-light-darkfield-50od-w/

   ($112.50 USD) https://www.baslerweb.com/en/products/basler-lighting/power-supply-24v-40w-for-bcl/
   ($76.85 USD) https://www.baslerweb.com/en/products/basler-lighting/bsl-camera-mount-ring-120od/
   ($33.29 USD) https://www.baslerweb.com/en/products/basler-lighting/bsl-cable-m8-2m-tilted/
   

($499.00 USD) https://www.baslerweb.com/en/products/basler-lighting/basler-slp-strobe-controller-121040/
   ($112.50 USD) https://www.baslerweb.com/en/products/basler-lighting/power-supply-24v-40w-for-bcl/


Need to consider NUC or pi with google coral or jetsons.

So it turns out that we MUST look at all edges of the board.

notes on paper: strength prediction local fiber directions from laser scanning

## 06-12-2023

order by the end of the week

Lori coming in wednesday with Tyrone, 10:00 or 11:00

possibly grabbing lunch

overview of research
different approaches
small demo


demo something working with the board unfolding

TODO:
- Understand YOLO Architecture
- Learn how to use DRA clusters
- stitching/unfolding via image processing

started at 9:48:

add flag for output name


Meeting:

1. This week, I had a panic attack when reviewing test results and seeing the ground truth labels not working
- james saved the day, paper had the wrong coordinats
2. After fixing that, I successfully trained a quick model that is decent and detecting knots.
3. I then wrote a bunch of documentation on setting up python virtual environments on the DRA

4. Lastly, I created an account with an neural net analytics platform called comet. I can now monitor training
5. going to try to deploy yolov5 on the jetson. Need to order camera, then this board unfolding thing.


check if prometheus supports deep learning monitoring (graffana has a gui for it)

create meeting next week for ML to talk about performance metrics, pytorch support. talk about it next week


TODO:
- Assign meeting for ML
- Creating a script that properly utilizes the temproary directories and logs all pertinent information on teach train/test session
- map out how an algorithm can interpret the yolov5 output and other key functions
- prometheus??
- quiz #3
- quiz #4
- coop competency assessment
- record oral presentation

### What is the best way for the logs to be organized??

Need a logging method that can be used in the future

1. Training Logs

 - current date/time
 - comet-ml link with all performance metrics, where the experiment is named "Yolov5-SLURM%ID" - for offline need to save link
 - hyperparameters
 - resources allocated for the job.
 - total time for job
 - total time for training

 - total test time
 - testing metrics


2. Testing Logs

- current date/time
- testing date
- testing metrics

Slides must include: 

Your future (or current) position you seek to grow towards: ML Engineer

The necessary Skills, Knowledge and Attributes that are needed in that specific industry or position:

1. Strong Python Programming Skills
- Python or R
- efficient and scalable code for ml algorithms, data preprocessing, model evaluation
- TensorFlow, PyTorch, Scikit-learn, pandas
2. Mathematics and Statistics
- linear algebra
- calculus
- probability theory
- optimization algorithms
- all useful for fine tuning
3. AI safety and ethics
- My current domain knowledge revolves around object detection algorithms, particularly knot detection


Compare your current competency level and Identify the gaps

- I am decently competent in python, but have zero experience in R
- data wrangling is a big part of the coop I have done this far
- I need to improve at writing efficient and scalable code. I have made some big mistakes that sacrifise efficiency for personal learning
- Nothing for TensorFlow, very little PyTorch, mostly just sckit-learn and pandas

- I'm decent at linear algebra and calculus
- slightly lacking in probability theory; haven't quite memorized many of the concepts
- this make me better at deep learning but traditional machine learning lacks

- To work somwhere like Tesla, or x, need y and z.
- It's moreso about strong communication and research skills
- something that has gotten exponentially better as I've done this coop
- developing for sure


What do you need to be a success
- since the field is so vast and the these jobs apply to several domains, choosing one domain and sticking with it would be best.
- Utilizing the libraries is essential
- data management is an important factor as it speeds up the pipline of training/ testing.
- R project?

Create or set a goal and/or plan for yourself
- The main goal is to be proficient enough the ML world that just by communicating with somebody, the sucesses and pitfalls can be spun up quickly

SMART goals
Conclusions

Need to experiment with what the output is on an individual inference

plan of attack for 3D reconstruction:
1. deal with parrelax # ignore for now
2. compare first frame with second frame
3. experiment with multiview geometry to extract the depth of the difference surfaces of an image (epipoles)

manual stitch the board together

yann truet or dave: teaches multiview modelling with the drones

if knot detection okay, use 3d model of a good board and subtract distance

can check bash exit codes on each command during debugging

1. Run the numbers; W are joules/s
- Find literature values for wavelength/temp/speed
- find required speed
- calculate what is required

??????

2. Price out the full basler setup. two diasy chained slp controllers

price of SLP Controllers:

- $499.00 USD x2 = $998 USD

2 lights: https://shop.baslerweb.com/amer_en/basler-standard-light-ring-70od-white.html
- 329.00 USD x2 = $658.00 USD

2 cameras: [both usb and gig-e offered](https://shop.baslerweb.com/amer_en/aca1440-73gc.html)
- 429.00 USD x2 = $858.00 USD

2 lens: [4mm](https://shop.baslerweb.com/amer_en/basler-lens-c125-0418-5m-p-f4mm.html)
- 178.00 USD x2 = $356.00 USD

I guess we already have the jetson
total ~= 2870.00 USD = $3789.59 CAD

OTHER OPTION: 2 basler camera lights:

can have direct communication between basler ace u or ace l without an external controller

2x basler camera lights: https://shop.baslerweb.com/amer_en/basler-camera-light-ring-50od-white.html
- 629.00 USD x2 = 1258 CAD

new total without lights/controllers = $2270.00 USD = $3004.72 CAD

3. find alternative lights that are usb triggered

How?????'


make list fo usb driver and light source + driver

buy another camera asap

buy two continuous ring lights - later if odoesnt work use thorlabs light+driver

find basic strobe light

buy 2 ring lgihts from amazon contrinuous

2 strobe usb triggered lights

test to see

need longer ribbons - buy medium one from jetson to controller, then buy larger one for camera to 

FFC

fan  - dedicated 5V cooler that goes on jetson. something liek this: https://www.amazon.ca/Dedicated-Developer-Adjustment-40mm%C3%9740mm%C3%9720mm-Reverse-Proof/dp/B07TD2PCM5

is there a fa
camera mounts from amazon

buy 22$ case from amazon: https://www.amazon.ca/Jetson-Nano-Metal-Case-Fan-4010-5V/dp/B08PSYRZB4/ref=sr_1_1?crid=G17L8OCY71X8&keywords=jetson+nano+chassis&qid=1690485618&sprefix=jetson+nano+cassis%2Caps%2C317&sr=8-1

more microsd cards


which pip3

ls -lj /bin/pip 

never install python by source

deadsnakes => old default version python3.9 with apt

https://linuxize.com/post/how-to-install-python-3-8-on-ubuntu-18-04/

add deadsnakes repo

apt update

install python3.x

which pip -> gaurantees that pip install, mgight isntall parent pip

jons also orderin

links!


1x Camera: https://www.digikey.ca/en/products/detail/basler-inc/108329/13244079
Comes with:
- 0.2 m FFC cable, 15 pin, ZIF connector host/camera side (from camera to processor)
- 0.05 m FFC cable, 28 pin Hirose ZIF connector host/camera side, BCON for MIPI interface (from jetson to processor)

https://www.baslerweb.com/en/products/cable/cable-bcon-400mm/

https://www.digikey.ca/en/products/detail/molex/0150200840/2972762



2x USB LED Light rings (still deciding) https://www.amazon.ca/s?k=continous+led+light+ring+usb&crid=19UWR59Q6HGPG&sprefix=continous+led+light+ring+us%2Caps%2C141&ref=nb_sb_noss

1x Jetson Fan: https://www.amazon.ca/Dedicated-Developer-Adjustment-40mm%C3%9740mm%C3%9720mm-Reverse-Proof/dp/B07TD2PCM5

1x Jetson Nano Case: https://www.amazon.ca/Jetson-Nano-Metal-Case-Fan-4010-5V/dp/B08PSYRZB4/ref=sr_1_1?crid=G17L8OCY71X8&keywords=jetson%2Bnano%2Bchassis&qid=1690485618&sprefix=jetson%2Bnano%2Bcassis%2Caps%2C317&sr=8-1&th=1

1x Camera mount (1/4 ") https://www.amazon.ca/Heavy-Camera-Surface-Camcorders-Cameras/dp/B00CMLX1O2/ref=sr_1_24?crid=7EISL83WOCE9&keywords=camera%2Bmount&qid=1690823255&s=electronics&sprefix=camera%2Bmount%2Celectronics%2C151&sr=1-24&th=1

1x 32 gb drive https://www.digikey.ca/en/products/detail/delkin-devices-inc/USDCOEM-32GB/13882329

2x 64gb drive https://www.digikey.ca/en/products/detail/delkin-devices-inc/USDCOEM-64GB/18717637

1x Communication and GNSS Positioning Module for Jetson Nano: https://www.amazon.ca/SIM7600G-H-Communication-Positioning-Monitoring-Applicable/dp/B08CCWMFGT/ref=sr_1_3?crid=CC0YXLHXIJMJ&keywords=SIM7600G-H+4G+for+Jetson+Nano&qid=1690490276&sprefix=sim7600g-h+4g+for+jetson+nano%2Caps%2C133&sr=8-3

(this is the one they reccomend)

Ask jon if this looks correct:, ZIF??

12 inch (0.3 m) 15 pin  (camera to processor) https://www.digikey.ca/en/products/detail/molex/0150180853/13904612

4 inch (0.10m) 28 pin (processor to jetson) https://www.digikey.ca/en/products/detail/molex/0152670449/4427315

a couple 32 gb drives (currently in jetson now)? https://www.digikey.ca/en/products/detail/delkin-devices-inc/USDCOEM-32GB/13882329
should we just get bigger?

2x 

FIGURE OUT CONNECTORS


Did this week:

1. Decent model results, talked with rafe and ryan about performance emtrics
2. Reassess hardware configuration, particularly the lighting -> going to try continuous lighting first, skipping basler stuff
3. Pretty much bricked the jetson nano, so goign to reinstall os img
4. planning to order case, fan, mounts, some stuff

- stat is monday the 7th


- 
- 3D scan a shitty board in trail

all detection working -> 
save the building of 3D model for next proejct

goal is to present the detection of these things -> let 

- how exactly is the model trained? the training


- Going to ignore how the 3D model of the board is acquired. Going to focus on the algorithm involved in the decision of a good or bad.

- Still want to try to deploy YOLO on jetson - need some help, deadsnakes wasn't working (can't remember the error) - im on my own pretty much
- Almost ready to send Jon the links for ordering - still communicating with basler about the ribbon cable stuff. (don't wait for Jon - just send them an ID.)
- Need 3D models of boards -> should I go to STACK and scan some? (good and bad) -> Jon's planning on bringing someone else to stack anyway, so should hear about it soon.

- not working on wtr

- Questions:
- since I'm leaving the 3D model acquisition to the next coop, should I still continue working on the image stitching? no


notes on mL meeting:


receiving an exercise for the week on the performance metrics.

Metrics

missing accuracy = 

specificity = how many 

confidence thershold = hyperparameter


- hyperparameter evolution

precision => underfitting

recall => overfitting


dig more into repository regarding confidence


need higher precision than recall -> can't keep a board if it is actually not good enough.

better interpretation -> underfitting vs overfitting

look at these plots -> where are we underftting and where are we overfitting.

send links to Jonathan

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Preparation for meeting tomorrow: Where have I gotten to?

Since last meeting, what has been done?

Overall, We have trained the YOLOv5 model on the wood defect dataset, resulting in very exceptional test results. I cannot put a metrics on this result as I am currently researching this, but I'm happy to say that we are having success in using this model. I've only trained with 6000 out of the 20000 images, meaning we can get even better results as we increase the dataset and tweak the architecture some more.

This involved getting familiar with the digital research alliance high performance cluster. Essentially these are remote supercomputers that we are training on. You must schedule and allocate your required resources in advance, but I've finally created a pipeline that anyone can use to increase the data set size and schedule jobs for better training.

We've also done a decent amount of research on the illumination part, precisely the strobe vs continuous lighting. Strobe lighting is bset for our situation, but the price to chain lights together is costly -> we are going to experiment with continuous options and see if these are sufficient.

This week we are planning to head to stack and 3D scan all edges of the board. From the size of the board, we can model what a board without any wane is, and determine the difference between the perfect board and the input board -> this will be our wane detection plan.

note: live demo??? - tested on my webcam - for some reason does not detect any knots. clearly indicates overfitting of the data - but why??

- Trained Yolov5 with wood defect dataset
- used only 6000 out of 20000

- used DRA clusters
- almost finished a pipeline for training - just deteriming how to interpret and compare metrics

- this week we are ordering the rest of the stuff, lights, case, cables, fans, etc. 
- want to head to stack and scan all edge of board with 3D scanner.

- NEED TO CLEAN UP DOCUMENTATION TO GAURANTEE THAT OTHERS CAN PICK IT UP

- DOCUMENT CUDA IMEMORY SSUE, AND GENERALLY HOW TO USE YOLOV5

- found an issue with setting the batch size above the default of 32. Tried setting it to 48, and returning this error: 

  File "/localscratch/bmachado.8741006.0/VENV/lib/python3.10/site-packages/torch/nn/functional.py", line 2058, in silu
    return torch._C._nn.silu_(input)
torch.cuda.OutOfMemoryError: CUDA out of memory. Tried to allocate 1000.00 MiB (GPU 0; 11.91 GiB total capacity; 9.93 GiB already allocated; 767.62 MiB free; 10.18 GiB reserved in total by PyTorch) If reserved memory is >> allocated memory try setting max_split_size_mb to avoid fragmentation.  See documentation for Memory Management and PYTORCH_CUDA_ALLOC_CONF

- from research and experimenting with other parameters, changing the batch size back down is the solution.

- model is running well on webcam, I am able to display boards and it will identify defects! - job 8824021

- need to research 3D models

- weird thing is that I completely forgot to freeze the model - so why is the performance so much better?
- this could also be because I set a flag for having only a single class, which could definitely improve training.
- need to test freezing the backbone with the single class, doing this right now

- there was three changes I made to the training from last night:
1. forgot to freeze
2. single class
3. high augmentation

need to seperate and train with these individually!!!

first job: freezing vs no freezing
- take whichever performs best

second job: results of last job and single class
- take best from results of last job vs result from last job with single cls

third job: single class, medium aug

single class, high aug

take ebst for low, med, high augmentation

what did I do this week:

- Learned a bunch about performance metrics; goign to write about it in work term report, so it could be a possible resource in the future.

- Met with peak renewables, just gave them an update on what has been done so far

- new good results, mAP of 0.859 versus mAP of 0.396. Need to take a step back and figure out why!!!


3d libraries:
- pymesh
- libigl


- 6% variance within ttraining and test tells if overfitting or underfitting           

- plans this week
1. tidy up my documentation
2. add performance metric notes to bardshaw
3. make several jobs with different combos of stuff


16.5 banked total hours. Ideally would work 1-2 hours each day, so 2 hrs * 5 

If I can bank 2 hours tomorrow (8-5), 3 hours the next day (8-6), and 2 hours thurs (8-6), will have 7+16.5 = 23.5 hours

23.5 hours banked + 11.5 hours total remote = 33.5 hours

- I should also try to freeze just the backbone vs the backbone (0-9) and the head(11-24)

multipliers: yolov5 model; depth-multiple

yolov5n; 0.33 (less channels than yolov5s)
yolov5s; 0.33
yolov5m; 0.67
yolov5l; 1.0
yolov5x; 1.33

Question I had for the yoloV5:

Hello all! I'm doing transfer learning and freezing the weights and I've got a concern. During training from the CLI, If I was to freeze all layers except the output I would pass the -freeze 23 flag. Does this freeze all layers except the output regardless of the model size? Like since yolov5l has a depth-multiple of 1.0,  this would work, but for yolov5s the depth multiple is 0.33, so wouldn't there be less layers to freeze? If so, 23 layers total * 0.33  ~= 7.6 , therefore 7 layers should be frozen? Thanks!

answer from community: 

I believe it will work the same for all model scales. To be honest tho, I never tried. In your shoes, I would just run a 3 epoch training on a subset of my data (or the COCO128 dataset) and try freezing more layers for the larger models.

If you try, I'd be interested to hear how it goes and hear what you learn!

My theory is it is fine -> I've used the 30% model and freeing 23 layers of an 8 layer model would result in no learning (fully connected output is would have no weight adjustment), therefor going to leave it!!

prioritze 3D stuff while jon is around

seperates into connected components (subtrees)

once we have the wane, project onto a plane


messed up projects directory, so need to work on fixing that. 

predicament: freezing 23 layers when using smaller 

tested the augmentation + single class

single class gives much higher recall

more augmentation -> less recall!!!! -> need to try no-augmentation, didn't work for some reason!

today -> trying to interpret the board with pymesh

So many problems when trying to build and install pymesh. cannot find the issue

did this week:

   documentation on yolov5

   added DRA project folders to main peak renewables repo

   trying to fix a config error regarding where the data is pointing at (need to clone the folders). just give up!!! document

   also turns out that augmentation actually lowers recall. still need to document

   pymesh seems to be no longer maintained, so looking at open3D. CHECK OUT BRADS REPO!!

   so far i've got the model, got a bounding box. I want to convert the bounding box


   make a script that prompts the user for a file to inference, then determines if the board is good or bad.

   Need to update readme.md


   TODO: 

   1. I just modified the the traintest_yolov5.sh to account for the new folder strucutre. Test the traintest_yolov5.sh training script in interactvie job line by line to see if works as expected (low epochs)

   2. Once I get it working, update the rest of the training scripts and run all scripts again.

   3. determine why git is treating the data folder as a submodule 

   4. download ALL DATA and zip it up, then run training on all images.

   5. create function which can be used in console that can run the inference on a given image. returns the position of the bounding boxes relative to the closest edge.

train.py wasn't working in interactive mode, kept saying that utlralytics wasnt intsalled.

solution: redownload wheal for ultralyitics via pip download --no-deps ultralytics

running with no aug: python train.py --img 1280 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5l.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-train-$SLURM_JOB_ID --single-cls --hyp data/hyps/no-augmentation.yaml --freeze 23

python train.py --img 1280 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5l.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-train-$SLURM_JOB_ID --single-cls --hyp data/hyps/hyp.scratch-low.yaml --freeze 23

python train.py --img 1280 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5l.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-train-$SLURM_JOB_ID --single-cls --hyp data/hyps/hyp.scratch-med.yaml --freeze 23

python train.py --img 1280 --batch-size 32 --epochs 200 --data wood_defects_1.yaml --weights yolov5l.pt --project $PROJ/data/output/job-$SLURM_JOB_ID --name yolov5-train-$SLURM_JOB_ID --single-cls --hyp data/hyps/hyp.scratch-high.yaml --freeze 23

Running interactive job: salloc args

running batch job: sbatch script

improved how the output was saved so everything is easy to itnerpret. just rerunning all the augmentation tests bc why not.




currently rerunning all of the tests for augmentation but with new script, just

plan this week:

1. rerunning all of the augmentation tests with new script for better documentation.
2. updating the readme with all relevant info for future usage
3. creating a function to determine if the board is good or bad. can be used as function call or script
4. goign to download all the images throughout the week and trying to stuff as much data as possible for best results in training.
4. final documentation.
5. 3D orientation stuff.


put detection stuff on the backburner; focus mainly on the 3d wane detection stuff,

goal is to make it look like we completed both parts. they want a final presentation on what has been done/what needs to be done. can work with jonathan about that. they are under the impression that those two parts are complete, and what needs to be continued is the software and the physical setup!

unable to figure out how to rotate properly - goinng to use blender to hard code it.

blender does not support STL files without  import STL add-on

OPEN3d tutorial:

- what are point clouds
collection of points representating some object
- how to generate point clouds:
- laser scanners (what was done)

3d meshes
- structural build of a 3d model
- generated by point clouds
collection of verticies, edges, and faces represnting width hieght and depth

3d model:
- 3d image; 
code of 3d model is 3d mesh
3d model: texture and such

point cloud subset of 3d mesh wubset of 3d model

file formats:

I have successfully extracted the wane from the board. It uses a mix of open3d and blender, so would be nice to have one interface.

Planning on working on presentation for rest of day today and tomorrow. Possibly have something to show for the meeting.

should I prioritize having a functioning wane detection algorithm or a report??

report: who is the audience?

 communication points:

 demo/describe/illustrating how both techniques work.

 gives some statement on efficacy:

 represnt numbers in way that are human accessible.

 43 knots out of 45 knots. able to detect 96% of the knots in the test dataset.

 however at same time detect x amount of false positives. x/20+43=32% error, wrong with knots.

 impose scale on the board: assume scale: assume we have correct scaling 

 find out: calcualte scale if all 2x4s the same size ont he image. assumption: x and y scale same.assume xy scale.

 determine if there is a ratio for knots size/face size: impose a scale

 scan image, get surface + 3d scan: 

50, 75, 100, 125, 150, 200, 250, 300 /
9.5, 16, 22, 29, 35, 41, 48 ,51

0.19, 0.213, 0.22, 0.23, ...

therefor should be able to assume that knot cannot make up roughly over 20% of the entire board!!!

This week i've been grinding using open3D; trying to analyze, trying to subtract. got it working with combo of open3d/blender,
 but open3d's boolean_differnece function not working

 Working on a concise report for peak renewables. once that is done will finish presentation

 I've finish a  function to find if board is good or bad based on knot size, just doing edge one and that it will be done.

 Do a last ditch demo of obtaining the wane percentage via blender ui

 show wane for good and bad

 Presentation Notes:

Slide 1:
 - This presentation is a review of overal progress that has been achieved during my time at selkirk innovates on the peak renewables project. If I am going to fast or if you have any question, please let me know!

 Slide 2:
 - To begin, lets start with some context on the problem. 
 - a process at peak renewables is the fabrication of engineered finger-jointed studs. 
 - Deterimining if the offcuts are an acceptable grade is an important part of this process. 
 - as this is currently done manually, this process is a bottleneck in production as it can be strenuous and repetitive, leading to more error as hours continue.
 - therfor you came to us to help automate this process. to do so, three main criteria are considered in the grading of wooden boards.
 - firstly, the knot size cannot exceed roughly 50% of the respective face. 
 - as shown in the photo on the top right, since this knot makes up less than 20% of the boards surface, this is acceptable.
 - The knot position is the second piece of criteria. this involves deteriming if a knot is in the position of where finger joints will be cut out,
 - since the photo in the middle is in this region, this board would not be accepted.
 - lastly, the wane percentage is another criteria in this grading process. If the wane exceeds 50% of the total edge length then the board cannot be utilized. The board in the bottom photo is acceptable because its wane does not exceed 50%.

 Slide 3:
 - how exactly will we grade this lumber automatically?
 - as of now, as the lumber moves through the conveyor and the boards are manually inspected. 
 instead, a small space in the conveyor will be removed and two cameras in opposite corners of the convey will scan the board. The will result in a 3D model of the board with textures.
 - The 3D image will then be unfolded  into a series of 2D images, which will be ready to be processed by the knot detection algorithm.
 - 

 seperate slide7: use title slide or change yolo to bullet point

 indicate: changing threshold is senesitive because so much variation
 neural network is essentially testing all thresholds

SPS 1, which is what is currently on the wiki is for higher grade lumber; need to use SPS 3 and general handbook

SPS 3 contains knot specific info but it refers to the general handbook

310 linear feat/min