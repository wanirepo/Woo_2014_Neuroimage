%% Figure 2A - contour map

close all;
clear all;

% You need to change the following path accordingly.
savedir = '/Users/clinpsywoo/github/Woo_2014_Neuroimage';

savename = fullfile(savedir, 'THR_plot_smooth_primp_k_080313.mat'); % x: prim_p, y:fwhm
load(savename);

Tom_2003_smooth = [
   10.3700   10.0300   10.2000
   10.8800   11.7300   10.4000
    6.1500    6.1500    6.4500
    5.7000    5.8500    6.0000
    5.1000    6.8000    6.9000
    8.4000    8.1000    7.5000
    8.8125    9.1875    8.7500
    9.3750    9.5625    9.0000
    8.6250    9.0000    8.5000]; % account for voxel size

range_sm = [min(min(Tom_2003_smooth)) max(max(Tom_2003_smooth))];

fwhm = linspace(1,12,100); %(in vox) in mm: 3 to 30
prim_p = linspace(1.64,3.72,100); % 0.05 ~ 0.0001

%% Contour map
dosave = 1;

[c, h] = contourf(prim_p(prim_p > spm_u(.01, [], 'Z') & prim_p < spm_u(.001, [], 'Z')),fwhm(fwhm<11.89 & fwhm>4.9),...
    cluster_extent((prim_p > spm_u(.01, [], 'Z') & prim_p < spm_u(.001, [], 'Z')), (fwhm<11.89 & fwhm>4.9))', 30);
set(h, 'textlist', round(get(h, 'textList')), 'levellist', round(get(h, 'levellist')), 'showtext', 'on');

smtom = mean(Tom_2003_smooth,2);
for i = 1:length(smtom)
    line(get(gca,'xLim'), [smtom(i) smtom(i)], 'color', 'w', 'linestyle', '--');
end

clabel(c, h, 'fontsize', 15, 'labelspacing', 1000);

h1 = get(h, 'children');
colors = repmat(linspace(0, 0.7, length(h1)/2)', 1, 3); % change all to black

for i = 1:(length(h1)/2)
    try
        set(h1(i), 'color', colors(i,:), 'fontsize', 10+10/31*i);
    catch
        break
    end
end

set(gca, 'fontSize', 20);
set(gcf, 'color', 'w');
hh = colorbar;
set(hh, 'fontSize', 18)

% if dosave
%     % figdir = '/Volumes/RAID1/labdata/current/Threshold/scripts/figures';
%     figdir = '/Users/clinpsywoo/Documents/Workspace/Threshold';
%     scn_export_papersetup(500);
%     cd(figdir);
%     saveas(gcf, 'Fig2_contour_gray_v3.pdf');
% end