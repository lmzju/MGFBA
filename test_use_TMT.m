function [AA, IA] = test_use_TMT(res_similar, total_threshold, num_of_rat)

% total_threshold所有大鼠的阈值
AA = zeros(1, num_of_rat);
IA = zeros(1, num_of_rat);
for i = 1:num_of_rat
    self_similar = res_similar{i,i};
    AA(i) = length(find(self_similar>=total_threshold(i))) / length(self_similar);
    other_similar = zeros(1,0);
    for j = 1:num_of_rat
        if j ~= i
            other_similar = [other_similar, res_similar{i,j}];
        end
    end
    IA(i) = length(find(other_similar>=total_threshold(i))) / length(other_similar);

end

















