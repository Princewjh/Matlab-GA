number = 30; %��Ⱥ����
aa = ones(49,1) * [1,7]; %�������� 49��ģ�����򣬷�Χ1 - 7
initPop = initializega(number, aa ,'fitness',[],[1e-6 1]); %��ʼ����Ⱥ
gen =100;  %�Ŵ�����
[x ,endPop,bPop,trace] = ga(aa,'fitness',[],initPop,[1e-6 1 1],'maxGenTerm',gen,...
                             'normGeomSelect',[0.08],'arithXover',[2],'nonUnifMutation',[2 gen 3]);


figure(1)
plot(trace(:,1),trace(:,3),'b:')
hold on
plot(trace(:,1),trace(:,2),'r-')
legend('ƽ����Ӧ��','�����Ӧ��')
