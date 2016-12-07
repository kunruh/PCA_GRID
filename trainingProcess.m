clear all;
close all;

%% Training - pca

%read in all 50 images for each type
%resize to 500x500
trainingSet = struct;
N = 100;
training_all = [];
classes = [];
for i=1:4
   fnames = dir(strcat('classifications/type',num2str(i),'/train/*.jpg'));
   num = length(fnames);
   s = zeros(N*N,num);
   for j=1:num
       img = imread(fnames(j).name);
       img = rgb2gray(img);
       img = imresize(img,[N N]);
       img = reshape(img,[N*N 1]);
       img2 = double(img);
       img2 = img2 ./ 255;
       s(:,j) = img2;
       classes = [classes; i];
   end
   training_all = [training_all s];
end
trainingStruct.data = training_all;
trainingStruct.classes = classes;

save trainingSet.mat trainingStruct
%% Testing Data
testS_all = [];
test_classes_true  = [];
for i=1:4
   fnames = dir(strcat('classifications/type',num2str(i),'/test/*.jpg'));
   num = length(fnames);
   s = zeros(N*N,num);
   for j=1:num
       img = imread(fnames(j).name);
       img = rgb2gray(img);
       img = imresize(img,[N N]);
       img = reshape(img,[N*N 1]);
       img2 = double(img);
       img2 = img2 ./ 255;
       s(:,j) = img2;
       test_classes_true = [test_classes_true; i];
   end
   testS_all = [testS_all s];
end
test_struct = struct;
test_struct.data = testS_all;
test_struct.classes = test_classes_true;

save testingSet.mat test_struct

%% Validation Data
validS_all = [];
valid_classes_true  = [];
for i=1:4
   fnames = dir(strcat('classifications/type',num2str(i),'/validate/*.jpg'));
   num = length(fnames);
   s = zeros(N*N,num);
   for j=1:num
       img = imread(fnames(j).name);
       img = rgb2gray(img);
       img = imresize(img,[N N]);
       img = reshape(img,[N*N 1]);
       img2 = double(img);
       img2 = img2 ./ 255;
       s(:,j) = img2;
       valid_classes_true = [valid_classes_true; i];
   end
   validS_all = [validS_all s];
end
valid_struct = struct;
valid_struct.data = validS_all;
valid_struct.classes = valid_classes_true;

save validateSet.mat valid_struct


% tic;
% [coeff, score, latent, tsquared, explained] = pca(S_all,'Algorithm','svd','Centered',true);
% toc

% dims = round(0.25*length(conds));
% newSet = score(:,1:dims)*transpose(coeff(:,1:dims));
% 
% trainingSet.avgK = sum(conds)/length(conds);
% trainingSet.sigmaK = sqrt(sum((conds-trainingSet.avgK).^2)/length(conds));
% trainingSet.classes = classes;
% trainingSet.coeff = coeff;
% trainingSet.score = score;
% trainingSet.latent = latent;
% trainingSet.tsquared = tsquared;
% trainingSet.explained = explained;
% trainingSet.newSet = newSet;
% 
% save trainingSet.mat trainingSet

%% Training - Multiple Discriminant Analysis

% xbar1 = sum(newSet(1:50,:))/50;
% xbar2 = sum(newSet(51:100,:))/50;
% xbar3 = sum(newSet(101:150,:))/50;
% xbar4 = sum(newSet(151:200,:))/50;
% xbarTotal = (xbar1+xbar2+xbar3+xbar4)/4;
% 
% SW1 = (newSet(1:50,:)-ones(50,1)*xbar1)*(newSet(1:50,:)-ones(50,1)*xbar1)';
% SW2 = (newSet(51:100,:)-ones(50,1)*xbar2)*(newSet(51:100,:)-ones(50,1)*xbar2)';
% SW3 = (newSet(101:150,:)-ones(50,1)*xbar3)*(newSet(101:150,:)-ones(50,1)*xbar3)';
% SW4 = (newSet(151:200,:)-ones(50,1)*xbar4)*(newSet(151:200,:)-ones(50,1)*xbar4)';
% 
% SigmaW = SW1+SW2+SW3+SW4;
% SigmaB = zeros(size(SigmaW));
% SigmaB = SigmaB + ones(50,50)*((xbar1-xbarTotal)*(xbar1-xbarTotal)' +...
%                                (xbar2-xbarTotal)*(xbar2-xbarTotal)' +...
%                                (xbar3-xbarTotal)*(xbar3-xbarTotal)' +...
%                                (xbar4-xbarTotal)*(xbar4-xbarTotal)');
% 
% 
% [eigVectors, eigValues] = eig(SigmaB, SigmaW);
% eigValues = diag(eigValues);
% [c, ind] = sort(eigValues,'descend');
% eigVectors = eigVectors(:,ind);
% 
% 
% %% Testing
% 
% %read in test images
% N = 100;
% validS_all = [];
% valid_classes_true  = [];
% test_classes_guess = [];
% dims = 20;
% for i=1:4
%    fnames = dir(strcat('classifications/type',num2str(i),'/test/*.jpg'));
%    num = length(fnames);
%    s = zeros(num,N*N);
%    type = struct;
%    for j=1:num
%        img = imread(fnames(j).name);
%        img = rgb2gray(img);
%        img = imresize(img,[N N]);
%        img = reshape(img,[1 N*N]);
%        s(j,:) = img;
%        valid_classes_true = [valid_classes_true; i];
%    end
%    validS_all = [validS_all;s];
% end
% 
% %classify
% for i = 1:size(validS_all,1)
%    img = validS_all(i,:); 
%     
% end
% 
% 
% 
