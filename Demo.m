clear all;
close all;
addpath('./FOptMshare/');
addpath('./data/');
% addpath('./data/cross-dataset/');
% addpath('./data/VLSC/');
% addpath('./data/Office-Home(vgg)/');
addpath('./util/');
warning off;

randseed = 1;            % Fix random seeds (required for parameter adjustment and ablation). 0: Fixed; 1: Not fixed
param.randseed = randseed;

param.lambda = 7;   %16,32->6; 48->7; 64,96,128->8.
param.bit = 64;
param.gama = 0.01;
param.m = param.bit * 1;
param.maxIter = 30;
plot_loss_acc = 0;      % Whether to draw a MAP&convergence curves


param.lambda1 = 1e0;      % MNIST-USPS
param.lambda2 = 1e-4;
param.lambda3 = 1e-4;

% param.lambda1 = 1e-0;      % VOC2007-Caltech101
% param.lambda2 = 1e-4;
% param.lambda3 = 1e-6;

% param.lambda1 = 1e-4;    % Caltech256-ImageNet
% param.lambda2 = 1e-4;
% param.lambda3 = 1e-6;

% param.lambda1 = 1e-2;      % Office-Home��Pr-Rw、Rw-Pr、Cl-Rw、Rw-Cl、Ar-Rw、Rw-Ar
% param.lambda2 = 1e-6;
% param.lambda3 = 1e-2;

mAP = [];
for t = 1:10
    if randseed == 0
        load('./util/experiment_data/random_seed.mat');
        rng(random_seed);
    end 
    dataset = construct_dataset('MNIST-USPS', 500);
    [cross_MAP_W, cross_MAP_B, single_MAP_W, single_MAP_B] = CCG(dataset, param, plot_loss_acc);
    fprintf('%d: cross_MAP_W=%.2f, cross_MAP_B=%.2f, single_MAP_W=%.2f, single_MAP_B=%.2f \n', t, cross_MAP_W, cross_MAP_B, single_MAP_W, single_MAP_B);
    mAP(t, 1) = cross_MAP_W;
    mAP(t, 2) = cross_MAP_B;
    mAP(t, 3) = single_MAP_W;
    mAP(t, 4) = single_MAP_B;
end
fprintf('mean=%.2f \n', mean(mAP));
fprintf('std=%.2f \n', std(mAP));

            
            
            
            