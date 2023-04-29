clear;
clc
% max z=2x1+3x2
% x1+2x2+x3+s1=10
% 2x1+x2-x3+s2=6
% x1+x2+s3=2
% xi>=0
%either use code for standardization or input it already in  standard form
a=[1 2 1 0 0 ; 1 1 0 1 0; 1 -1 0 0 1];
b=[10;6;2];
A=[a b];
cost=[2 1 0 0 0 0];
n=size(A,1);
var={'x1','x2','s1','s2','s3','sol'};
bv=[3 4 5];
zj_cj=cost(bv)*A-cost;
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
                zj_cj=cost(bv)*A-cost;
                next_table=[zj_cj;A];
                array2table(next_table,'VariableNames',var);
       else
                run=false;
                fprintf('optimal value is %f\n',zj_cj(end));
        end
end