%% Shows what fraction of annual income is paid as taxes
% Disclaimer: does not factor standard of living, social safety nets,
% pension, government benefits, etc
resolution = 0.01; % resolution of horizontal axis in thousands of dollars
maxIncome = 320;
rawIncome = linspace(0,maxIncome,maxIncome/resolution+1); % horizontal axis

%% Forex rates
USD_SGD = 1.42;
GBP_SGD = 1.76;
AUD_SGD = 1.07;
SEK_SGD = 0.16;

%% Get data - may not be comparable (take with a pinch of salt)
% Singapore (2017) 
% source: https://www.iras.gov.sg/irashome/Individuals/Locals/Working-Out-Your-Taxes/Income-Tax-Rates/
SG = progTax(rawIncome,1,[20 30 40 80 120 160 200 240 280 320 0],...
    [0 0.02 0.035 0.07 0.115 0.15 0.18 0.19 0.195 0.2 0.22]);
% USA federal taxes for singles only
% source: https://www.irs.com/articles/2015-federal-tax-rates-personal-exemptions-and-standard-deductions
US = progTax(rawIncome,USD_SGD,[9.225 37.45 90.75 189.3 411.5 413.2 0],...
    [0.1 0.15 0.25 0.28 0.33 0.35 0.396]);
% UK
% source: https://www.gov.uk/income-tax-rates/current-rates-and-allowances
UK = progTax(rawIncome,GBP_SGD,[11 43 150 0],[0 0.2 0.4 0.45]);
% Australia
% source: https://www.ato.gov.au/rates/individual-income-tax-rates/
AU = progTax(rawIncome,AUD_SGD,[18.2 37 87 180 0],[0 0.19 0.325 0.37 0.45]);
% Sweden (technically a 31% municipality tax rate)
% source: https://home.kpmg.com/xx/en/home/insights/2011/12/sweden-income-tax.html
SE = progTax(rawIncome,SEK_SGD,[430.2 625.8 0],[0 0.2 0.25]);
SE = SE + 0.321;

%% Plot data
figure;
hold on;
plot(Raw_Income,SG);
plot(Raw_Income,US);
plot(Raw_Income,UK);
plot(Raw_Income,AU);
plot(Raw_Income,SE);
legend('Singapore','USA','UK','Australia','Sweden');
ax = gca;
ax.YLim = [0 0.7];
ax.XLim = [0 Max_Income];
ax.XLabel.String = 'Raw Annual Income in Thousands of Dollars (SGD)';
ax.YLabel.String = 'Fraction of Income Paid as Taxes';