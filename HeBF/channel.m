

function h=channel(K,M)   % K������, M���û�
% h=X*sqrt(d^(-afa)) M:user num  K:antenna num clear close all clc
afa = 3;
d0=50;
dr = 300;
% d(1)=100;
for n=1:M
    dk = d0+(dr-d0)*rand(1);
%     dk = 300*rand(1);
    rou(n)=1/(1+(dk/d0)^afa);
end
rou = repmat(rou',1,K);
%% X�ĳ�ʼ���ǹؼ���֮ǰ���Ϊһ��K*1ά�������������ΪK*M����
X=(randn(M,K)+i*randn(M,K))/sqrt(2);
h = (sqrt(rou).*X);

