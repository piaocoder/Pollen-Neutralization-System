function C = A_jiao_B(A,B)
%输入A是行向量,B也是行向量,
%输出C也是行向量
for i = 1 : 1 : length(A)
    C(i) = min_1(A(i),B(i));
end