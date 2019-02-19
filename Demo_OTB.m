%   This script runs the original implementation of Background Aware Correlation Filters (BACF) for visual tracking.
%   the code is tested for Mac, Windows and Linux- you may need to compile some of the mex files.
%   Paper is published in ICCV 2017- 
%   Some functions are borrowed from other papers (SRDCF, CCOT, KCF, etc)- and their copyright belongs to the paper's authors.
%   This demo runs on OTB100, you can use any benchmark by setting the seq path, and using the standard annotation txt files.
clear;
clc;
close all;
% Load video information
base_path  = 'D:\tracking\JHT\DSLaker01';
videos = choose_video(base_path);
video_path = [base_path '\' videos];
[seq, ground_truth] = load_video_info(video_path);
seq.VidName = videos;
st_frame = 1;
en_frame = seq.len;
seq.startFrame = st_frame;
seq.endFrame = en_frame;
gt_boxes = [ground_truth(:,1:2), ground_truth(:,1:2) + ground_truth(:,3:4) - ones(size(ground_truth,1), 2)];
% Run BACF- main function
learning_rate = 0.013;  %  you can use different learning rate for different benchmarks.
results = run_tracker(seq, video_path, learning_rate);
results.gt = gt_boxes;
%   compute the OP
pd_boxes = results.res;
pd_boxes = [pd_boxes(:,1:2), pd_boxes(:,1:2) + pd_boxes(:,3:4) - ones(size(pd_boxes,1), 2)  ];
OP = zeros(size(gt_boxes,1),1);
for i=1:size(gt_boxes,1)
    b_gt = gt_boxes(i,:);
    b_pd = pd_boxes(i,:);
    OP(i) = computePascalScore(b_gt,b_pd);
end
OPs = sum(OP >= 0.5) / numel(OP);
FPSs = results.fps;
display([videos  '---->' '   FPS:   ' num2str(results.fps)   '    op:   '   num2str(OPs)]);
