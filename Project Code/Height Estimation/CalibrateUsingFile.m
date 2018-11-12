clear all
close all
clc

width = 1920;
height = 1080;

%% calibration
path = 'G:\SEAS-AU\SEMESTER-7\Computer Vision 2018\Project\Data\Capture Images for calibration\data\human';

PersonHeightEst = '001';
ReqFileName = [path '\01\' PersonHeightEst '.txt'];
fileName = [PersonHeightEst '.txt'];

ftc0 = [1,-30,-2.5];

[ftc,estimatedHeights] = CalibrateP2H(ReqFileName, width, height,ftc0);

ExportparaFileName = [path '\01\01.mat'];
save(ExportparaFileName,'ftc');

%% result
% estimatedHeights
mean_height = mean(estimatedHeights)
error_std = std(estimatedHeights)
