clear all; clc;

beta = 0.20:0.01:0.49;
RCT = 0.50:0.05:0.95;
num_of_rat = 10;
input_path = 'run_data_new_3/res_AA_IA_5/';

select_sample = zeros(1,8);
% for sample_per_test = 5:5:40
%     
%     file_name = sprintf('res_AA_IA_persample_%d.mat', sample_per_test);
%     load(file_name);
%     temp_mean = zeros(20,10);
%     for i = 1:20
%         for j = 1:10
%             temp_mean(i,j) = mean(IA{i,j});
%         end
%     end
%     select_sample(sample_per_test/5) = mean(temp_mean, 'all');
% 
% end

sample_per_test = 15;
file_name = sprintf('res_AA_IA_persample_%d.mat', sample_per_test);
load([input_path, file_name]);

% for i = 1:10
%     subplot(3,4,i);
%     res_per_rat = zeros(10,20);
%     for j = 1:num_of_rat
%         for k = 1:30
%             res_per_rat(j, k) = AA{k,i}(j);
%         end
% 
%     end
%     for j = 1:num_of_rat
%         plot(beta, res_per_rat(j,:));
%         hold on;
%     end
%     xlim([0.20 0.49]);
%     xlabel('\beta');
% %     title_name = sprintf('RCT = %.2f', RCT(i));
% %     subtitle(title_name);
% end


select_RCT_index = 7;

res_per_rat = zeros(9,30);
for j = 1:num_of_rat
    for k = 1:30
        res_per_rat(j, k) = AA{k,select_RCT_index}(j);
    end

end

res_per_rat = roundn(res_per_rat, -2);
res_avg = mean(res_per_rat);
res_per_rat = [res_per_rat; mean(res_per_rat)];
res_per_rat = res_per_rat';

res_per_rat_2 = zeros(9,30);
for j = 1:num_of_rat
    for k = 1:30
        res_per_rat_2(j, k) = IA{k,select_RCT_index}(j);
    end

end

res_per_rat_2 = roundn(res_per_rat_2, -2);
res_avg = [res_avg; mean(res_per_rat_2)];
res_avg = res_avg';
res_per_rat_2 = [res_per_rat_2; mean(res_per_rat_2)];
res_per_rat_2 = res_per_rat_2';

res = [res_per_rat, res_per_rat_2];













