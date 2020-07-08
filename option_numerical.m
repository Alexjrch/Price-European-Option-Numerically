% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%   Some self-defined functions will be called in this script:    %
%                                                                 %
%   BSCall  -- price call option via Black-Scholes                %
%   BiTree  -- price call option via Binominal Tree               %
%   MCCall  -- price call option via Monte Carlo simulation       %
%   EFDCall -- price call option via Explicit Finite Difference   %
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % %
%% Input Variables
%  strike price
strike=[3400;3350;3300;2900;2800;2550;2275;2000;1100;1000];
%  real option price
option=[35.81;47;63.57;255.22;319.48;501.38;677.71;899.97;1431.28;1842.29];
%  underlying price
asset = 2929.8;
%  risk-free rate
rf    = 0.0021;
%  volatility
vola  = 0.31;
%  maturity
mat   = 223/365;

%% BSmodel option price
BS    = [0,0,0,0,0,0,0,0,0,0];
Delta = [0,0,0,0,0,0,0,0,0,0];
for num = 1:10
    [bsc,delta] = BSCall(asset,strike(num),rf,vola,mat);
    BS(num) = bsc;
    Delta(num) = delta;
end

%% Binominal Tree option price
BT = [0,0,0,0,0,0,0,0,0,0];
for num = 1:10
    [StM,CtM,CtM11] = BiTree(asset,strike(num),rf,vola,mat,5000);
    BT(num) = CtM11;
end

%% Monte Carlo option price
MC = [0,0,0,0,0,0,0,0,0,0];
for num = 1:10
    MC(num) = MCCall(asset,strike(num),rf,vola,mat,500000);
end

%% Explicit FDM option price
FD = [0,0,0,0,0,0,0,0,0,0];
for num = 1:10
    [price,vals] = EFDCall(asset,strike(num),rf,mat,vola,100,1/365,6000,0);
    FD(num) = price;
end

%% Plot approximated price with markt price
figure();
plot(strike,BS,'o'); hold on;
plot(strike,BT,'*'); hold on;
plot(strike,MC,'s'); hold on;
plot(strike,FD,'^'); hold on;
plot(strike,option,'-.'); hold on;
xlabel('Strike Price');
ylabel('Option Price');
legend('Black-Scholies','Binominal Tree','Monte Carlo',...
    'Finite Difference','Real Time'); hold off;

%% Plot BS option price
figure();
scatter(strike,BS,'o','filled'); hold on;
xlabel('Strike Price');
ylabel('Option Price');
title('Black-Scholes Option Price');hold off;

%% Plot option price from binominal tree
figure();
scatter(strike,BT,'o','filled'); hold on;
xlabel('Strike Price');
ylabel('Option Price');
title('Binominal Tree Option Price');hold off;

%% Plot option price from Monte Carlo simulation
figure();
scatter(strike,MC,'o','filled'); hold on;
xlabel('Strike Price');
ylabel('Option Price');
title('Monte Carlo Option Price');hold off;

%% Plot option price from explicit FDM
figure();
scatter(strike,FD,'o','filled'); hold on;
xlabel('Strike Price');
ylabel('Option Price');
title('Explicit Finite Difference Option Price');hold off;

%% Calculate Delta Hedging Ratio
hedge = [0,0,0,0,0,0,0,0,0,0];
for num = 1:10
    hedge(num) = 100/Delta(num);
end
