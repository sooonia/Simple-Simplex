%initialize structures
numVars = 9^3;
f = (1:numVars);
intcon = (1:numVars);
ub=ones(numVars,1);lb=zeros(numVars,1);
A=[];b=[];
beq=ones(81*4,1); %add the set values to beq at end
%vars
%Xijk  i=row j=col k=intValueInCell
%Xijk = 1 if value in cell i,j is = k
%now set up constraints
%x111+x121+x131 ... only one "1" can be in a row
%do for all rows and integers
%sum j=1 to 9 Xijk = 1 for all i,k 

%rows
row=[eye(9),eye(9),eye(9),eye(9),eye(9),eye(9),eye(9),eye(9),eye(9)];
RowCons=blkdiag(row,row,row,row,row,row,row,row,row);
%cols 
ColCons=[eye(81),eye(81),eye(81),eye(81),eye(81),eye(81),eye(81),eye(81),eye(81)];
%cells
cell=ones(1,9);
cell2=blkdiag(cell,cell,cell,cell,cell,cell,cell,cell,cell);
CellCons=blkdiag(cell2,cell2,cell2,cell2,cell2,cell2,cell2,cell2,cell2);
%boxes
Z=[eye(9),eye(9),eye(9)];
Z2=blkdiag(Z,Z,Z);
Z3=[Z2,Z2,Z2];
BoxCons=blkdiag(Z3,Z3,Z3);
%now put it all together
Aeq=[RowCons;ColCons;CellCons;BoxCons];

%add on the set value constraints and beq rows
vals = input('Enter the given cells in matrix format ( [row,col,value;])\n');

[r,c] = size(vals);

for row=1:1:r %loop through the given values and add to Aeq and beq
    %easy part, add a 1 to the bottom of beq
    beq=[beq;1];
    %now the hard part, adding the 1 in the right cell of an 1x729 vector
    %row=vals(row,1) col=vals(row,2) k=vals(row,3) assuming the user put the
    %matrix in right
    temp = zeros(1,729);
    place=1;
    for i=1:1:vals(row,1)
        %place=place+1;
        for j=1:1:vals(row,2)
            place=place+9;
        end
    end
    temp(place+vals(row,3)) = 1;
    Aeq=[Aeq;temp];
end


%find out the solution
z = intlinprog(f,intcon,A,b,Aeq,beq,lb,ub);

%print out the values for each cell
AnsMatrix=zeros(9,9);
place=1;
for i=1:1:9
    %place=place+1;
    for j=1:1:9
        t = z(place:place+8);
        AnsMatrix(i,j)=find(t);
        place=place+9;
    end
end
