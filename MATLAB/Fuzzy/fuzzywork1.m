%%%%  注：下面调用的两个函数 REX2（）与REX3（）是自编的，用于模糊关系合成。
close all
clear all
clear all
E=[0 0 0 0 0.1 0.5 1; 
 0 0 0.3 1 0.3  0  0;
 1  0.5  0.1 0 0 0 0];
DE=[0 0 0 0.3 1;
 0 0.3 1 0.3 0;
 1 0.3 0 0 0];
E1=E(1,1:end)'; E2=E(2,1:end)'; E3=E(3,1:end)';
EE1=E(1:end,1);EE2=E(1:end,2);EE3=E(1:end,3);EE4=E(1:end,4);EE5=E(1:end,5);EE6=E(1:end,6);EE7=E(1:end,7);
 U=[0 0 0 0.5 1;
 0 0 0.5 1 0.5;
  0 0.5 1 0.5 0;
0.5 1 0.5 0 0;
  1 0.5 0 0 0];
DE1=DE(1,1:end); DE2=DE(2,1:end); DE3=DE(3,1:end);
DEE1=DE(1:end,1);DEE2=DE(1:end,2);DEE3=DE(1:end,3);DEE4=DE(1:end,4);DEE5=DE(1:end,5);
U1=U(1,1:end); U2=U(2,1:end);U3=U(3,1:end);U4=U(4,1:end); U5=U(5,1:end); 
UU1=U(1:end,1);UU2=U(1:end,2);UU3=U(1:end,3);UU4=U(1:end,4);UU5=U(1:end,5);
R1=REX3(E1,DE1,U1);R2=REX3(E1,DE2,U2);R3=REX3(E1,DE3,U3);%%%%%%%%%%%%模糊规则
R4=REX3(E2,DE1,U3);R5=REX3(E2,DE2,U4);R6=REX3(E2,DE3,U5);
R7=REX3(E3,DE1,U4);R8=REX3(E3,DE2,U5);R9=REX3(E3,DE3,U5);
for i=1:35
   for j=1:5
 W=[R1(i,j),R2(i,j),R3(i,j),R4(i,j),R5(i,j),R6(i,j),R7(i,j),R8(i,j),R9(i,j)];
  R(i,j)=max(W);
   end
end
P=[];
   for i=1:7
       for j=1:5
 W=REX2(E(1:end,i),DE(1:end,j)) ;
 P=[P;W];
       end
   end
   P=P';
for i=1:9
   for j=1:5
      UU(i,j)=max(min(P(i,:),R(:,j)'));
	end
end
q=[2;11.7062;15;70;96];%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:9
    z(i)=UU(i,:)*q/sum(UU(i,:));
end
X=E';
for i=1:7
    for j=1:5
        UUU(i,j)=PROD(X(i,:),DE(:,j))*z';
    end
end
  UUU=  UUU'
    

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%控制表生成
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
TU=[];
for z=1:5
    TU=[TU;UUU(z,:)'];
end

TT1=100;
   TT2=120;
   TT(1)=130;
    TTT=[];
   TTT=[TTT;TT(1)];
  P1=20;
 P2=10;
 P3=12;
  P4=24;
  pp=[];
  pp=[pp;P4];
  DT(1)=900; 
  DDT=[];
  DDT=[DDT;DT(1)];
TTE=[];
  TE(1)=0;
  TTE=[TTE;TE(1)];
   TE1=0;
  DTE=0;
   PP=zeros(1,7);
        PPP=10;
        tt=[];
        tt=[tt;1];
    TT(1)= 100;        
   for t=2:1:200
        tt=[tt;t];%%%%%%%%%时间t
       DT(t)=900;
         DDT=[DDT;DT(t)];%%%%%%%表示成列向量，便于画图
       P(t-1)=PPP;
       pp=[pp;P(t-1)];
       TT(t)=1.4714*TT1-0.4731*TT2+0.4316* P(t-1)-0.4476* P2+0.1934* P3-0.0467* P4;
       TTT=[TTT;TT(t)];
       TE(t)=DT(t)-TT(t);
       TEE= TE(t);
       TTE=[TTE;TE(t)];
       TE1(t)=DT(t)-TT1;
       DTE(t)=TE(t)-TE1(t);
        DTEE=DTE(t);
       TT2=TT1;
        TT1=TT(t);
        P4=P3;
        P3=P2;
        P2=P(t-1);  
       if  TEE>=25
             F1=7;
       elseif 5<=TEE && TEE<25
            F1=6;
       elseif -5<=TEE && TEE<5
            F1=5;
        elseif -15<=TEE && TEE <-5
                        F1=4;
        elseif -20<=TEE && TEE<-15
                           F1=3;
        elseif -25<=TEE && TEE<-20
                            F1=2;
        else
            F1=1;
       end
  if  DTEE>5
         
         F2=5;
 elseif 3<=DTEE && DTEE<5
                    F2=4;
 elseif -5<=DTEE && DTEE<3
                      F2=3;
  elseif -8<=DTEE && DTEE<-5
                         F2=2;
  else
      F2=1;
  end
N=(F2-1)*7+F1;
PPP=TU(N) ; 
   end      
       
      subplot(2,1,1):plot(tt,DDT,tt,TTT,'r');
    xlabel('时间');ylabel('温度')
      subplot(2,1,2):plot(tt,pp);
   xlabel('时间');ylabel('功率P')   
   F1
   F2
   
         