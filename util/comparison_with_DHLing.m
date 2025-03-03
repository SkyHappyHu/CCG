
% close all;
x = [1:1:6];
DHLing = [49.24 54.90 56.30 58.28 58.8 59.14];
PWSP = [63.72 67.84	71.58 73.41	73.32 74.02];

figure
b = bar(x, [DHLing; PWSP], 'lineStyle', 'none', 'BarWidth', 1);
set(b(1),'DisplayName','Before',...
    'FaceColor','#F3D2AC');
set(b(2),'DisplayName','After',...
    'FaceColor','#7DCBCA');
set(gca,'FontSize',16,'YGrid','on','Fontname','Times New Roman','yLim',[0 100],'XTickLabel',{'16','32','48','64', '96', '128'});
legend('DHLing', 'Ours', 'Location', 'northwest')
ylabel('MAP (%)')
xlabel('Bits')
 





% x = [1:1:4];
DHLing = [30.10 43.46 47.41 51.50 53.52 55.90];
PWSP = [26.60 53.43	52.71 57.88	61.07 62.62];

figure
b = bar(x, [DHLing; PWSP], 'lineStyle', 'none', 'BarWidth', 1);
set(b(1),'DisplayName','Before',...
    'FaceColor','#F3D2AC');
set(b(2),'DisplayName','After',...
    'FaceColor','#7DCBCA');
set(gca,'FontSize',16,'YGrid','on','Fontname','Times New Roman','yLim',[0 100],'XTickLabel',{'16','32','48','64', '96', '128'});
legend('DHLing', 'Ours', 'Location', 'northwest')
ylabel('MAP (%)')
xlabel('Bits')
 
