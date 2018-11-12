clear all
close all

width = 1920;
height = 1080;

%% load
path = 'G:\SEAS-AU\SEMESTER-7\Computer Vision 2018\Project\Data\Capture Images for calibration\data\human';
testPersonHeightEst = '002';

ExportedparaFileName = [path '\01\01.mat'];
PersonHeightEstFileName = [path '\01\' testPersonHeightEst '.txt'];
load(ExportedparaFileName);

ImageCoordinates = dlmread(PersonHeightEstFileName,'\t',1);
xf = (ImageCoordinates(:,4) - 0.5*width)/width;
xh = (ImageCoordinates(:,2) - 0.5*width)/width;

yf = (0.5*height - ImageCoordinates(:,5))/width;
yh = (0.5*height - ImageCoordinates(:,3))/width;

estimatedHeights = pointsToHeight(ftc,[yf yh])

mean_height = mean(estimatedHeights)
error_std = std(estimatedHeights)
