clear all
close all

%% load
path = 'G:\SEAS-AU\SEMESTER-7\Computer Vision 2018\Project\Data\Capture Images for calibration\data\human';

PersonHeightEstFileName = {'001','002'};
PersonHeightO = [1.6700; 1.7270];
FolderName = {'01'};
cameraWidthHeight = {[1920 1080]};
    
ExportedparaFileName = '01';

mean_height_all_person = cell(length(PersonHeightEstFileName), length(FolderName));
std_height_all_person = cell(length(PersonHeightEstFileName), length(FolderName));

Est_height_all_person =[];
O_height_all_person =[];

all_error =[];
all_y_coordinate =[];
all_x_coordinate =[];

for i = 1:length(FolderName)
% for camIdx = 1:1
    %% load cam parameters
    FolderName_ID = FolderName{i};
    WidthHeight = cameraWidthHeight{i};
    width = WidthHeight(1);
    height = WidthHeight(2);
    ExportedparaFileName = [path '\' FolderName_ID '\' ExportedparaFileName '.mat'];
    load(ExportedparaFileName);
        
    %% compute for each subject
    for j = 1:length(PersonHeightEstFileName)
        
        
        testPersonID = PersonHeightEstFileName{j};
        ptFileName = [path '\' FolderName_ID '\' testPersonID '.txt'];
        
        if ~exist(ptFileName,'file')
            continue;
        end
        
        Image_coordinates = dlmread(ptFileName,'\t',1);
        xf = (Image_coordinates(:,4) - 0.5*width)/width;
        xh = (Image_coordinates(:,2) - 0.5*width)/width;
        
        yf = (0.5*height - Image_coordinates(:,5))/width;
        yh = (0.5*height - Image_coordinates(:,3))/width;
        
        estimatedHeights = pointsToHeight(ftc,[yf yh]);
                
        mean_height_all_person{j,i} = mean(estimatedHeights);
        std_height_all_person{j,i} = std(estimatedHeights);
        
        Est_height_all_person = [Est_height_all_person;mean(estimatedHeights)*100];
        O_height_all_person = [O_height_all_person;Image_coordinates(1,6)];
        
        all_error = [all_error;estimatedHeights*100-Image_coordinates(:,6)];
        all_y_coordinate = [all_y_coordinate;yf];
        all_x_coordinate = [all_x_coordinate;xf];
        
    end 
end


% Error distribution
figure;
axes('FontSize',13);
hist(Est_height_all_person-O_height_all_person, 30);

title({'Distribition of estimated height error (cm)';'in walking human based evaluation'})
xlabel('Height error (cm)')
ylabel('Number of subjects')

figure;
scatter(all_y_coordinate*1080, all_error);hold on
title({'Correlation between height estimation error (cm) ','and y-coordinates(foot position)'})
xlabel('y-coordinate in image')
ylabel('Height estimation error (cm)')


figure; hold on
scatter(all_x_coordinate*1920, all_error);
title({'Correlation between height estimation error (cm)',' and x-coordinates(foot position)'})
xlabel('x-coordinate in image')
ylabel('Height estimation error (cm)')

mae = mean(abs(Est_height_all_person-O_height_all_person))
mae_r = mae/mean(PersonHeightO)

accuracy = 1 - mae_r/100
