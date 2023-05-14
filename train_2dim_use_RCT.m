function [] = train_2dim_use_RCT(input_path, input_train_set, input_valid_set, num_of_rat, num_of_feature, beta, RCT)
% num_of_rat = 10;
% num_of_feature = 96;
% beta = 0.35;
% input_path = 'run_data_new_2/';
% 单个大鼠所有特征.mat = n1*96 dim
% 单个特征所有大鼠.mat = 平铺dim

%计算所有特征的中心点,margin
total_parameter = cell(0, 3); % 96*3, mu, sigma, margin
count = 0;
% 合并数据
total_mix_feature = zeros(0, num_of_feature);
for k = 1:num_of_rat
    % 归一化
%     train_set = zscore(train_set');
%     train_set = train_set';
    % PCA
%     train_set = pca(train_set);
%     train_set = train_set(:,1:num_of_feature);
%     train_set = input_train_set;
    total_mix_feature = [total_mix_feature; input_train_set{k}];
end

for i = 1:(num_of_feature-1)
    for j = (i+1):num_of_feature
        count = count + 1;
        temp_mix_feature = [total_mix_feature(:,i), total_mix_feature(:,j)];
        [center_mu, center_sigma] = simulate_2dim_gaussian(temp_mix_feature);
        margin_x = cal_1dim_margin(center_sigma(1), beta)
        margin_y = cal_1dim_margin(center_sigma(2), beta)
        total_parameter{count,1} = center_mu;
        total_parameter{count,2} = center_sigma;
        total_parameter{count,3} = [margin_x, margin_y];
    end
end

total_valid_collection = cell(1,num_of_rat);
total_train_key = cell(1,num_of_rat);
for i = 1:num_of_rat
%     file_name = sprintf('trainset_%d.mat', i);
%     load([input_path, file_name]);
    % 归一化
%     train_set = zscore(train_set');
%     train_set = train_set';
    % PCA
%     train_set = pca(train_set);
%     train_set = train_set(:,1:num_of_feature);

%     file_name = sprintf('valid_test_set_%d.mat', i);
%     load([input_path, file_name]);
%     valid_set = zscore(valid_set');
%     valid_set = valid_set';
%     valid_set = pca(valid_set);
%     valid_set = valid_set(:, 1:num_of_feature);

    [valid_collection, train_key] = find_valid_fea_use_RCT(num_of_feature, total_parameter, input_train_set{i}, RCT, input_valid_set{i});
    total_valid_collection{i} = valid_collection;
    total_train_key{i} = train_key;
end

output_file = sprintf('2dim_fea_%d_parameters_beta_%.2f_trainRCT_%.2f_validRCT_%.2f.mat', num_of_feature, beta, RCT(1), RCT(2));
save([input_path,output_file], 'total_parameter', 'total_valid_collection', 'total_train_key');




