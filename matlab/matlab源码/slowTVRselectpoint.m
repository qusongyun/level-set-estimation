function index =  TVRselectpoint(point_record,nRecord,D,d,U,nU,s1,beta2,yita)
index = 1;
a = 0;
if nRecord == 1
    for i = 1 : d
        point_record(nRecord,:) = D(i,:);
        sig = getsigma(nRecord, point_record, U, nU, exp(1)^2);
        s2 = 0.0;
        for j = 1 : nU
            s2 = s2 + max(beta2 * sig(j)^2, yita^2);
        end
        tmp = s1 - s2;
        if tmp > a
            index = i;
            a = tmp;
        end
    end
else

    for i = 1 : d
        point_record(nRecord,:) = D(i,:);
        KK = zeros(nRecord);
        for p = 1 : nRecord
            for q = 1 : nRecord
                KK(p,q) = kernel(point_record(p, :), point_record(q, :));
            end
        end        
        K = inv(KK + exp(-1)^2*eye(nRecord));
        sig = getsigma(nRecord, point_record, U, nU, K);
        s2 = 0.0;
        for j = 1 : nU
            s2 = s2 + max(beta2 * sig(j)^2, yita^2);
        end
        tmp = s1 - s2;
        if tmp > a
            index = i;
            a = tmp;
        end
    end
end