function margin = cal_1dim_margin(mean_sigma_x, beta)
%     clear all; clc; close all;
%     load idcs_fea_20.mat;
%     mean_sigma_x = 5; mean_sigma_y = 2; beta = 0.1;
    
    len = 100;
    bin = 0.005;
    sigma = mean_sigma_x;
    target = 0.5 - beta;
    for i = bin:bin:len
        s = mvncdf(0, i, 0, sigma);
        if abs(s - target) <= 0.005
            margin = i;
            break;
        end
    end
    
    
    
