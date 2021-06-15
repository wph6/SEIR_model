clear;
clc;

[t,h] = ode45(@SEIR,[0 300],[200000 1000 15000 1000]); 
plot(t,h(:,1),'r','linewidth',2);
hold on;
plot(t,h(:,2),'b','linewidth',2);
plot(t,h(:,3),'m','linewidth',2);
plot(t,h(:,4),'g','linewidth',2);
legend('健康人口数量S','暴露者人口数量E','感染人口数量I','移除人口数量R');
title('SEIR模型')

function out=SEIR(t,x)

bet = 0.02357; 
r1 = 1/14;
r2 = 0.008253;
N = x(1) + x(2) + x(3) + x(4);

out =[
    -bet * x(1) / N * x(3);
    bet * x(1) / N * x(3) - r1 * x(2);
    r1 * x(2) - r2 * x(3);
    r2 * x(3);
               ];
end
