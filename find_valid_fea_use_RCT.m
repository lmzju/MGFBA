function [valid_collection, train_key] = find_valid_fea_use_RCT(num_of_feature, parameter, subject_fea, RCT, valid_fea)
    % center_mu is a collection of total combinations
    % margin is also a collection of total combinations
    % RCT是一个比例值
    valid_collection = zeros(0,1);
    train_key = string();
    count = 0;
    for i = 1:(num_of_feature-1)
        for j = (i+1):num_of_feature
            count = count + 1;
            temp_fea = [subject_fea(:,i), subject_fea(:,j)];
%             [res_mu, res_sigma] = simulate_2dim_gaussian(temp_fea);
            fea_count = 0;
            train_out_num = cal_2dim_bit(parameter{count,3}, parameter{count,1}, mean(temp_fea));
            if train_out_num ~= '--'
                for k = 1:1:size(temp_fea,1)
                    res_mu = temp_fea(k,:);
                    out_num = cal_2dim_bit(parameter{count,3}, parameter{count,1}, res_mu);
                    if out_num == train_out_num
                        fea_count = fea_count+1;
                    end
                end
                if fea_count/size(temp_fea,1) >= RCT(1)
                    temp_valid_fea = [valid_fea(:,i), valid_fea(:,j)];
                    fea_valid_count = 0;
                    for k = 1:1:size(temp_valid_fea,1)
                        res_mu = temp_valid_fea(k,:);
                        valid_out_num = cal_2dim_bit(parameter{count,3}, parameter{count,1}, res_mu);
                        if valid_out_num == train_out_num
                            fea_valid_count = fea_valid_count+1;
                        end
                    end
                    if fea_valid_count/size(temp_valid_fea,1) >= RCT(2)
                        valid_collection = [valid_collection, count];
                        train_key = train_key + train_out_num;
                    end
                end
            end

        end
    end
    