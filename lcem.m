clc;
clear;
%input phase
cost = [11 20 7 8; 21 16 10 12; 8 12 18 9];
A = [50 40 70];
B = [30 25 35 40];
%to check unbalanced/balanced problem
if sum(A)==sum(B)
    fprintf('Given TP is balanced');
else
    fprintf('Given TP is unbalanced');
    if sum(A)<sum(B)
        cost(end+1,:)=zeros(1,size(A,2));
        A(end+1)=sum(B)-sum(A);
    elseif sum(B)<sum(A)
        cost(:,end+1)=zeros(1,size(A,2));
        B(end+1)=sum(A)-sum(B);
    end
end
ICost = cost; %save cost copy
X = zeros(size(cost)); %initialize allocation
[m, n] = size(cost); %finding rows-column
BFS = m + n - 1; %total bfs
%finding the cell with min cost for the allocations
for i=1:size(cost,1)
    for j=1:size(cost,2)
        hh = min(cost(:)); %finding min cost value
        [rowind, colind] = find(hh==cost); %finding position of min cost cell
        x11 = min(A(rowind), B(colind)); %assign allocations to each cost
        [val,ind] = max(x11); %find max allocation
        ii = rowind(ind); %identify row position
        jj = colind(ind); %identify col position
        y11 = min(A(ii),B(jj)); %find the value
        X(ii,jj)=y11; %assign allocation
        A(ii) = A(ii) - y11; %reduce row value 
        B(jj) = B(jj) - y11; %reduce col value
        cost(ii,jj) = Inf; %cell covered
    end
end
%print the initial bfs
fprintf('Initial BFS = \n');
IB = array2table(X);
disp(IB);
%check for degenerate & non degenerate
TotalBFS = length(nonzeros(X));
if TotalBFS == BFS
    fprintf('Initial BFS is Non Degenerate \n');
else
    fprintf('Initial BFS is degenerate \n');
end
%compute the initial transportation cost
initialCost = sum(sum(ICost.*X));
fprintf('Initial BFS Cost = %d\n', initialCost);
