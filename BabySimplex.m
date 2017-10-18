function [x,z] = BabySimplex(f, A, b)
%solve a linear minimization problem by using a simple variation of the
%simplex algorithm
%Solves min(f' * x) subject to A*x <= b
%        x

%Input:
%f: the objective function. Must be minimization
%A: matrix with all coefficients of less than or equal to constraints
%b: vector with values of right hand sides of all constraints

%Output:
%x: the vector of x's that yields that yields the optimal, minimal solution
%z: the value of the objective function at x


%make slack variables
slack = eye(length(b));
Anew = [A,slack];
fslack = zeros(1,length(b));
fnew = [f,fslack];

%Get intial BFS
x0 = (inv(slack)*b);
[numBasic,numNonBasic] = size(A);
xPrev = [zeros(numNonBasic,1); x0]; 
%Keep track of which variables are basic
basic = [zeros(numNonBasic,1);ones(numBasic,1)];

%Prepare for loop: Get first deltaX and Assume solution bounded 
[nbi,optimal,deltaX] = getDeltaX(fnew, Anew, basic);
bounded = true;

%Keep iterating until found unbounded or stop improving
while(and(~optimal,bounded))
    %Get new X
    lambda = getLambda(deltaX, xPrev);
    xNew = xPrev + lambda.*deltaX;
    
    %Update Basic variable tracker
    %Will only change 1 variable from Basic to NonBasic
    tempBasis = basic;
    %Updates to show new basic variable
    tempBasis(nbi) = 1;
    found = false;
    i=0;
    while and(~found, i<=length(basic))
        i=i+1;
        if and(basic(i)==1,xNew(i) == 0)
            tempBasis(i) = 0;
            found = true;
      
        end
    end
    basic = tempBasis;
    
    %make sure bounded
    if(lambda == inf)
       bounded = false; 
    end
    
    %Set up for next iteration
    xPrev = xNew;
    [nbi,optimal,deltaX] = getDeltaX(fnew, Anew, basic);
end

%return best Solution or print Unbounded
if(bounded)
    x = xNew(1:length(f));
    z = f*x;
else
    print("Unbounded");
    x= inf;
    z= -inf;
end

end




