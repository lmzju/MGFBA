function best_total = find_best_beta_rct_spt(input_path, num_of_rat)

best_per_SPT = cell(1,8);
best_total = cell(1,1);
for sample_per_test = 5:5:40
    
    AA = cell(30, num_of_rat);
    IA = cell(30, num_of_rat);
    total_threshold = cell(30, num_of_rat);
    
    for beta = 0.20:0.01:0.49
        for RCT = 0.10:0.01:1.00
            filename = sprintf('res_similar_beta_%.2f_persample_%d_trainRCT_%.2f_validRCT_%.2f.mat',...
                beta, sample_per_test, 0, RCT);
            load([input_path, filename]);
            valid_similar = cell(num_of_rat, num_of_rat);
            test_similar = cell(num_of_rat, num_of_rat);
            for i = 1:num_of_rat
                for j = 1:num_of_rat
                    temp_len = ceil(length(res_similar{i,j})/2);
                    valid_similar{i,j} = res_similar{i,j}(1:temp_len);
%                     test_similar{i,j} = res_similar{i,j}(temp_len+1:end);
                end
            end
            temp_x = int16((beta-0.30) / 0.01 + 1);
            temp_y = int16((RCT-0.50) / 0.05 + 1);
            total_threshold{temp_x, temp_y} = find_best_TMT(valid_similar, num_of_rat);
            [AA{temp_x, temp_y}, IA{temp_x, temp_y}] = test_use_TMT(valid_similar,...
                total_threshold{temp_x, temp_y}, num_of_rat);
        end
    end
    max_judgement = 0;
    beta = 0.20:0.01:0.49;
    rct = 0.10:0.10:1.00;
    for i = 1:30
        for j = 1:num_of_rat
            if mean(IA{i,j}) < 0.05
                judgement = mean(AA{i,j}) - mean(IA{i,j});
                if judgement > max_judgement
                    max_judgement = judgement;
                    best_per_SPT{sample_per_test/5} = [mean(AA{i,j}), mean(IA{i,j}),beta(i), rct(j), total_threshold{i,j}];
                end
            end
        end
    end
    
end

max_judgement = 0;
for i = 1:8
    judgement = best_per_SPT{i}(1) - best_per_SPT{i}(2);
    if judgement > max_judgement
        max_judgement = judgement;
        best_total = best_per_SPT{i};
    end

end







