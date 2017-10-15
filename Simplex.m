A= [3 2 1; 1 0 0; 0 1 0];
b = [18 4 3]';
f= [2 4];

function x = Simplex(f, A, b)
%make slack variables
slack = eye(length(b));
Anew = [A,slack];
fslack = zeros(1,length(b));
fnew = [f,fslack];

%Get intial BFS
x0 = (inv(slack)*b);
xPrev = [0;0; x0]; 

deltaX = getDeltaX(fnew, xPrev, Anew, b)

improving = (deltaX * fnew')<0;
bounded = true;

%Keep iterating until found unbounded or stop improving
while(and(improving,bounded))
    %Get new X
    deltaX = getDeltaX(fnew, xPrev, Anew, b);
    lambda = getLambda(deltaX, xPrev);
    xNew = xPrev + lambda.*deltaX;
    
    %make sure still improving and bounded
    improving = (deltaX * fnew')<0;
    if(lambda == inf)
       bounded = false; 
    end
    
    %Set up for next iteration
    xPrev = xNew;
end

%return best Solution or print Unbounded
if(bounded)
    x = xNew;
else
    print("Unbounded");
end



end


