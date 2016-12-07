%% Initial Setup

clear all;
close all;
load trainingSet.mat
load testingSet.mat
load validateSet.mat

trainingData = trainingStruct.data;
trainingClasses = trainingStruct.classes;
testData = test_struct.data;
testClasses = test_struct.classes;
validData = valid_struct.data;
validClasses = valid_struct.classes;

%% Parameters
perts = linspace(0,10,100);
threshold = 0.65;
errors = [];
stdev = diag(std(trainingData));
[data, mu, we] = zscore(trainingData);
%for pert = perts
    pert = 10000;
    %do PCA with perturbation
    [PC, V, cov, explained, signals] = myPCA(trainingData,pert);
    %determine number of dimensions
    %ndx = screeMethod(explained, threshold);
    %reducedSet = 
    %test with MDA
    [results, error] = mda(signals,testData, testClasses,PC);
    errors = [errors error];
%end

