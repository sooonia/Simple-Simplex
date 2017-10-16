%random trial vector
vector = sym([1 0 0 0 2 6 4]);

%switch for assigning a nonbasic variable an assigned value of 1 or 0
s = "on"; 

%initialize the variable that tells us the number of nobasic variables in 
%the vector
nonbasic = 0;

%intializes delta x vector before values of 1 and 0 assigned to nonbasic 
%variables
deltax = sym('x',[1,length(vector)]);

%sets the number of iterations the next loop will go through equal to the
%number of nonbasic variables
for y = 1:length(vector)
    if vector(1,y) == 0
      nonbasic = nonbasic+1;
    end
end

%finds the intial deltax vectors in A*deltax = 0 to be used in solving the
%system of linear eqautions
for z = 1:nonbasic
    
    %goes through each element in the vector and decides if the
    %corrosponding delta x will be set to a 1, 0, or a variable.
    for x = 1:length(vector)
        
       %pulls the element of the vector to be worked with
        element = vector(1,x);
        
        %activates when the switch is off
        if s == "off"
            
            %if the element = 0, the corrosponding deltax is set to 0
            %and if otherwise leaves deltax as a variable
            if element == 0
                newelement = 0;
            else
                newelement = deltax(1,x);
            end
        end
        
        %activates if the switch is on
        if s == "on"
            
            %if the element = "u" sets the deltax to 0
            %and otherwise leaves deltax as a variable
            if element == 'u'
                newelement = 0;
            else
                newelement = deltax(1,x);
            end
            
            %if the element = 0 sets deltax to 1
            if element == 0
                newelement = 1;
                
                %tuns the switch off so only a single nonbasic variable
                %gets set to a value of 1
                s = "off";
                
                %setting the element in the vector to "u" here prevents it 
                %from being set to a variable instead of a 0 when finding 
                %the next deltax vector
                vector(1,x) = 'u';
            end
        end
    
    %changes the element in the deltax vector to the new one the loop
    %assigned (1, 0, variable)
    deltax(x) = newelement;
    end
    
    %turns the switch back on for finding the next deltax vector
    s = "on";
    
    %the completed deltax vector
    deltax
end
