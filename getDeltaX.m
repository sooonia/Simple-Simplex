function [newBasicIdx, optimal, deltaX] = getDeltaX(fnew, Anew, basic)
   
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
v= fBasic * inv(ABasic);
i=0;
done = false;
while and(~done,i<length(fNonBasic))
    i=i+1;
   if (fNonBasic(i)-(v * ANonBasic(:,i))) < 0
       done = true;
   end
end

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
    deltaXog = -1*inv(ABasic)*ANonBasic(:,i);
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
else
    deltaX = zeros(length(basic));
    newBasicIdx = -1;
    optimal = true;
end

end
