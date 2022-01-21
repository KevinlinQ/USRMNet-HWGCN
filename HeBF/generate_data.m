%%%%%        �ú�����������ѵ�������������������ʼ�����w0��p0        %%%%%%
clear all
clc
close all
digits(40)                                      %% �涨���㾫����40λ��Ч����
warning off

cvx_setup
%% ��������
K = 32;                                         %% K������ ��4:10��
Pm = [10^(11/10)];                              %% �����Լ��
D = 32*8;                                       %% ����ı�����
n = 128;                                        %% ���޿鳤
M = 4;                                          %% �û���Ŀ

epsilon = [1e-5];                               %% BER���
epsilon2 = 1e-2;                                %% �������ֹͣ����
iter_cur = 1;                                   %% ��������
num_H = 20;                                   %% ��������
H = [];                                         %% �洢�����ŵ���Ϣ
w0 = [];                                        %% �洢����������ʼ����w
p0 = [];                                        %% �洢����������ʼ����p

%% �����ŵ�ϵ������ʼ�������������Լ���ʼ������
while(iter_cur <= num_H)                        %% ��ÿһ���������г�ʼ��
    sigma_k = ones(1,M);
    while(1)   %% ֱ����ǰ�����ҵ�һ�����Գ�ʼ�����ŵ���Ϣ
        h_k_ori=[];
        h_k=[];
        h_k_ori = channel(K,M);                 %% h_k����ʽ��M*K�����û���*������
        h_k = h_k_ori/sigma_k(1);
        gamma_k_wan=[];
        for kk = 1:M
            gamma_k_wan(kk) = Pm*norm(h_k_ori(kk,:))^2./ (sigma_k(kk))^2;
        end

        [w_k_0,p_k_0,gamma_k,psi_k_t,phi_k_t,xita_k_t] = cal_init_w_v14(K,M,Pm,D,n,epsilon,h_k,sigma_k,gamma_k_wan);

        if isnan(w_k_0)
            sprintf('Inf����');
            continue;
        else
            sprintf('��%d��������ʼ���ɹ�', iter_cur)
            H(iter_cur, :, :) = h_k_ori;                %% ���浱ǰ�ŵ�ϵ��
            w0(iter_cur, :, :) = w_k_0;                 %% ���浱ǰ�ŵ���ʼ����w0
            p0(iter_cur, :) = p_k_0;                    %% ���浱ǰ�ŵ���ʼ����p0
            iter_cur = iter_cur + 1;
            break;
        end
        clear q_k*  w_k* ze* xi* t*
    end
end

%% �������е�����
save_file = strcat('.\dataset\channel',num2str(M),'_',num2str(K),'.mat');
save(save_file,'H','w0', 'p0');
