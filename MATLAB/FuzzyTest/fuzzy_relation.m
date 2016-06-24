%模糊关系计算子程序fuzzy_relation.m
function [R,n,nE,nEC,nU,nfe,nfec,nfu]=fuzzy_relation(Me,Mec,Mu,UC)
% Me  隶属度表1
% Mec 隶属度表2
% Mu  隶属度表3
% UC  模糊规则
% R 表示全体规则构成的模糊关系
% n=nfe×nfec
% nE 模糊变量E的语言值个数
% nEC 表示模糊变量EC的语言值个数
% nU 表示模糊变量U的语言值个数
% nfe 表示E的等级量个数,示例1中其论域为{-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6}
% nfec 表示EC的等级量个数,示例1中其论域为{-6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6}
% nfu 表示U的等级量个数,示例1中其论域为{-7 -6 -5 -4 -3 -2 -1 0 1 2 3 4 5 6 7}
% Me 表示E的隶属度表
% Mec 表示EC的隶属度表
% Mu表示U的隶属度表
% UC表示规则表

nE=size(Me,1);                                                              %模糊变量E的语言值个数
E=nE:-1:1;                                                                  %E(1:nE)依次表示E的模糊语言子集An,An-1,...,A1
nfe=size(Me,2);                                                             %E的等级量个数,其论域为{-(nfe-1)/2  ... -1 0 1 ... (nfe-1)/2}

nEC=size(Mec,1);                                                            %模糊变量EC的语言值个数
EC=nEC:-1:1;                                                                %EC(1:nEC)依次表示EC的模糊语言子集Bn,Bn-1,...,B1
nfec=size(Mec,2);                                                           %EC的等级量个数,其论域为{-(nfec-1)/2  ... -1 0 1 ... (nfec-1)/2}

nU=size(Mu,1);                                                              %模糊变量U的语言值个数                                                      
nfu=size(Mu,2);                                                             %U的等级量个数,
                                               
nfc=size(UC,2);                                                             %模糊规则控制表列数
mfc=size(UC,1);                                                             %模糊规则控制表行数
%###########################计算R=（E×EC×U）#############################
%######分解计算为R=∨R(i,j) (i=1->mfc,j=1->nfc,∨表示max(a,b))##############
%#R(i,j)=E(i)×EC(j)×U(i,j)=reshape((E(i))'。EC(j))',nfe*nfec,1)。U(i,j)##
%#####。为合成运算符，具体请参考合成运算符定义.docx##########################
%#####在本例中总共有7×7=49条规则###########################################
R=zeros(nfe*nfec,nfu);
Reec=zeros(nfe,nfec);
Reecu=zeros(nfe*nfec,nfu);
for i=1:mfc
    for j=1:nfc
        %E×EC
        ie=E(j);
        iec=EC(i);
        for k=1:nfe
            for l=1:nfec
                if Me(ie,k)<Mec(iec,l)
                    Reec(k,l)=Me(ie,k);
                else
                    Reec(k,l)=Mec(iec,l);
                end
            end
        end
        %E×EC×U
        iu=UC(i,j);                                                         %模糊规则表i行，j列所对应的U的模糊子集  
        n=0;
        for k=1:nfe
            for l=1:nfec
                n=n+1;
                for t=1:nfu
                    if Reec(k,l)<Mu(iu,t)
                        Reecu(n,t)=Reec(k,l);
                    else
                        Reecu(n,t)=Mu(iu,t);
                    end
                end
            end
        end
        for k=1:n
            for l=1:nfu
                if Reecu(k,l)>R(k,l)
                    R(k,l)=Reecu(k,l);
                end
            end
        end
    end
end
