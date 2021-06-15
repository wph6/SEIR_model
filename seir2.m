clear;              %清空工作区
clc;                %清空命令行
global bet;         %定义全局变量beta
i = 1;
T = zeros(105,1,101); %创建初始T矩阵
H = zeros(105,4,101); %创建初始H矩阵

for bet = 0:0.001:0.1         %改变beta值
    [t,h] = ode45(@SEIR,[0 300],[200000 1000 15000 1000]);  %求解seir模型

    [m0,n0,q0] = size(t);   %输出t矩阵维度   
    [M0,N0,Q0] = size(T);   %输出T矩阵维度
    [m,n,q] = size(h);      %输出h矩阵维度
    [M,N,Q] = size(H);      %输出H矩阵维度

while M0 ~= m0          %输出维度随beta变化 所以比较t,T两矩阵维度 删除大矩阵多余行以便实现矩阵赋值
    if(M0>m0)
       T(end,:,:) = [];
       m0 = m0+1;
    end
    if(M0<m0)
       t(end,:,:) = [];
       m0 = m0-1;
    end       
end

while M ~= m            %比较h,H两矩阵维度 删除大矩阵多余行
   if(M>m)
       H(end,:,:) = [];
       m = m+1;
   end
   if(M<m)
       h(end,:,:) = [];
       m = m-1;
   end       
end

    T(:,:,i) = t ;  %将求解得到矩阵赋值给T
    H(:,:,i) = h ;  %将求解得到矩阵赋值给H

    i=i+1;
    
end

beta =  0:0.001:0.1;
surf( beta ,squeeze(  T(:,1,:) ),squeeze(  H(:,1,:) )   )%去除矩阵多余维度并绘制图像


function out=SEIR(t,x)          %定义SEIR模型
    global bet;                     %一个易感状态个体在单位时间内与感染个体接触并且被传染的概率
    r1 = 1/14;                      %转化率
    r2 = 0.008253;                  %恢复率
    N = x(1) + x(2) + x(3) + x(4);  %Texas洲种群总人数

    out =[                          %模型方程
            -bet * x(1) / N * x(3);
            bet * x(1) / N * x(3) - r1 * x(2);
            r1 * x(2) - r2 * x(3);
            r2 * x(3);
                        ];
end