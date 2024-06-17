#!/usr/bin/env python

import argparse
import os
import torch
import pandas as pd
import cv2

def check_size(defects, image):
    img = cv2.imread(image)
    if not defects.empty:
        for _,defect in defects.iterrows():
            largest_prop = max((float(defect[2]) - float(defect[0]))/img.shape[1], (float(defect[3]) - float(defect[1]))/img.shape[0])
            if largest_prop > 0.20:
                return False
    return True


def check_edge(defects, image, edge_dist):
    img = cv2.imread(image)

    return True


def run(weights, image_p, edge_dist=9, save_res=False):
    model = torch.hub.load('ultralytics/yolov5', 'custom', path=weights) 

    results = model(image_p)

    if(save_res):
        results.save(save_dir='results')
    
    defects = results.pandas().xyxy[0]

    print(defects)

    if (check_size(defects, image_p) or check_edge(defects,image_p,edge_dist)):
        print("Board passes")
        exit
    else:
        print("Board has failed")


if __name__== "__main__":
    parser = argparse.ArgumentParser()

    parser.add_argument('--weights', type=str, default=os.path.join('weights','best.pt'), help='path to .pt file containing trained model weights')

    parser.add_argument('--image_p', type=str, default=os.path.join("images/test.bmp"), help='path to image to run inference on')
    
    parser.add_argument('--save_res', type=bool, default=False, help='save results')

    args = parser.parse_args()

    print(str(args))

    run(**vars(args))

