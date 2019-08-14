function [u, sigma] = get_u_sigma(nRecord, point_record, z, U, num_U)

u = zeros(num_U, 1);
sigma = zeros(num_U, 1);
k = zeros(nRecord, 1);

KK = zeros(nRecord);
for n = 1 : nRecord
    for p = 1 : nRecord
        KK(n,p) = kernel(point_record(n, :), point_record(p, :));
    end
end
KK = inv(KK + exp(-1)^2*eye(nRecord));
for m = 1 : num_U
    for n = 1 : nRecord
       k(n) = kernel(point_record(n, :), U(m, :)); 
    end
    u(m) = k' * KK * z(1 : nRecord);
    sigma(m) = sqrt(kernel(U(m,:),U(m,:)) - k' * KK * k);
end