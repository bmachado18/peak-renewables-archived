# Illumination Research

- To figure out the specification for our illumination setup, it is required to look at the specs of previous papers light sources.

**Searched: wood defect detection AND data acquisition**

## 1: Defect Detection of Industry Wood Veneer Based on NAS and Multi-Channel Mask R-CNN (2020)

https://doi.org/10.3390/s20164398

Does not mention illumination, but does use a light bar (no specs given)
- photoeletric sensor attached to gap of belt
- produced a pulse to the acquisiotn board of the computer, and two cameras start scanning the veneer
- when the wood veneer reached the gap, scanning process is stopped

## 2: A Fully Convolutional Neural Network for Wood Defect Location and Identification (2019)

https://doi.org/10.1109/ACCESS.2019.2937461

Does not mention illumination
- same idea as above, but  no light source

**Searched: wood defect detection AND yolov5**

## 3: Real-time detection of particleboard surface defects based on improved YOLOV5 target detection  (2021)

https://www.nature.com/articles/s41598-021-01084-x

- only mention "photoelectric sensor", using massive LED array

**Searched: wood defect detection**

## 4: Wood Defect Detection Based on Depth Extreme Learning Machine 

https://doi.org/10.3390/app10217488

- speed: 170Hz-5000Hz
- no mention of lighting or illumination

## 5: Wood defect detection method with PCA feature fusion and compressed sensing

https://link.springer.com/article/10.1007/s11676-015-0066-4

- two parallel LEDS were used for illumination. no information on specifications or model

**From my Paper bank:https://selkirkcollege-my.sharepoint.com/personal/jdoyle_selkirk_ca/_layouts/15/onedrive.aspx?ga=1&id=%2Fpersonal%2Fjdoyle%5Fselkirk%5Fca%2FDocuments%2FSelkirk%20Innovates%2Fadvanced%5Fcomputing%5Fprojects%2FPeakRenewables%2FPapers&view=0**

## 6: A large-scale image dataset of wood surface defects for automated vision-based quality control processes

- camera shutter 3us
- 9.6m/s
- camera acquitrd 4x4096 px per line at speed of 66 khz

- they selected a power light source, but constantly shined the light: linear LED light Corona II by Chromasens
https://chromasens.de/sites/default/files/download-media/PMA_CHR_CD40069_R05_Manual_Corona-II_XLC4.pdf
- spectral characteristics:
True Green? vs True Red vs True Blue???
- these cahracteristics make no sense - and they aren't even flashing it. whats the point.

## 7: An Aggressively Pruned CNN Model With Visual Attention for Near Real-Time Wood Defects Detection on Embedded Processors (2023)

- they use a different dataset the does not specify lighting for training
- does however inference on a setup similar to ours

- again no lighting :(

**None of these papers specify the lighting. need to find a different approach.**

- trying search: defect detection AND  "machine vision" and "Illumination", sorted by date
- nothing...


Started researching how to choose wavelength in general, and came across:
https://www.ni.com/en-ca/shop/choosing-the-right-hardware-for-your-vision-applications/a-practical-guide-to-machine-vision-lighting.html

- on the section ambient light contribution:

- Since we are enclosing a box around the region of interest, there is no ambient light to deal with
- says you can use high power strobing (flashing the light), or physical enclosures.
- therefor I believe we don't need to do both.

- on the other hand, better to strobe lights to reduce motion blur

