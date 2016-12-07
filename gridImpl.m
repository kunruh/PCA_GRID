clear all;
close all;

load trainingSet.mat

trainingData = trainingStruct.data';
trainingClasses = trainingStruct.classes';

trainingData1 = trainingData(1:50,:);
trainingData2 = trainingData(51:100,:);
trainingData3 = trainingData(101:150,:);
trainingData4 = trainingData(151:200,:);
tic
[coeff, score, latent, t, explained] = pca(trainingData);
toc

data = score;
A = zeros(size(score));
ei = zeros(1,size(score,2));
tic
for i = 1:size(score,2)-1
    %find largest variance via GRID
    A(i,:) = grid(data(i:end,:),10,10);
    
    %do HH transformation to the data and repeat with 1 less dimension
    ei = zeros(1,size(score,2));
    ei(i) = 1;
    n = (ei - A(i,:))/norm(ei-A(i,:));
    data = data - 2*data*A(i,:)'*A(i,:);
end
toc