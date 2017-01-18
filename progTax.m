function fracIncome = progTax(rawIncome,forex,taxBracket,taxRate)
%% Inputs
% rawIncome: vector of raw income (local currency) for the horizontal axis
% forex: exchange rate
% taxBracket: array of values for upper limit of tax bracket, last element
% should be 0 to indicate maximum tax rate
% taxRate: array of corresponding values for tax rate for each tax bracket
% (= 0 if first tax bracket is tax free)
% NOTE taxBracket should be in foreign currency

% e.g. taxBracket = [20 30 0] and taxRate = [0 0.1 0.2]
% first 20k is tax free, next 10k is taxed at 10% and anything over 30k is
% taxed at 20%
%% Outputs
% fracIncome: returns a vector of fraction of raw income paid as taxes for
% the vertical axis
% (value between 0 and 1)

fracIncome = rawIncome;
for index = 1:length(fracIncome)
    raw = rawIncome(index)/forex; % forex adjusted income
    tax = 0; % accumulate amount here
    for bracket = 1:length(taxBracket)
        if bracket == 1 % first tax bracket
            if raw < taxBracket(1)
                tax = raw*taxRate(1);
            else % full tax for first tax bracket
                tax = taxBracket(1)*taxRate(1);
            end
        elseif raw > taxBracket(bracket-1)
            if raw < taxBracket(bracket) || taxBracket(bracket) == 0
                % raw income in current bracket
                tax = tax + (raw-taxBracket(bracket-1))*taxRate(bracket);
            else % add only the taxable portion of income
                tax = tax + (taxBracket(bracket)-taxBracket(bracket-1))*taxRate(bracket);
            end
        else % tax rate no longer applies
            break
        end
    end
    fracIncome(index) = tax/raw; % store as a fraction
end
end