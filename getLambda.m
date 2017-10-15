function lambda = getLambda(deltaX, xPrev)
%Function to find largest value of lambda while simultaneously remaining in
%feasible region

%deltaX: Direction vector
%xPrev: previous value of x (lies on border of feasible region)



%Set lambda to max possible value
lambda = inf;
%j used to keep track of index
j=1;
%loop through all deltaX
for i= -1(deltaX)
    %Look only for delta x that are negative (-1*-del = pos)
    if (i>0)
        k = xPrev(j)/i;
        %update lambda if new minimum found
        if and(k>=0, k<lambda)
            lambda = k;
        end
    end
    %increase index with each iteration
    j= j+1;
    
end
end

