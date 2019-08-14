function sig = getsigma(nRecord, point_record,U, nU,KK)
sig = zeros(nU, 1);
k = zeros(nRecord, 1);

for m = 1 : nU
    for n = 1 : nRecord
       k(n) = kernel(point_record(n, :), U(m, :)); 
    end
    sig(m) = sqrt(kernel(U(m,:),U(m,:)) - k' * KK * k);
end