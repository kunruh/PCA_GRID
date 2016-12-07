clear all;
close all;

%% Testing Process

load trainingSet

N = 500;

%for i=1:4
   fnames = dir(strcat('classifications/type',num2str(2),'/test/*.jpg'));
   num = length(fnames);
%    for j=1:num
%        img = double(imread(fnames(j).name));
%        img = rgb2gray(img);
%        img = imresize(img,[N N]);
%        k = norm(img)*norm(pinv(img));
%    end

img = imread(fnames(1).name);
img = rgb2gray(img);
img = imresize(img,[N N]);


   
   
%end
