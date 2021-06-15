clear;
clc;

all=readmatrix('try.csv');
I = all(:,3);  I0 = I(1:262,:); I1 = I(1:261,:);
N = all(:,8);  N0 = N(1:262,:); N1 = N(1:261,:);
R = all(:,9);  R0 = R(1:262,:); R1 = R(1:261,:);
t = all(:,10); t0 = t(1:262,:); t1 = t(1:261,:);

dRdt = diff(R)./diff(t);

r2 = 0.008253;
r1 = 1/14;

dIdt = diff(I)./diff(t);
E  = ( dIdt + r2 * I0 ) / r1 ; E1 = E(1:261,:);

dEdt = diff(E)./diff(t0);
S = N1 - E1 - I1 - R1 ;

y = dEdt + r1 .* E1;
x = S ./ N1 .* I1;

bet = 0.02357; 