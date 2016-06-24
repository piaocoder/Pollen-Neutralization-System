function C = A_compose_B(A,B)
% C = A 合成 B,其中A是行向量,B是矩阵.
% 先求小，再求大
d = size(B);
for i = 1 : 1: d(2)
    temp_max = min_1(A(1),B(1,i));
    for j = 2 : 1 : d(1)
        if(temp_max <min_1(A(j),B(j,i)))
            temp_max = min_1(A(j),B(j,i));
        end
    end
        C(i) = temp_max;
end
  
    
