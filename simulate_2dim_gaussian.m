function [res_mu, res_sigma] = simulate_2dim_gaussian(fea)
    % fea: (x,y), x是一维特征，y是另一维特征 两列
%     f = fittype('(1/(2*pi*a*b))*exp((-1/2)*(((x-c)/a)^2+((x-d)/b)^2))', 'independent', 'x', 'coefficients', {'a','b','c','d'});
%     opt=fitoptions(f);
%     [x_mu, x_sigma] = simulate_1dim_gaussian(fea(:,1));
%     [y_mu, y_sigma] = simulate_1dim_gaussian(fea(:,2));
%     opt.StartPoint=[x_sigma y_sigma x_mu y_mu];
%     start_mu = [x_mu y_mu];
%     fit_model = fitgmdist(fea, 1);
    res_mu = mean(fea);
    res_sigma = [std(fea(:,1)), std(fea(:,2))];
 
        

















