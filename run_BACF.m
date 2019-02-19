
function results=run_BACF(seq, res_path, bSaveImage)
%   Load video information
% base_path  = '/media/chen/Data/Benchmark/data_seq';
% video      = 'usv_small5';
% 
% video_path = [base_path '/' video];
% [seq, ground_truth] = load_video_info(video_path);
% 
% seq = evalin('base', 'subS');
% target_sz = seq.init_rect(1,[4,3]);
% pos = seq.init_rect(1,[2,1]) + floor(target_sz/2);
% img_files = seq.s_frames;
seq = evalin('base', 'subS');
video_path = [];

% seq.len = size(ground_truth, 1);
% seq.init_rect = ground_truth(1,:);
% seq.s_frames = ;
% 
% seq.VidName = video;
% seq.st_frame = 1;
% seq.en_frame = seq.len;

%   Run BACF- main function
learning_rate = 0.013;  %   you can use different learning rate for different benchmarks.
results       = run_tracker(seq, video_path, learning_rate);

FPS_vid = results.fps;
display(['FPS: ' num2str(FPS_vid)]);
