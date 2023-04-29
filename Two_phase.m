clear ;
clc
% max z=-3x1-5x2-Ma1-Ma2+0s1+0s2
% x1+3x2-s1+a1=3
% x1+x2-s2+a2=2
% xi>=0
%either use code for standardization or input it already in  standard form
a=[1 3 -1 0 1 0;1 1 0 -1 0 1];
b=[3;2];
A=[a b];
M=1000;
cost=[-3 -5 0 0 -M -M 0];
n=size(A,1);
var={'x1','x2','s1','s2','a1','a2','sol'};
ovar={'x1','x2','s1','s2','sol'};
cost1=[0 0 0 0 -1 -1 0];
bv=[5 6];
artificial_var=[5 6];
zj_cj=cost1(bv)*A-cost1;
% A=[A;zj_cj];
simplex_table=[A;zj_cj];
array2table(simplex_table,'VariableNames',var);
run=true;
while(run)
        zc=zj_cj(1:end-1);
        if any(zc<0)
            [ent_var,pvt_col]=min(zc);
            if all(A(:,pvt_col)<=0)
                error('LPP has unbounded solution');
            else
                sol=A(:,end);
                col=A(:,pvt_col);
                for i=1:size(A,1)
                    if col(i)>0
                        ratio(i)=sol(i)./col(i);
                    else
                        ratio(i)=inf;
                    end
                end
                 [leaving_val,pvt_row]=min(ratio);
            end
            bv(pvt_row)=pvt_col;
                pvt_key=A(pvt_row,pvt_col);
                A(pvt_row,:)=A(pvt_row,:)./pvt_key;
                for i=1:size(A,1)
                    if i~=pvt_row
                        A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:);
                    end
                end
                zj_cj=cost1(bv)*A-cost1;
                next_table=[zj_cj;A];
                array2table(next_table,'VariableNames',var);
       else
                run=false;
                if any(bv==artificial_var(1))
                    fprintf('No optimal solution')
                    run2 = false;
                elseif any(bv==artificial_var(2)) 
                    fprintf('No optimal solution')
                    run2 = false;
                else
                    run2 = true;
                end
        end
end
if run2==true
    A(:,artificial_var)=[];
    cost(:,artificial_var)=[];
    run=true;
    zj_cj=cost(bv)*A-cost;
    while(run)
        zc=zj_cj(1:end-1);
        if any(zc<0)
            [ent_var,pvt_col]=min(zc);
            if all(A(:,pvt_col)<=0)
                error('LPP has unbounded solution');
            else
                sol=A(:,end);
                col=A(:,pvt_col);
                for i=1:size(A,1)
                    if col(i)>0
                        ratio(i)=sol(i)./col(i);
                    else
                        ratio(i)=inf;
                    end
                end
                 [leaving_val,pvt_row]=min(ratio);
            end
            bv(pvt_row)=pvt_col;
                pvt_key=A(pvt_row,pvt_col);
                A(pvt_row,:)=A(pvt_row,:)./pvt_key;
                for i=1:size(A,1)
                    if i~=pvt_row
                        A(i,:)=A(i,:)-A(i,pvt_col)*A(pvt_row,:);
                    end
                end
                zj_cj=cost(bv)*A-cost;
                next_table2=[zj_cj;A];
                array2table(next_table2,'VariableNames',ovar);
       else
                run=false;
                fprintf('optimal value is %f\n',zj_cj(end));
        end
    end
end
