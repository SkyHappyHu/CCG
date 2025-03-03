%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 双刻度曲线图
clc;clear;
% close all;

load experiment_data/convergence_VOC2007-Caltech101.mat

fig = figure;
% left_color = [0.00,0.45,0.74]; % 左侧刻度颜色
% right_color = [1.00,0.31,0.02];% 右侧刻度颜色
left_color = [0,0,0];
right_color = [0,0,0];
set(fig,'defaultAxesColorOrder',[left_color; right_color]);
set(gca,'Fontname','Times New Roman','FontSize',16);

yyaxis left        % 激活左侧
plot(loss,'-', 'Color', [0.00,0.45,0.74],'LineWidth', 1.5, 'Marker', 'o'); % 颜色与left_color = [0 0 1]保持一致
ylabel('Objective function');
% axis([1 30 -0.05 0.3]); % 显示x,y轴的范围

yyaxis right        % 激活右侧
plot(MAP,'-', 'Color', [1.00,0.31,0.02], 'LineWidth', 1.5, 'Marker', 'square'); % 颜色与right_color = [1 0 0]保持一致
ylabel('MAP (%)');
xlabel('Iteration');
legend('Objective function', 'MAP (%)');
grid on