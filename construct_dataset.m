function dataset = construct_dataset(dataname, test_num)
% MNIST-USPS、VLCS、Caltech256-ImageNet、Office31、Office-Home、COIL20
% random_seed = rng(0);
% save('random_seed', 'random_seed');

NumNeighbors = 1;       % knn-neighbors
switch dataname
    case 'MNIST-USPS'
        disp('Conducting MNIST-USPS task');
        
        load MNIST_vs_USPS X_src X_tar Y_src Y_tar;
        X_src = double(normalize1(X_src'));
        X_tar = double(normalize1(X_tar'));
        Y_src = double(Y_src);
        Y_tar = double(Y_tar);
                
    case 'USPS-MNIST'
        disp('Conducting USPS-MNIST task');
        
        load USPS_vs_MNIST X_src X_tar Y_src Y_tar;
        X_src = double(X_src');
        X_tar = double(X_tar');
        Y_src = double(Y_src);
        Y_tar = double(Y_tar);
        
    case 'VOC2007-Caltech101'
        disp('Conducting VOC2007-Caltech101 task');
        
        load VOC2007 data;
        X_src = double(normalize1(data(:, 1:4096)));      
        Y_src = double(data(:, 4097));
        clear data;
        
        load Caltech101 data;
        X_tar = double(normalize1(data(:, 1:4096)));
        Y_tar = double(data(:, 4097));
        clear data
                
    case 'Caltech256-ImageNet'
        disp('Conducting Caltech256-ImageNet task');
        
        load dense_caltech256_decaf7_subsampled fts labels;
        X_src = double(fts);
        Y_src = double(labels);
        clear fts labels;
        
        load dense_imagenet_decaf7_subsampled fts labels;
        X_tar = double(fts);
        Y_tar = double(labels);
        clear fts labels;
                
    case 'Pr-Rw'
        disp('Conducting Pr-Rw task');
        
        load Product_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Real_World_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'Rw-Pr'
        disp('Conducting Rw-Pr task');
        
        load Real_World_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Product_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'Cl-Rw'
        disp('Conducting Cl-Rw task');
        
        load Clipart_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Real_World_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'Rw-Cl'
        disp('Conducting Rw-Cl task');
        
        load Real_World_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Clipart_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'Ar-Rw'
        disp('Conducting Ar-Rw task');
        
        load Art_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Real_World_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'Rw-Ar'
        disp('Conducting Rw-Ar task');
        
        load Real_World_feature_mat deepfea label;
        X_src = double(normalize1(deepfea));
        Y_src = double(label' + 1);
        clear deepfea label;
        
        load Art_feature_mat deepfea label;
        X_tar = double(normalize1(deepfea));
        Y_tar = double(label' + 1);
        clear deepfea label;
        
    case 'P27-P05'
        disp('Conducting PIE27-PIE05 task');
        
        load PIE27 fea gnd;
        X_src = double(normalize1(fea));
        Y_src = double(gnd);
        
        load PIE05 fea gnd;
        X_tar = double(normalize1(fea));
        Y_tar = double(gnd);
        
    case 'A-W'
        disp('Conducting A-W task');
        load amazon_fc6 fts labels;
        X_src = double(normalize1(fts));
        Y_src = double(labels);
        
        load webcam_fc6 fts labels;
        X_tar = double(normalize1(fts));
        Y_tar = double(labels);
        
    case 'COIL1-COIL2'
        disp('Conducting COIL1-COIL2 task');
        
        load COIL_1 X_src X_tar Y_src Y_tar;
        X_src = double(X_src');
        X_tar = double(X_tar');
        Y_src = double(Y_src);
        Y_tar = double(Y_tar);
                
    case 'COIL2-COIL1'
        disp('Conducting COIL2-COIL1 task');
        
        load COIL_2 X_src X_tar Y_src Y_tar;
        X_src = double(X_src');
        X_tar = double(X_tar');
        Y_src = double(Y_src);
        Y_tar = double(Y_tar);    
  
end

c = length(unique(Y_tar));  % The number of classes;
dataset.c = c;



randIdx = randperm(length(Y_tar));
sele_num = test_num;
Xt_test = X_tar(randIdx(1: sele_num), :);       % test set
Yt_test = Y_tar(randIdx(1: sele_num));
Xt = X_tar(randIdx(sele_num + 1: length(Y_tar)), :);        % training set of the target domain
Yt = Y_tar(randIdx(sele_num + 1: length(Y_tar)));
nt = length(Y_tar) - sele_num;          % number of samples of traing target domain
%%

% 500 target domain samples as a test set
dataset.Xt_test = Xt_test;
dataset.Yt_test = Yt_test;

% A portion of the target domain and all source domain samples remain as the training set
dataset.Xs = X_src;
dataset.Ys = Y_src;
dataset.Xt = Xt;
dataset.Yt_true = Yt;    % groundtruth

dataset.nt = nt;
dataset.ns = size(X_src, 1);

% generate pseudo-labels with knn 
model = fitcknn(X_src, Y_src, 'NumNeighbors', NumNeighbors);        
pseudo_label = predict(model, Xt);
correct_num=length(find(pseudo_label == dataset.Yt_true));
rate=correct_num / nt;
fprintf('KNN_acc=%.4f \n', rate);
dataset.Yt = pseudo_label;
%%

YS = repmat(Y_src, 1, length(Yt_test));
YTest = repmat(Yt_test,1,length(Y_src));
WTT = (YTest==YS');
dataset.WTT = WTT;

YT = repmat(Yt, 1, length(Yt_test));
YTest = repmat(Yt_test,1,length(Yt));
WTT_single = (YTest==YT');
dataset.WTT_single = WTT_single;

end