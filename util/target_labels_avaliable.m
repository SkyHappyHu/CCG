nhmethods = 4;
line_width = 1.5;
marker_size = 4;
xy_font_size = 16;
legend_font_size = 14;
linewidth = 1.6;
title_font_size = 18;

figure('Color', [1 1 1]); hold on;
cross = [51.48	57.36	61.13	61.80	61.80	62.59
         63.72	67.84	71.58	73.41	73.32	74.02
         57.77	67.10	69.57	70.43	71.01	70.90
         77.68	83.61	85.52	87.89	87.22	87.91];
for j = 1: nhmethods
    recc = rec{choose_times}{choose_bits, j};
    p = plot([16, 32, 48, 64, 96, 128], cross(j, :));
    color = gen_color(j);
    marker = gen_marker(j);
    set(p,'Color', color)
    set(p,'Marker', marker);
    set(p,'LineWidth', line_width);
    set(p,'MarkerSize', marker_size);
end

str_nbits =  num2str(loopnbits(choose_bits));
set(gca, 'linewidth', linewidth);
h1 = xlabel('Bits');
h2 = ylabel('MAP (%)');
% title(db_name, 'FontSize', title_font_size);
set(h1, 'FontSize', xy_font_size);
set(h2, 'FontSize', xy_font_size);
axis square;
hleg = legend(hashmethods);
set(hleg, 'FontSize', legend_font_size);
set(hleg,'Location', 'best');
box on;
grid on;
hold off;


function color=gen_color(curve_idx)
colors=[];
colors{end+1}='r';
colors{end+1}='r';
% colors{end+1}='r';
% colors{end+1}='r';
% colors{end+1}='b';
% colors{end+1}='b';
colors{end+1}='b';
colors{end+1}='b';

sel_idx=mod(curve_idx-1, length(colors))+1;
color=colors{sel_idx};
end

function marker=gen_marker(curve_idx)
markers=[];

markers{end+1}='s';
markers{end+1}='h';
markers{end+1}='*';
markers{end+1}='v';
markers{end+1}='s';
markers{end+1}='h';
markers{end+1}='*';
markers{end+1}='v';

sel_idx=mod(curve_idx-1, length(markers))+1;
marker=markers{sel_idx};
end
