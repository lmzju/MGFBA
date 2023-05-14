function res = key_similar(s1, s2)
    s1 = char(s1); s2 = char(s2);
    len_of_string = min(length(s1), length(s2));
    count = 0;
    for i = 1:len_of_string
        if s1(i) == s2(i)
            count = count + 1;
        end
    end
    res = count / len_of_string;