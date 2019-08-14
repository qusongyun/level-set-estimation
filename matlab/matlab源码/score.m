function score = score(nU,H,L,nH,nL,h)
    TP = 0;
    FP = 0;
    FN = nU;
    for i = 1 : nH
        if sin(10*H(i,1)) + cos(4*H(i,2)) - cos(3*H(i,1)*H(i,2)) >= h
            TP = TP + 1;
        else 
            FP = FP + 1;
        end
    end
    for i = 1 : nL
        if sin(10*L(i,1)) + cos(4*L(i,2)) - cos(3*L(i,1)*L(i,2)) >= h
            FN = FN + 1;
        end
    end
    if (TP + FP)==0 || (TP + FN) == 0
        score = 0;
    else
        score = 2*TP/(TP*2+FN+FP);
    end