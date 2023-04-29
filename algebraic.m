
 
 
%CODE 2- ALGEBRAIC METHOD
 
clc;
close all;
clear all;
A=[2,3,-1,4;1,-2,6,-7];
B=[8;-3];
C=[2,3,4,7];
 
m=size(A,1); %Picks up the number of rows-2
n=size(A,2); %Picks up the number of columns-4
%We choose the number of variables to set as 0 by using n-m
if (n>m)
nCm=nchoosek(n,m);
p=nchoosek(1:n,m) %There are as many 0s as there are n-m-these are non-basic and the rest are basic:m
sol=[]
for i=1:nCm
y=zeros(n,1)
A1=A(:,p(i,:)) %A(:,1) means first column whereas A(1,:) means the first row
X=A1\B
if all(X>=0 & X~=inf)
y(p(i,:))=X
sol=[sol y]
end
end
%Checking the constraint
z=C*sol
[obj index]=max(z);
values=sol(:,index)
obj
else
error('No. of constraints>No. of variables')
end