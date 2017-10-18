function lambda = getLambda(deltaX, xPrev)
%Function to find largest possible step size while simultaneously remaining in
%feasible region

%Input:
%deltaX: Direction vector
%xPrev: previous value of x (lies on border of feasible region)

%Output:
%lambda: largest possible step size


%Set lambda to max possible value
lambda = inf;
%loop through all deltaX
for i= 1:length(deltaX)
    emma = -1*(deltaX(i));
    %Look only for delta x that are negative (-1*-del = pos)
    if (emma>0)
        k = xPrev(i)/emma;
        %update lambda if new minimum found
        if and(k>=0, k<lambda)
            lambda = k;
        end
    end
    
end
end

