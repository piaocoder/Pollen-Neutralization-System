function [R]=REX3(E,DE,U);
for i=1:7
   for j=1:5
      AB(i,j)=min(E(i),DE(j));
   end
end
%Transfer to Column
T1=[];
for i=1:7
   T1=[T1;AB(i,:)'];
end
%Get fuzzy R
for i=1:35
   for j=1:5
      R(i,j)=min(T1(i),U(j));
   end
end
