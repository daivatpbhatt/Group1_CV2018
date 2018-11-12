function [ftc,estimatedHeights] = CalibrateP2H(filename,imageWidth, imageHeight,ftc0)

options = optimset('Algorithm','levenberg-marquardt',...
    'MaxFunEvals', 1e6, ...
    'MaxIter', 1e5, ...
    'TolFun', 1e-10);

rawPoints = dlmread(filename,'\t',1);
xf = (rawPoints(:,4) - 0.5*imageWidth)/imageWidth;
xh = (rawPoints(:,2) - 0.5*imageWidth)/imageWidth;

yf = (0.5*imageHeight - rawPoints(:,5))/imageWidth;
yh = (0.5*imageHeight - rawPoints(:,3))/imageWidth;

h = rawPoints(:,6)/100;

hf2h = @(x,xdata)pointsToHeight(x,xdata);

[ftc,~,~,~,~,~,~] = lsqcurvefit(hf2h,ftc0,[yf yh], h,[],[],options);

estimatedHeights = pointsToHeight(ftc,[yf yh]);
