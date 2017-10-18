function [newBasicIdx, optimal, deltaX] = getDeltaX(fnew, Anew, basic)
%Function to find next direction vector. Uses ideas from revised simplex to
%ease calculation complexity.

%Input:
%fnew: objective function (minimization) with added slack variables
%Anew: 'A' matrix with added slack variables (standardized)
%basic: vector of 0/1 flags of which variables are basic

%Output:
%newBasicIdx: 
%optimal: true if no improving direction found; i.e. optimal solution
%   found. Otherwise returned false.
%deltaX: direction vector



%Divide A and f into basic and nonbasic parts
fBasic=[];
ABasic=[];
ANonBasic = [];
fNonBasic = [];
for i=1:1:length(basic)
   if basic(i)==1
       
       fBasic = [fBasic , fnew(i)];
       ABasic = [ABasic,Anew(:,i)];
       
   else
       fNonBasic = [fNonBasic , fnew(i)];
       ANonBasic = [ANonBasic,Anew(:,i)];
   end   
end
%Formula from revised simplex to calculate pricing vector
v= fBasic * inv(ABasic);
i=0;
done = false;
while and(~done,i<length(fNonBasic))
    i=i+1;
    %Evaluate reduced cost
    %Check if improving
   if (fNonBasic(i)-(v * ANonBasic(:,i))) < 0
       done = true;
   end
end

%If an improving direction is found, calculate it
if done
    %Find idx of new Basic Var
    m=0;
    for n=1:length(basic)
       if basic(n) == 0
          m=m+1;
          if m==i
              newBasicIdx = n;
          end
       end
    end
    %DeltaX computed only for original basic variables
    deltaXog = -1*inv(ABasic)*ANonBasic(:,i);
    %Use basic flags to fill in the rest of the deltaX vector
    k=1;
    deltaX = zeros(length(basic),1);
    for j = 1:length(basic)
        if j == newBasicIdx
            deltaX(j,1) = 1;
        elseif basic(j,1) == 1
                deltaX(j,1) = deltaXog(k);
                k=k+1;
        else
            deltaX(j,1) = 0;
        end
            
    end
    optimal = false;
%improving solution could not be found
else
    deltaX = zeros(length(basic));
    newBasicIdx = -1;
    optimal = true;
end

end
