%双输入模糊控制器控制表计算程序fuzzy_MI_CTable.m
function [FCU_T1,FCU_T2,FCU_T3,FCU_T4]=fuzzy_table(Me,Mec,Mu,UC)
% Me  隶属度表1
% Mec 隶属度表2
% Mu  隶属度表3
% UC  模糊规则
% FCU_T1 重心加权法，输出精确值
% FCU_T2 重心加权法，输出离散值
% FCU_T3 重心加权法（对隶属度平方），输出离散值
% FCU_T4 最大隶属度法

%#############调用计算模糊关系矩阵R的子程序fuzzy_relation.m###############
[R,n,nE,nEC,nU,nfe,nfec,nfu]=fuzzy_relation(Me,Mec,Mu,UC);

U=(-(nfu-1)/2):(nfu-1)/2;                                                     %输出离散论域为{-(nfu-1)/2  ... -1 0 1 ... (nfu-1)/2}

%###########################计算控制表##################################
s1=char('FCU_T1=重心加权法，输出精确值','FCU_T2=重心加权法，输出离散值',...
    'FCU_T3=重心加权法（对隶属度平方），输出离散值','FCU_T4=最大隶属度法');
disp(s1)
for i=1:nfe
%###################模糊化采用单点模糊##################################
    fe=zeros(1,nfe);
    fe(i)=1;
    
    for j=1:nfec
%###################模糊化采用单点模糊##################################
        fec=zeros(1,nfec);
        fec(j)=1;

        [FU,feec]=fuzzy_deduce(fe,fec,R);                                   %调用模糊决策子程序
      
%##################重心加权法判决控制器的输出############################
         m=dot(FU,U)/sum(FU);
         FCU_T1(j,i)=m;
         
%#################重心加权法判决控制器输出##############################
         FCU_T2(j,i)=round(m);  
         
%#######重心加权法（对隶属度平方，加大权重值的影响）判决控制器的输出######
        FU_square=prod(repmat(FU,[2,1]));                                   %对隶属度的进行平方                                 
        m=dot(FU_square,U)/sum(FU_square);  
        FCU_T3(j,i)=round(m);
%##############最大隶属度法判决控制器的输出#################################
        mU=1;mFU=FU(1);
        for k=2:nfu
            if FU(k)>mFU;mU=k;mFU=FU(k);end
        end
        FCU_T4(j,i)=U(mU);   
    end
end
