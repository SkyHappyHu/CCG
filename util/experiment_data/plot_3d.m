clear all;
close all;
%% 三维网格图
addpath(genpath(fullfile('./util/experiment_data')));

% x = [1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5];
% x = repmat(x', 1, 11);
x = [1e-5 1e-4 1e-3 1e-2 1e-1 1e0];
x = repmat(x', 1, 6);

% y = [1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1 1e2 1e3 1e4 1e5];  
% y = repmat(y, 11, 1);
y = [1e-5 1e-4 1e-3 1e-2 1e-1 1e0];  
y = repmat(y, 6, 1);

lambda1 = 1e0;
lambda2 = 1e-4;
lambda3 = 1e-4;

% mycolorpoint=[[0 0 16];...
%     [8 69 99];...
%     [57 174 156];...
%     [198 243 99];...
%     [222 251 123];...
%     [239 255 190]];
mycolorpoint=[[195 176 214];...
    [103 171 214];...
    [146 200 224];...
    [196 218 230];...
    [225 230 230];...
    ];
mycolorposition=[1 40 50 58 64];
mycolormap_r=interp1(mycolorposition,mycolorpoint(:,1),1:64,'linear','extrap');
mycolormap_g=interp1(mycolorposition,mycolorpoint(:,2),1:64,'linear','extrap');
mycolormap_b=interp1(mycolorposition,mycolorpoint(:,3),1:64,'linear','extrap');
mycolor=[mycolormap_r',mycolormap_g',mycolormap_b']/255;
mycolor=round(mycolor*10^4)/10^4;

fontsize = 16;
load ParameterSensitivity;
param1 = [];
z1 = [];
for i = 1:size(mAP,1)
   if mAP(i, 1) == lambda1
       param1 = [param1 mAP(i, 4)];
   end
end
range = 5;
long = 66;
for i = 1:11:long
    z1 = [z1; param1(i:range+i)];
end
figure
surf(x,y,z1)
% bar3(z)
colorbar
xlabel('λ_2')
%xlim([0.001 1000])
% set(gca,'xtick',[10,1000,100000,10000000,1000000000])
% set(gca,'xticklabel',{'10^1','10^3','10^5','10^7','10^9'})
set(gca,'xtick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'xticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
ylabel('λ_3')
set(gca,'ytick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'yticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
% set(gca,'ytick',[0.001,0.1,10,1000,100000])
% set(gca,'yticklabel',{'10^-3','10^-1','10^1','10^3','10^5'})
zlabel('MAP (%)')
set(gca,'ztick',[20,30,40,50,60,65])
set(gca,'zticklabel',{'20','30','40','50','60','65'})
% title('Fix λ_1');
set(gca,'xscale','log','yscale','log');%x,y轴设置为对数坐标
set(gca,'XMinorGrid','off','YMinorGrid','off');%关闭x,y坐标系内小刻度，on是开启，off是关闭
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize, 'zlim', [min(param1) 64]);%关闭x,y轴上小刻度
% view(-37,59)%调整视角
view(-145, 45);
% mycolorpoint=[[131 175 155]/256; [200 200 169]/256; [249 205 173]/256; [252 157 154]/256; [254 67 101]/256];
% colormap(mycolorpoint);
% colormap colorcube
colormap(mycolor)

param1 = [];
z2 = [];
for i = 1:size(mAP,1)
   if mAP(i, 2) == lambda2
       param1 = [param1 mAP(i, 4)];
   end
end
for i = 1:11:long
    z2 = [z2; param1(i:range+i)];
end
figure
surf(x,y,z2)
% bar3(z)
colorbar
xlabel('λ_1')
%xlim([0.001 1000])
% set(gca,'xtick',[10,1000,100000,10000000,1000000000])
% set(gca,'xticklabel',{'10^1','10^3','10^5','10^7','10^9'})
set(gca,'xtick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'xticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
ylabel('λ_3')
set(gca,'ytick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'yticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
% set(gca,'ytick',[0.001,0.1,10,1000,100000])
% set(gca,'yticklabel',{'10^-3','10^-1','10^1','10^3','10^5'})
zlabel('MAP(%)')
set(gca,'ztick',[20,30,40,50,60,65])
set(gca,'zticklabel',{'20','30','40','50','60','65'})
% title('Fix λ_1');
set(gca,'xscale','log','yscale','log');%x,y轴设置为对数坐标
set(gca,'XMinorGrid','off','YMinorGrid','off');%关闭x,y坐标系内小刻度，on是开启，off是关闭
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize, 'zlim', [min(param1) 64]);%关闭x,y轴上小刻度
% view(-37,59)%调整视角
view(-145, 45);
% mycolorpoint=[[131 175 155]/256; [200 200 169]/256; [249 205 173]/256; [252 157 154]/256; [254 67 101]/256];
% colormap(mycolorpoint);
% colormap colorcube
colormap(mycolor)

param1 = [];
z3 = [];
for i = 1:size(mAP,1)
   if mAP(i, 3) == lambda3
       param1 = [param1 mAP(i, 4)];
   end
end
for i = 1:11:long
    z3 = [z3; param1(i:range+i)];
end
figure
surf(x,y,z3)
% bar3(z)
colorbar
xlabel('λ_1')
%xlim([0.001 1000])
% set(gca,'xtick',[10,1000,100000,10000000,1000000000])
% set(gca,'xticklabel',{'10^1','10^3','10^5','10^7','10^9'})
set(gca,'xtick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'xticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
ylabel('λ_2')
set(gca,'ytick',[1e-5 1e-3 1e-1 1e1 1e3 1e5])
set(gca,'yticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
% set(gca,'ytick',[0.001,0.1,10,1000,100000])
% set(gca,'yticklabel',{'10^-3','10^-1','10^1','10^3','10^5'})
zlabel('MAP(%)')
set(gca,'ztick',[20,30,40,50,60,65])
set(gca,'zticklabel',{'20','30','40','50','60','65'})
% title('Fix λ_1');
set(gca,'xscale','log','yscale','log');%x,y轴设置为对数坐标
set(gca,'XMinorGrid','off','YMinorGrid','off');%关闭x,y坐标系内小刻度，on是开启，off是关闭
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize, 'zlim', [min(param1) 64]);%关闭x,y轴上小刻度
% view(-37,59)%调整视角
view(-145, 45);
% mycolorpoint=[[131 175 155]/256; [200 200 169]/256; [249 205 173]/256; [252 157 154]/256; [254 67 101]/256];
% colormap(mycolorpoint);
colormap(mycolor)


% 柱状图
figure
bar3(z1);
xlabel('λ_2');
zlabel('MAP (%)');
set(gca,'XTick',[1:1:range])
set(gca,'xticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
ylabel('λ_3')
set(gca,'ytick',[1:1:range])
set(gca,'yticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
zlabel('MAP(%)')
% set(gca,'ztick',[10,25,40,55,60,65])
% set(gca,'zticklabel',{'10','25','40','55','60','65'})
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize);
view(59.8, 33.06);
% colormap spring

figure
bar3(z2);
xlabel('λ_1');
zlabel('MAP (%)');
set(gca,'XTick',[1:1:range])
set(gca,'xticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
ylabel('λ_3')
set(gca,'ytick',[1:1:range])
set(gca,'yticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
zlabel('MAP(%)')
% set(gca,'ztick',[20,30,40,50,60,65])
% set(gca,'zticklabel',{'20','30','40','50','60','65'})
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize);
view(59.8, 33.06);
% colormap spring

figure
bar3(z3);
xlabel('λ_1');
zlabel('MAP (%)');
set(gca,'XTick',[1:1:range])
set(gca,'xticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
ylabel('λ_2')
set(gca,'ytick',[1:1:range])
set(gca,'yticklabel',{'10^{-5}', '10^{-4}', '10^{-3}', '10^{-2}', '10^{-1}', '1'})
zlabel('MAP(%)')
% set(gca,'ztick',[20,30,40,50,60,65])
% set(gca,'zticklabel',{'20','30','40','50','60','65'})
set(gca,'xminortick','off','yminortick','off','Fontname','Times New Roman','FontSize',fontsize);
view(59.8, 33.06);
% colormap spring

