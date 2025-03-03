function show(y)
figure
bar3(y);
xlabel('¦Ë_2','FontSize',15,'Fontname','Times New Roman');
zlabel('MAP (%)');
set(gca,'XTick',[1:2:11])
set(gca,'xticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
ylabel('¦Ë_3','FontSize',15,'Fontname','Times New Roman')
set(gca,'ytick',[1:2:11])
set(gca,'yticklabel',{'1e-5', '1e-3', '1e-1', '1e1', '1e3', '1e5'})
zlabel('MAP(%)')
set(gca,'ztick',[20,40,60,70,80])
set(gca,'zticklabel',{'20','40','60','70','80'})
view(59.8, 33.06);
% title('LOOCV');
% ax = gca;
% ax.ZLim=[0.98 0.987];
% ax.ZTick = [0.98 0.981 0.982 0.983 0.984 0.985 0.986 0.987];
% ax.CLim=[0.982,0.9868];
% colorbar
% c = colorbar;
% c.Limits = [0.982 0.987];
% c.TickLabels = {'0.982','0.983','0.984','0.985','0.986','0.987'};
% c.Ticks = [0.982 0.983 0.984 0.985 0.986 0.987];
% for k = 1:length(b)
%     zdata = b(k).ZData;
%     b(k).CData = zdata;
%     b(k).FaceColor = 'interp';
% end

end