%% Shows how much your annual income is after taxes

Resolution = 0.01; % resolution of horizontal axis in thousands of dollars
Max_Income = 320;
Raw_Income = linspace(0,Max_Income,Max_Income/Resolution+1); % horizontal axis
Vert_Axis = zeros([1 length(Raw_Income)]); % vertical axis

%% Singapore (2017 onwards)
%https://www.iras.gov.sg/irashome/Businesses/Self-Employed/Working-out-your-taxes/Income-Tax-Rates/
SG = Vert_Axis;
for index = 1:length(SG)
    raw = Raw_Income(index);
    if raw < 20
        SG(index) = raw;
    elseif raw < 30
        SG(index) = raw - (raw-20)*0.02;
    elseif raw < 40
        SG(index) = raw - 0.2 - (raw-30)*0.035;
    elseif raw < 80
        SG(index) = raw - 0.55 - (raw-40)*0.07;
    elseif raw < 120
        SG(index) = raw - 3.35 - (raw-80)*0.115;
    elseif raw < 160
        SG(index) = raw - 7.95 - (raw-120)*0.15;
    elseif raw < 200
        SG(index) = raw - 13.95 - (raw-160)*0.18;
    elseif raw < 240
        SG(index) = raw - 21.15 - (raw-200)*0.19;
    elseif raw < 280
        SG(index) = raw - 28.75 - (raw-240)*0.195;
    elseif raw < 320
        SG(index) = raw - 36.55 - (raw-280)*0.2;
    else
        SG(index) = raw - 44.55 - (raw-320)*0.22;
    end
end

%% Sweden
SE = Vert_Axis;
SEK_SGD = 0.16; % SEK/SGD exchange rate
for index = 1:length(SE)
    raw = Raw_Income(index);
    raw_SE = raw/SEK_SGD;
    if raw_SE < 18.8
        SE(index) = raw_SE;
    elseif raw_SE < 433.9
        SE(index) = raw_SE - (raw_SE-18.8)*0.31;
    elseif raw_SE < 615.7
        SE(index) = raw_SE - (433.9-18.8)*0.31 - (raw_SE-433.9)*0.51;
    else
        SE(index) = raw_SE - (433.9-18.8)*0.31 - (615.7-433.9)*0.51 - (raw_SE-615.7)*0.56;
    end
end
SE = SE*SEK_SGD;

%% USA
US = Vert_Axis;
USD_SGD = 1.42; %USD/SGD exchange rate
for index = 1:length(US)
    raw = Raw_Income(index);
    raw_US = raw/USD_SGD;
    if raw_US < 9.225
        US(index) = raw_US - raw_US*0.1;
    elseif raw_US < 37.45
        US(index) = raw_US - 0.9225 - (raw_US-9.225)*0.15;
    elseif raw_US < 90.75
        US(index) = raw_US - 5.15625 - (raw_US-37.45)*0.25;
    elseif raw_US < 189.3
        US(index) = raw_US - 18.48125 - (raw_US-90.75)*0.28;
    elseif raw_US < 411.5
        US(index) = raw_US - 46.07525 - (raw_US-189.3)*0.33;
    elseif raw_US < 413.2
        US(index) = raw_US - 119.40125 - (raw_US-411.5)*0.35;
    else
        US(index) = raw_US - 119.99625 - (raw_US-413.2)*0.396;
    end
end
US = US*USD_SGD;

%% Australia
AU = Vert_Axis;
AUD_SGD = 1.07;
for index = 1:length(AU)
    raw = Raw_Income(index);
    raw_AU = raw/AUD_SGD;
    if raw_AU < 18.2
        AU(index) = raw_AU;
    elseif raw_AU < 37
        AU(index) = raw_AU - (raw_AU-18.2)*0.19;
    elseif raw_AU < 87
        AU(index) = raw_AU - 3.572 - (raw_AU-37)*0.325;
    elseif raw_AU < 180
        AU(index) = raw_AU - 19.822 - (raw_AU-87)*0.37;
    else
        AU(index) = raw_AU - 54.232 - (raw_AU-180)*0.45;
    end
end
AU = AU*AUD_SGD;

%% UK
UK = Vert_Axis;
GBP_SGD = 1.76;
for index = 1:length(UK)
    raw = Raw_Income(index);
    raw_UK = raw/GBP_SGD;
    if raw_UK < 11
        UK(index) = raw_UK;
    elseif raw_UK < 43
        UK(index) = raw_UK - (raw_UK-11)*0.2;
    elseif raw_UK < 150
        UK(index) = raw_UK - (43-11)*0.2 - (raw_UK-43)*0.4;
    else
        UK(index) = raw_UK - (150-43)*0.4 - (43-11)*0.2 - (raw_UK-150)*0.45;
    end
end
UK = UK*GBP_SGD;

%% Graphs
figure;
hold on;
plot(Raw_Income,SG./Raw_Income);
plot(Raw_Income,US./Raw_Income);
plot(Raw_Income,UK./Raw_Income);
plot(Raw_Income,AU./Raw_Income);
plot(Raw_Income,SE./Raw_Income);
legend('Singapore','USA','UK','Australia','Sweden');
ax = gca;
ax.YLim = [0.5 1];
ax.XLim = [0 Max_Income];
ax.XLabel.String = 'Raw Annual Income in Thousands of Dollars (SGD)';
ax.YLabel.String = 'Fraction of Income After Taxes';