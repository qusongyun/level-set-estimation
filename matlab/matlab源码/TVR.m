function [nRecord,f1score,Lse_H,Lse_L,Lse_nL,fasttime]=TVR(point_sample,num_sample,h,flag)
H = zeros(num_sample, 2);
nH = 0;
L = zeros(num_sample, 2);
nL = 0;
U = point_sample;
nU = num_sample;
D = point_sample;
d = num_sample;
nRecord = 1;
f1score = zeros(num_sample, 1);
fasttime = zeros(num_sample, 1);
point_record = zeros(num_sample, 2);
z = zeros(num_sample, 1); 
sigma = zeros(num_sample, 1);
yita = 1;
gamma = 1;
for i = 1 : nU
    sigma(i) = exp(1); %高斯标准差的初值
end

while(1)
    t1 = clock();
    beta2 = gamma*log(num_sample * nRecord ^ 2);
    s1 = 0.0;   
    for j = 1 : nU
        s1 = s1 + max(beta2 * sigma(j)^2, yita^2);
    end  
    if flag == 1
        index = TVRselectpoint(point_record,nRecord,D,d,U,nU,s1,beta2,yita);
    else
        index = slowTVRselectpoint(point_record,nRecord,D,d,U,nU,s1,beta2,yita);
    end
    point_record(nRecord,:) = D(index,:);
    z(nRecord) = sin(10*point_sample(index,1)) + cos(4*point_sample(index,2)) - cos(3*point_sample(index,1)*point_sample(index,2) + exp(-1) * randn(1));  
    [u,sigma] = get_u_sigma(nRecord,point_record,z,U,nU);  
    U_new  =  zeros(nU, 2);
    nU_new = 0;
    sigma_new = zeros(nU, 1);
    for i = 1 : nU
        up = u(i) + 1.732* sigma(i);
        down = u(i) - 1.732 * sigma(i);            
        if down + 0.2>= h
           nH = nH + 1;
           H(nH,:) = U(i,:);
        else if up - 0.2 < h
               nL = nL + 1;
               L(nL,:) = U(i,:);           
            else 
               nU_new = nU_new + 1;
               U_new(nU_new,:) = U(i,:); 
               sigma_new(nU_new) = sigma(i);   
            end      
        end
    end
    if nU_new == 0
        break;
    end
    if sqrt(beta2)*max(sigma) <=1* yita
        yita = yita * 0.1;
    end

    U = U_new;
    nU = nU_new;
    sigma = sigma_new;
    nRecord = nRecord + 1;
    f1score(nRecord) = score(nU,H,L,nH,nL,h);
    
    fprintf("Record:%d,U:%d,score:%f",nRecord-1,nU,f1score(nRecord));
    if nRecord == 100
        break;
    end
    fasttime(nRecord) = etime(clock(),t1);
    fprintf('\n')   
end
Lse_H = H;
Lse_L = L;
Lse_nL = nL;

