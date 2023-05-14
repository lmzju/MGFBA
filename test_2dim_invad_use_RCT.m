function res_similar = test_2dim_invad_use_RCT(input_path, input_test_set, beta, num_of_rat, sample_per_test, ...
    num_of_feature, RCT)

% beta = 0.40;
% num_of_rat = 10;
% sample_per_test = 25;
% num_of_feature = 96;
% input_path = 'run_data_new_2/';

input_file = sprintf('2dim_parameters_beta_%.2f_trainRCT_%.2f_validRCT_%.2f.mat', beta, RCT(1), RCT(2));
load([input_path,input_file]);
total_test_key = cell(1, num_of_rat);
pred_rat = zeros(num_of_rat, 1);
index_table = cell(0,1);
count = 0;
for i = 1:(num_of_feature-1)
    for j = (i+1):num_of_feature
        count = count + 1;
        index_table{count} = [i,j];
    end
end
res_similar = cell(num_of_rat, num_of_rat);
for i = 1:num_of_rat
    temp_valid_collection = total_valid_collection{i};
    target_key = total_train_key{i};
    for j = 1:num_of_rat
%         input_file = sprintf('testset_%d.mat', j);
%         load([input_path,input_file]);
        res_similar{i,j} = auth_regen_key(input_test_set{j}, temp_valid_collection, ...
            sample_per_test, target_key, index_table, total_parameter);
    end
end

filename = sprintf('res_similar_beta_%.2f_persample_%d_trainRCT_%.2f_validRCT_%.2f.mat', beta, sample_per_test, RCT(1), RCT(2));
save([input_path, filename], 'res_similar');













