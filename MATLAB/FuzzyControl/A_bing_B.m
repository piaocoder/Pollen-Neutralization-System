function C = A_bing_B(A,B)
%输入A和B都是行向量
%输出C也是行向量
for i = 1 : 1 : length(A)
    C(i) = max_1(A(i),B(i));
end