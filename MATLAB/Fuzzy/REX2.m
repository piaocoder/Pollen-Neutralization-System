function [T1]=REX2(A,B);
A=A';B=B';LA=max(size(A));LB=max(size(B));
for i=1:LA
   for j=1:LB
      AB(i,j)=min(A(i),B(j));
   end
end
%Transfer to Column
T1=[];
for i=1:LA
   T1=[T1;AB(i,:)'];
end
T1=T1';

