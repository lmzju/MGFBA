function [res_mu, res_sigma] = simulate_1dim_gaussian(fea)

    pd = fitdist(fea, 'Normal');
    res_mu = pd.mu;
    res_sigma = pd.sigma;

















