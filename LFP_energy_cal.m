function [LFP_power] = LFP_energy_cal(LFP_segment, LFP_downsample_fre)
    % 滤波
    LFP_segment = lm_notch_50_40000(LFP_segment);
    LFP_segment = lm_notch_100_40000(LFP_segment);
    LFP_segment = lm_notch_150_40000(LFP_segment);
    LFP_segment = lm_notch_200_40000(LFP_segment);
    LFP_segment = lm_notch_250_40000(LFP_segment);
    LFP_segment = lm_notch_300_40000(LFP_segment);
    LFP_segment = bandpass_LFP_40000(LFP_segment);
    
    % 去掉信号偏大值
    ave = mean(abs(LFP_segment));
    for i = 1:length(LFP_segment)
        if abs(LFP_segment(i))>=5*ave
            LFP_segment(i) = 0;
        end
    end
    
    zero_del_FP = find(LFP_segment==0);
    LFP_segment(zero_del_FP) = [];

    clear lm_notch_50_40000;
    clear lm_notch_100_40000;
    clear lm_notch_150_40000;
    clear lm_notch_200_40000;
    clear lm_notch_250_40000;
    clear lm_notch_300_40000;
    clear bandpass_LFP_40000;
    
    LFP_segment = resample(LFP_segment, LFP_downsample_fre, 40000);
    
    % 计算能量
    frequency = [0 4; 7 20; 70 115; 130 200; 200 300];
    
    [row_fre, col_fre] = size(frequency);    
    fft_res = fft(LFP_segment);
    fft_val = abs(fft_res);
    fft_val = fft_val(1:length(LFP_segment)/2+1);
    fft_val(2:end-1) = 2*fft_val(2:end-1); % 3.5 ？？？
    fre_energy = 0;
    f = LFP_downsample_fre*(0:(length(LFP_segment)/2))/length(LFP_segment);
    plot(f, fft_val);
    fre_power = zeros(1, row_fre+1);
    for k = 1:row_fre
        fre_point{k} = find(f>=frequency(k,1) & f<frequency(k,2));
        fre{k} = fft_val(fre_point{k});
        fre_power(k) = log10(sum((fre{k}).^2));
        fre_energy = fre_energy + sum((fre{k}).^2);
    end
    fre_power(row_fre+1) = log10(fre_energy);
    LFP_power = fre_power;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

