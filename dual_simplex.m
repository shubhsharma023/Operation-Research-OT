% max z=-2x1-x3
% s.t.
% x1+x2-x3>=5
% x1-2x2+4x3>=8
% as all variables are negative or zero in objective function we use dual simplex method
% the equations become
% -x1-x2+x3<=-5
% -x2+2x2-4x3<=-8
cost=[-2 0 -1 0 0 0];
a=[-1 -1 1 1 0 ; -1 2 -4 0 1];
b=[-5;-8];
A=[a b];
bv=[4,5];
var={'x1','x2','x3','s1','s2','sol'};
zj_cj=cost(bv)*A-cost;
simplex_table=[zj_cj;A];
array2table(simplex_table,'VariableNames',var);
run = true;
while(run)
    sol=A(:,end);
    if any(sol<0)
        fprintf('Current BF Sol is not feasible\n');
        [leaving_var,pvt_row]=min(sol);
        for i=1:size(A,2)-1 
            if A(pvt_row,i)<0
                ratio(i)=abs(zj_cj(i)/A(pvt_row,i));
            else
                ratio(i)=inf;
            end
        end
        [entering_var,pvt_col]=min(ratio);
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