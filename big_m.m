                            clear;
clc
% max z=5x1+3x2
% x1+x2+s1=2
% 5x1+2x2+s2=10
% 2x1+8x2-s3+a3=12
% xi>=0
%either use code for standardization or input it already in  standard form
a=[1 1 1 0 0 0;5 2 0 1 0 0; 2 8 0 0 -1 1];
b=[2;10;12];
A=[a b];
M=1000;
cost=[5 3 0 0 0 -M 0];    
n=size(A,1);
var={'x1','x2','s1','s2','s3','a3','sol'};
bv=[3 4 6];
artificial_var= [6];
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
                if any(bv==artificial_var(1))
                    fprintf('No optimal solution')
                else
                    fprintf('optimal value is %f\n',zj_cj(end));
                end
        end
end
        
        