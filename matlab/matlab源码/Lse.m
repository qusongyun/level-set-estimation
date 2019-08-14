function [nRecord,f1score,Lse_H,Lse_L,Lse_nL]=Lse(point_sample,num_sample,h)
beta = sqrt(3);%对应置信度为97.5%
H = zeros(num_sample, 2);
nH = 0;
L = zeros(num_sample, 2);
nL = 0;
U = point_sample;
nU = num_sample;
nRecord = 1;
f1score = zeros(num_sample, 1);
point_record = zeros(num_sample, 2);
z = zeros(num_sample, 1); %查询点的结果
C = zeros(num_sample, 2);
Q = zeros(num_sample, 2);
u = zeros(num_sample, 1); %高斯均值的初值
sigma = zeros(num_sample, 1);
for i = 1 : nU
    sigma(i) = exp(1); %高斯标准差的初值
end
while(1)
    U_new  =  zeros(nU, 2);
    nU_new = 0;
    C_new =   zeros(nU, 2);
    for i = 1 : nU
        if nRecord == 1
            C(i,:) = [u(i) - beta * sigma(i),u(i) + beta * sigma(i)];
        
        else
            Q(i,:) = [u(i) - beta * sigma(i),u(i) + beta * sigma(i)];
            C(i, :) = [max(C(i,1), Q(i,1)), min(C(i,2), Q(i,2))];           
        end
        if C(i,1) + 0.2 >= h
           nH = nH + 1;
           H(nH,:) = U(i,:);
        else if C(i,2) - 0.2 < h
               nL = nL + 1;
               L(nL,:) = U(i,:);
            else 
               nU_new = nU_new + 1;
               U_new(nU_new,:) = U(i,:);   
               C_new(nU_new,:) = C(i,:);
            end      
        end
    end
    if nU_new == 0
        break;
    end
    U = U_new;
    C = C_new;
    nU = nU_new;
    a = 0;
    index = 1;
    for i = 1 : nU
        tmp = min(h - C(i,1),C(i,2) - h );
        if tmp > a
            index = i;
            a = tmp;
        end
    end 
    point_record(nRecord,:) = U(index,:);
    z(nRecord) = sin(10*U(index,1)) + cos(4*U(index,2)) - cos(3*U(index,1)*U(index,2)) + exp(-1) * randn(1);
    [u,sigma] = get_u_sigma(nRecord,point_record,z,U,nU);
    nRecord = nRecord + 1;
    f1score(nRecord) = score(nU,H,L,nH,nL,h);
    %fprintf("Record:%d,U:%d,score:%f",nRecord-1,nU,f1score(nRecord));
    %fprintf('\n')
    if nRecord== 100
        break;
    end
end
Lse_H = H;
Lse_L = L;
Lse_nL = nL;
%draw(h, L, nL, f1score(1:nRecord), sample_x, sample_y, H);


