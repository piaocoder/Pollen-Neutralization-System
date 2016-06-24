function G = Unit(A,B,C,D,F)
% 输入A和C是单点模糊化集合向量，B、D、F分别是对应着控制规则向量表示
% 输出G为这条控制规则对应的一个模糊输出
% 实现表达式 Ao(B ->F)∧Co(D ->F)
G = A_jiao_B((A_compose_B(A,A_have_B(B,F))),(A_compose_B(C,A_have_B(D,F))));