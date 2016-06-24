%双输入时模糊决策子程序fuzzy_Deduce.m
function [FU,feec]=fuzzy_deduce(fe,fec,R)
% FU      表示(E'×EC')。R
% feec    表示E'×EC'
% fe      表示e模糊化后对应的模糊子集所对应的隶属度函数
% fec     表示ec模糊化后对应的模糊子集所对应的隶属度函数
% R       表示全体规则构成的模糊关系

%#######################计算E×EC#####################################
n=0;
nfe=size(fe,2);                                                             % nfe 表示E的等级量个数,示例1中其论域为{-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6}
nfec=size(fec,2);                                                           % nfec 表示EC的等级量个数,示例1中其论域为{-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6}
nfu=size(R,2);                                                              % nfu 表示U的等级量个数,示例1中其论域为{-7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7}
feec=zeros(nfe*nfec,1);
fu=zeros(nfe*nfec,1);
FU=zeros(1,nfu);
for i=1:nfe
    for j=1:nfec
        n=n+1;
        if fe(i)<fec(j)
            feec(n)=fe(i);
        else
            feec(n)=fec(j);
        end
    end
end
%#######################计算(E×EC)。R################################
for l=1:nfu
    for i=1:n
        if feec(i)<R(i,l)
            fu(i)=feec(i);
        else
            fu(i)=R(i,l);
        end
        FU(l)=max(fu);
    end
end
