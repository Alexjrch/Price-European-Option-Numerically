function [price,vals] = EFDCall(s0,k,r,T,sig,ds,dt,smax,smin)
M = round((smax-smin)/ds);          % number of grids for price
N = round(T/dt);                    % number of grids for time
ds = (smax-smin)/M;                 % reproduce price increment
dt = T/N;                           % reproduce time increment
vals = zeros(M+1,N+1);              % empty matrix of call price
vs = linspace(smin,smax,M+1)';      % 2-d plane
vt = linspace(0,T,N+1);         
j = 0:M;
vi = 0:N;
vals(:,N+1) = max(vs-k,0);          % boundary condition
vals(1,:) = 0;
vals(M+1,:) = smax-k*exp(-r*dt*(N-vi));  
a = (-0.5*r*j*dt+0.5*sig.^2*j.^2*dt)/(1+r*dt);
b = (1-sig.^2*j.^2*dt)/(1+r*dt);    % approximate BS PDE
c = (0.5*r*j*dt+0.5*sig.^2*j.^2*dt);
for m = N:-1:1                      % backward solve call price
    for i = 2:M
        vals(i,m) = a(i)*vals(i-1,m+1)+...
            b(i)*vals(i,m+1)+c(i)*vals(i+1,m+1);
    end
end
price = interp1(vs,vals(:,1),s0);   % interpolation
end