
close all;
x = [1:1:4];
PWCF = [50.67 64.75 54.83 72.06];
CCG = [58.80 68.58 69.95 85.79];

figure
b = bar(x, [PWCF; CCG], 'lineStyle', 'none', 'BarWidth', 1);
set(b(1),'DisplayName','Before',...
    'FaceColor','#CECBD6');
set(b(2),'DisplayName','After',...
    'FaceColor','#7DCBCA');
set(gca,'FontSize',16,'YGrid','on','Fontname','Times New Roman','yLim',[30 100],'XTickLabel',{'F','B','#F','#B'});
legend('PWCF', 'Ours', 'Location', 'northwest')
ylabel('MAP (%)')
% xlabel('Cross-domain retrieval')
 

x = [1:1:4];
PWCF = [71.13 71.13 73.95 73.95];
CCG = [69.46 59.49 79.81 89.32];

figure
b = bar(x, [PWCF; CCG], 'lineStyle', 'none', 'BarWidth', 1);
set(b(1),'DisplayName','Before',...
    'FaceColor','#CECBD6');
set(b(2),'DisplayName','After',...
    'FaceColor','#7DCBCA');
set(gca,'FontSize',16,'YGrid','on','Fontname','Times New Roman','yLim',[30 100],'XTickLabel',{'F','B','#F','#B'});
legend('PWCF', 'Ours', 'Location', 'northwest')
ylabel('MAP (%)')
% xlabel('Single-domain retrieval')
 
