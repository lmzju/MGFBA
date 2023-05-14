function total_threshold = find_best_TMT(res_similar, num_of_rat)
% res_similar是验证集的结果

total_threshold = zeros(1, num_of_rat);
for i = 1:num_of_rat
    self_similar = res_similar{i,i};
    min_self_similar = min(self_similar);
    other_similar = zeros(1,0);

    for j = 1:num_of_rat
        if j ~= i
            other_similar = [other_similar, res_similar{i,j}];
        end        
    end
    max_other_similar = max(other_similar);
    min_self_similar = roundn(min_self_similar, -2);
    max_other_similar = roundn(max_other_similar, -2);
    
    if min_self_similar >= max_other_similar
        total_threshold(i) = (min_self_similar + max_other_similar) / 2;
    else
        max_judgement = 0;
        target_threshold = max_other_similar;
        for j = min_self_similar:0.01:max_other_similar
            auth_accu = length(find(self_similar>=j)) / length(self_similar);
            invad_accu = length(find(other_similar>=j)) / length(other_similar);
            if invad_accu < 0.05
                judgement = auth_accu;
                if judgement > max_judgement
                    max_judgement = judgement;
                    target_threshold = j;
                end
            end
        end
        total_threshold(i) = target_threshold;
%         total_threshold(i) = max_other_similar;
    end

end




















