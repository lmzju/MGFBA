function LFP_merge = LFP_segment(LFP, start_end, base_bin)
    len_press = length(start_end);
    for i = 1:len_press
        temp_start = start_end{i}(1);
        temp_end = start_end{i}(2);
        LFP_merge{i} = LFP(temp_start*base_bin:temp_end*base_bin);
    end

