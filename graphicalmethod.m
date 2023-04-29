%CODE 1-GRAPHICAL METHOD
clc
close all
%clear all
A = [1,2;1,1;0,1];
C= [3,5];
B = [2000,1500,600]; %semicolon used to hide solution
X1 = 0:100:max(B) ; %Its value is fixed and the value of X2 is determined
X21=(B(1)- A(1,1).*X1)./A(1,2);
X22=(B(2)- A(2,1).*X1)./A(2,2);
X23=(B(3)-A(3,1).*X1)./A(3,2);
X21=max(0,X21);
X22=max(0,X22);
X23=max(0,X23);
plot (X1,X21,X1,X22,X1,X23)
 
CX1=find(X1==0); %used to find position
C1=find(X21==0);
Line1=[X1(:,[C1,CX1]); X21(:,[C1, CX1])]';
C2=find(X22==0);
Line2=[X1(:,[C2,CX1]); X22(:,[C2, CX1])]';
C3=find(X23==0);
Line3=[X1(:,[C3,CX1]); X23(:,[C3, CX1])]';
corpt=unique([Line1;Line2;Line3],"rows");
%Above used to find the corner points of the lines
 
%to find the INTERSECTION POINTS OF THE LINES
pt=[0 0];
for i=1:size(A,1)%BASICALLY 3
for j=i+1:size(A,1)
A1=A([i,j],:);
B1=B([i,j]);
X=(A1\B1')';%Can also be (inv(A1)*B1')'--same output
pt=[pt;X]
end
end
 
 
allpoints=[pt;corpt]
points=unique(allpoints,"rows")
%There are 12 points in all
%Feasible region
 
for i=1:size(points,1)
const1(i)=A(1,1)*points(i,1)+A(1,2)*points(i,2)-B(1)
const2(i)=A(2,1)*points(i,1)+A(2,2)*points(i,2)-B(2)
const3(i)=A(3,1)*points(i,1)+A(3,2)*points(i,2)-B(3) 
end
S1=find(const1>0);
S2=find(const2>0);
S3=find(const3>0);
S=unique([S1,S2,S3])
points(S,:)=[]
 
%METHOD OF FINDING THE OPTIMAL VALUE BY CHECKING THE POINTS IN THE
%OBJECTIVE FUNCTION--easier method
 
 
Z=points*C'
[obj index]=max(Z)
points(index,:)
 
 
 
 
 
 