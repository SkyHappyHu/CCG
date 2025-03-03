function [cross_MAP_W, cross_MAP_B, single_MAP_W, single_MAP_B] = CCG(dataset, param, plot_loss_acc)
warning off;

Xs = dataset.Xs;        
Ys = dataset.Ys;        
ns = dataset.ns;       
Xt = dataset.Xt;        
Yt = dataset.Yt;        
nt = dataset.nt;       
c = dataset.c;          
n = ns + nt;
Xt_test = dataset.Xt_test;      
Yt_test = dataset.Yt_test;     

bit = param.bit;
maxIter = param.maxIter;
m = param.m;
lambda = param.lambda;
lambda1 = param.lambda1;
lambda2 = param.lambda2;
lambda3 = param.lambda3;
gama = param.gama;

Ys = (full(ind2vec(Ys', c)))';      % Convert labels to one-hot encoding
Yt = (full(ind2vec(Yt', c)))';
Y_train = [Ys; Yt];                          % labels of traing set

d = size(Xs, 2);

S = Y_train * Y_train' > 0;     % similarity matrix

%% Initialization
Bt = ones(nt, bit);             % Initialize Bt
Bt(randn(nt, bit) < 0) = -1;

Bs = ones(ns, bit);             % Initialize Bs
Bs(randn(ns, bit) < 0) = -1;
B = [Bs; Bt];

V = B;                          % Initialize V
W = Xs \ Bs;                    % Initialize W

R1 = randn(bit);                % Initialize R
[U11 , ~, ~] = svd(R1);
R1 = U11(:, 1:bit);
R2 = randn(bit);
[U11 , ~, ~] = svd(R2);
R2 = U11(:, 1:bit);
                   
G = randn(c, bit);      % Initialize G

beta = 1e-5;
[Sw, Sb] = ScatterMat([Xs', Xt'], [dataset.Ys; dataset.Yt]);
Grad_LDA =  Sw - beta * Sb; 

%% plot the MAP&convergence curves
if plot_loss_acc ==1 
    figure('Color','w');
    h = animatedline;
    h.Color = 'r';
    h.LineWidth = 1;
    h.LineStyle = '-';
%     h.Marker = 'o';
%     h.MarkerSize = 6;
%     h.MarkerEdgeColor = 'k';
%     h.MarkerFaceColor = [0.3010 0.7450 0.9330];
    xlabel('Iteration');
    ylabel('Objective function');
    set(gca,'Fontname','Times New Roman','FontSize',16);
    
    figure('Color','w');
    h2 = animatedline;
    h2.Color = 'b';
    h2.LineWidth = 1;
    h2.LineStyle = '-';
%     h2.Marker = 'o';
%     h2.MarkerSize = 6;
%     h2.MarkerEdgeColor = 'k';
%     h2.MarkerFaceColor = [1.00,0.41,0.16];
    xlabel('Iteration');
    ylabel('MAP(%)');
    set(gca,'Fontname','Times New Roman','FontSize',16);
    
end
%% 
opts.record = 0;                % parameters of OptStiefelGBB
opts.mxitr  = 30;
opts.xtol = 1e-3;
opts.gtol = 1e-3;
opts.ftol = 1e-4;

lr = 1e-4;      % learning rate

loss = [];
MAP = [];

for t = 1:maxIter
    
    % update W
    [W, ~] = OptStiefelGBB(W, @fun_W, opts, Bs, Bt, Xs, Xt, lambda1, lambda2, Grad_LDA);
    
    % update G
    J = lambda3 * (Yt' * Yt * G * R1 * R1' + Ys' * Ys * G * R2 * R2' - Yt' * Bt * R1' - Ys' * Bs * R2');
    G = G - lr * J;
    
    % update Q
    R1 = updateR(Bt, Yt, G);
    R2 = updateR(Bs, Ys, G);
    
    % update V
    m_ind = randperm(n, m);
    Sm = S(:, m_ind);       % size: n*m 
    V = updateColumnV(V, B, Sm, m_ind, bit, lambda, m, gama);

    % update Bs
    Bs = updateColumnBs(V, B, Bs, Xs, W, Ys, G, R2, Sm, m_ind, bit, lambda, m, gama, ns, lambda2, lambda3);

    % update Bt
    Bt = updateColumnBt(V, B, Bt, Xt, W, Yt, G, R1, Sm, m_ind, bit, lambda, m, gama, ns, nt, lambda2, lambda3);
    B = [Bs; Bt];  

    if plot_loss_acc == 1
    % objective function value
        [loss(t)] = objective_function(W, Bs, Bt, R1, R2, G, V, Xs, Xt, Ys, Yt, lambda, lambda1, lambda2, lambda3, gama, S, bit, Grad_LDA); 
        addpoints(h, t, loss(t));
        drawnow;
    
    % real-time evaluation
        B_test = (Xt_test * W >= 0);       % hash codes of test set
        B_train = (Xs * W >= 0);                % hash codes of the source
        B_train = Bs;
        B_tr_comp = compactbit(B_train);
        B_te_comp = compactbit(B_test);        
        Dhamm = hammingDist(B_te_comp, B_tr_comp);
        [recall, precision, ~] = recall_precision(dataset.WTT, Dhamm);
        MAP(t) = area_RP(recall, precision);
        addpoints(h2, t, MAP(t));
        drawnow;
        
    end
end

B_test = (Xt_test * W >= 0);       % hash codes of test set
B_te_comp = compactbit(B_test);

B_train = (Xs * W >= 0);                % cross-domain
B_train2 = (Bs >= 0);               
B_tr_comp = compactbit(B_train);
B_tr_comp2 = compactbit(B_train2);
Dhamm = hammingDist(B_te_comp, B_tr_comp);
[recall, precision, ~] = recall_precision(dataset.WTT, Dhamm);
cross_MAP_W = area_RP(recall, precision) * 100;
Dhamm2 = hammingDist(B_te_comp, B_tr_comp2);
[recall, precision, ~] = recall_precision(dataset.WTT, Dhamm2);
cross_MAP_B = area_RP(recall, precision) * 100;

B_train_single = (Xt * W >= 0);        % single-domain
B_train_single2 = (Bt >= 0);
B_tr_comp_single = compactbit(B_train_single);
B_tr_comp_single2 = compactbit(B_train_single2);
Dhamm = hammingDist(B_te_comp, B_tr_comp_single);
[recall, precision, ~] = recall_precision(dataset.WTT_single, Dhamm);
single_MAP_W = area_RP(recall, precision) * 100;
Dhamm2 = hammingDist(B_te_comp, B_tr_comp_single2);
[recall, precision, ~] = recall_precision(dataset.WTT_single, Dhamm2);
single_MAP_B = area_RP(recall, precision) * 100;

end
