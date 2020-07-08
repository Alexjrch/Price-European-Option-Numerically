function [StM,CtM,CtM11]=BiTree(S0,K,r,s,T,N)
    % compute u d p
    u=exp(s*sqrt(T/N));  %u
    d=1/u;               %d
    Rf=exp(r*T/N);       
    p=(Rf-d)/(u-d);      %p
    % construction of asset price matrix
    Np1=N+1;
    StM=zeros(Np1,Np1);
    StM(1,1)=S0;
    % fill in diagonal
    for i=2:Np1
	    StM(i,i)=StM(i-1,i-1)*d;
	    i=i+1;
    end
    % fill in sub-diagonal
    for i=1:N
	    for j=(i+1):Np1
		    StM(i,j)=StM(i,j-1)*u;
        end
    end
    % compute payoff 
    payoff=StM(:,Np1)-K;
    payoff=[payoff zeros(Np1,1)];
    payoff=max(payoff')';
    % Initialise tree for call option
    CtM=zeros(Np1,Np1);
    CtM(:,Np1)=payoff;
    % iterate backwards
    for j=N:-1:1
	    for i=j:-1:1
		    CtM(i,j)=(p*CtM(i,j+1)+(1-p)*CtM(i+1,j+1))/Rf;
        end
    end
    % call option price
    CtM11=CtM(1,1); 
end 


