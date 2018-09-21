number = 30; %种群数量
aa = ones(49,1) * [1,7]; %变量矩阵 49个模糊规则，范围1 - 7
initPop = initializega(number, aa ,'fitness',[],[1e-6 1]); %初始化种群
gen =100;  %遗传代数
[x ,endPop,bPop,trace] = ga(aa,'fitness',[],initPop,[1e-6 1 1],'maxGenTerm',gen,...
                             'normGeomSelect',[0.08],'arithXover',[2],'nonUnifMutation',[2 gen 3]);


figure(1)
plot(trace(:,1),trace(:,3),'b:')
hold on
plot(trace(:,1),trace(:,2),'r-')
legend('平均适应度','最大适应度')
