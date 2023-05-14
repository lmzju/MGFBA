function out_num = cal_2dim_bit(margin, mu_total, mu_target)
%     clear all; close all; clc;
%     margin = 1; mu_total = [0,0]; mu_target = [2,-1];
    %[mu_target, res_sigma] = simulate_1dim_gaussian(fea)
    % margin: x_margin, y_margin
    % mu_total: (x,y); mu_target: (x, y)
    x_left = mu_total(1) - margin(1);
    x_right = mu_total(1) + margin(1);
    y_up = mu_total(2) + margin(2);
    y_down = mu_total(2) - margin(2);
    out_num = '--';
    if mu_target(1) <= x_left
        if mu_target(2) >= y_up
            out_num = '00';
        elseif mu_target(2) <= y_down
            out_num = '10';
        end
    elseif mu_target(1) >= x_right
        if mu_target(2) >= y_up
            out_num = '01';
        elseif mu_target(2) <= y_down
            out_num = '11';
        end
    end


