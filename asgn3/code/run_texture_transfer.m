clc;clear;close all;

targetImg = rgb2gray(imread('leonardo.jpg'));
inputImg = rgb2gray(imread('texture.jpg'));

alpha = 10;
szPatch = 5;
szOverlap = 4;
ifdebug = 0;
t2 = texture_transfer(inputImg, targetImg, alpha, szPatch, szOverlap, ifdebug);

figure(1)
imshow(inputImg);
figure(2)
imshow(targetImg);
figure(3)
imshow(t2, [])

