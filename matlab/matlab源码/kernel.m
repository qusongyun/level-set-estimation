function ktmp = kernel(x,l)
    ktmp = exp(1)^2*exp(-((x(1)-l(1))^2+(x(2)-l(2))^2)/(2*exp(-1.5)^2));
    %ktmp = exp(-((x(1)-l(1))^2+(x(2)-l(2))^2)/2);
end
