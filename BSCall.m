function [bsc,delta] = BSCall(S0,K,r,sig,T)
    stau=sqrt(T);
    % d1
    d1=(log(S0./(K.*exp(-r.*T))))./(sig.*stau)+0.5*sig.*stau;
    % d2
    d2=d1-sig.*stau;
    % call option price
    bsc=S0.*normcdf(d1)-K.*exp(-r.*T).*normcdf(d2);
    % delta
    delta = normcdf(d1);
end

