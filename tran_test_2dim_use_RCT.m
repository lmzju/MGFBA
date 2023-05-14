clear all; clc;

num_of_rat = 10;
num_of_feature = 96;
input_path = 'run_data_new_3/';

input_train_set = cell(1, num_of_rat);
input_valid_set = cell(1, num_of_rat);
input_test_set = cell(1, num_of_rat);
input_valid_test_set = cell(1, num_of_rat);

for i = 1:num_of_rat
    file_name = sprintf('trainset_%d.mat', i);
    load([input_path, file_name]);
    train_set = zscore(train_set');
    train_set = train_set';
    input_train_set{i} = train_set;
    file_name = sprintf('valid_test_set_%d.mat', i);
    load([input_path, file_name]);
    valid_set = zscore(valid_set');
    valid_set = valid_set';
    input_valid_set{i} = valid_set;
    test_set = zscore(test_set');
    test_set = test_set';
    input_test_set{i} = test_set;
    input_valid_test_set{i} = [valid_set; test_set];
end

RCT = [0, 0.10];
for beta = 0.20:0.01:0.49
%     train_2dim_use_RCT(input_path, input_train_set, input_valid_set, num_of_rat, num_of_feature, beta, RCT);
end
for beta = 0.20:0.01:0.49
    for sample_per_test = 5:5:40
        res_similar = test_2dim_invad_use_RCT(input_path, input_valid_test_set, beta, num_of_rat, sample_per_test, ...
    num_of_feature, RCT);
    end
end

% for sample_per_test = 5:5:40
%     
%     AA = cell(20, 10);
%     IA = cell(20, 10);
%     
%     for beta = 0.30:0.01:0.49
%         for RCT = 0.50:0.05:0.95
%             filename = sprintf('res_similar_beta_%.2f_persample_%d_RCT_%.2f.mat',...
%                 beta, sample_per_test, RCT);
%             load([input_path, filename]);
%             valid_similar = cell(num_of_rat, num_of_rat);
%             test_similar = cell(num_of_rat, num_of_rat);
%             for i = 1:num_of_rat
%                 for j = 1:num_of_rat
%                     temp_len = ceil(length(res_similar{i,j})/2);
%                     valid_similar{i,j} = res_similar{i,j}(1:temp_len);
%                     test_similar{i,j} = res_similar{i,j}(temp_len+1:end);
%                 end
%             end
%             total_threshold = find_best_TMT(valid_similar, num_of_rat);
%             temp_x = int16((beta-0.30) / 0.01 + 1);
%             temp_y = int16((RCT-0.50) / 0.05 + 1);
%             [AA{temp_x, temp_y}, IA{temp_x, temp_y}] = test_use_TMT(test_similar,...
%                 total_threshold, num_of_rat);
%         end
%     end
%     
%     file_name = sprintf('res_AA_IA_beta_%.2f_persample_%d_RCT_%.2f.mat', ...
%         beta, sample_per_test, RCT);
%     save([input_path, file_name], 'AA', 'IA');
% end











