clc;
clear all;
close all;
addpath(genpath('ker1'));
addpath(genpath('whyte_code'));
addpath(genpath('cho_code'));
addpath(genpath('clean_image'));
opts.prescale = 1; %%downsampling
opts.xk_iter = 5; %% the iterations
opts.gamma_correct = 1.0;
opts.k_thresh = 20;

num = 12;
ori_name= cell(1,num);
image_name = cell(1,num);

% the used 8 clean images
ori_name{1} ='i20_L1TVSB.png';
ori_name{2} ='i9_barcode256.png';
ori_name{3} ='i7_fingerprint.png';
ori_name{4} ='i15_lena.png';
ori_name{5} ='i4_barcode.jpg';
ori_name{6} ='i13_NumTab.png';
ori_name{7} ='i1_text.jpg';
ori_name{8} ='i17_pattern_344.png';

% the used 8 blurry images
image_name{1} ='i20_L1TVSB_ker1.png';
image_name{2} ='i9_barcode256_ker1.png';
image_name{3} ='i7_fingerprint_ker1.png';
image_name{4} ='i15_lena_ker1.png';
image_name{5} ='i4_barcode_ker1.png';
image_name{6} ='i13_NumTab_ker1.png';
image_name{7} ='i1_text_ker1.png';
image_name{8} ='i17_pattern_344_ker1.png';

kernel_sizes=[43 25 31 43 37 43 43 43];  % the used kernel size for the 8 different images

for jj=1:8
    filename =image_name{jj};
    opts.kernel_size =kernel_sizes(jj);
    lambda_pixel = 2e-3; lambda_grad = 2e-3;
    % Note: both lambda_pixel and lambda_grad are lambda_1 and not used in kernel estimation.

    y = imread(filename);
    if size(y,3)==3
        yg = im2double(rgb2gray(y));
    else
        yg = im2double(y);
    end

    % deblurring process
    tic;
    [kernel, Latent] = blind_deconv(yg, lambda_pixel, lambda_grad, opts);
    toc

    % compute the PSNR values
    ground_truth=im2double(imread(ori_name{jj}));
    psnr_value=comp_upto_shift_psnr(Latent,ground_truth);
    set_psnr_value{jj}=psnr_value;
    
    figure;imshow(Latent);
end



