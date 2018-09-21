function [sol, fitnessVal] = fitness(sol, options)
for i = 1 : 49
    rulea(i) = round(sol(i)); %取整
end
a = newfis('fuzz_1');%创建新的模糊规则

f1 = 5;%设置初始值，待定
a = addvar(a, 'input','s',[-5 * f1, 5 * f1]); %设置参数s
a = addmf(a,'input',1,'NB','zmf',[-5 * f1, -3 * f1]);
a = addmf(a,'input',1,'NM','trimf',[-4 * f1, -3 * f1, -2 * f1]);
a = addmf(a,'input',1,'NS','trimf',[-3 * f1, -2 * f1, -1 * f1]);
a = addmf(a,'input',1,'ZE','trimf',[-2 * f1, 0, 2 * f1]);
a = addmf(a,'input',1,'PS','trimf',[1 * f1, 2 * f1, 3 * f1]);
a = addmf(a,'input',1,'PM','trimf',[2 * f1, 3 * f1, 4 * f1]);
a = addmf(a,'input',1,'PB','smf',[3 * f1, 5 * f1]);

a = addvar(a, 'input','ds',[-5 * f1, 5 * f1]); %设置参数ds
a = addmf(a,'input',2,'NB','zmf',[-5 * f1, -3 * f1]);
a = addmf(a,'input',2,'NM','trimf',[-4 * f1, -3 * f1, -2 * f1]);
a = addmf(a,'input',2,'NS','trimf',[-3 * f1, -2 * f1, -1 * f1]);
a = addmf(a,'input',2,'ZE','trimf',[-2 * f1, 0, 2 * f1]);
a = addmf(a,'input',2,'PS','trimf',[1 * f1, 2 * f1, 3 * f1]);
a = addmf(a,'input',2,'PM','trimf',[2 * f1, 3 * f1, 4 * f1]);
a = addmf(a,'input',2,'PB','smf',[3 * f1, 5 * f1]);

f2 = 0.5;
a = addvar(a,'output','k',[-5 * f2, 5 * f2]); %输出参数k
a = addmf(a,'output',1,'NB','zmf',[-5 * f2, -3 * f2]);
a = addmf(a,'output',1,'NM','trimf',[-4 * f2, -3 * f2, -2 * f2]);
a = addmf(a,'output',1,'NS','trimf',[-3 * f2, -2 * f2, -1 * f2]);
a = addmf(a,'output',1,'ZE','trimf',[-2 * f2, 0, 2 * f2]);
a = addmf(a,'output',1,'PS','trimf',[1 * f2, 2 * f2, 3 * f2]);
a = addmf(a,'output',1,'PM','trimf',[2 * f2, 3 * f2, 4 * f2]);
a = addmf(a,'output',1,'PB','smf',[3 * f2, 5 * f2]);

rulelist = [ 1,1,rulea(1),1,1;          %模糊规则，共49条
             1,2,rulea(2),1,1;
             1,3,rulea(3),1,1;
             1,4,rulea(4),1,1;
             1,5,rulea(5),1,1;
             1,6,rulea(6),1,1;
             1,7,rulea(7),1,1;
             
             2,1,rulea(8),1,1;
             2,2,rulea(9),1,1;
             2,3,rulea(10),1,1;
             2,4,rulea(11),1,1;
             2,5,rulea(12),1,1;
             2,6,rulea(13),1,1;
             2,7,rulea(14),1,1;
             
             3,1,rulea(15),1,1;
             3,2,rulea(16),1,1;
             3,3,rulea(17),1,1;
             3,4,rulea(18),1,1;
             3,5,rulea(19),1,1;
             3,6,rulea(20),1,1;
             3,7,rulea(21),1,1;
             
             4,1,rulea(22),1,1;
             4,2,rulea(23),1,1;
             4,3,rulea(24),1,1;
             4,4,rulea(25),1,1;
             4,5,rulea(26),1,1;
             4,6,rulea(27),1,1;
             4,7,rulea(28),1,1;
             
             5,1,rulea(29),1,1;
             5,2,rulea(30),1,1;
             5,3,rulea(31),1,1;
             5,4,rulea(32),1,1;
             5,5,rulea(33),1,1;
             5,6,rulea(34),1,1;
             5,7,rulea(35),1,1;
             
             6,1,rulea(36),1,1;
             6,2,rulea(37),1,1;
             6,3,rulea(38),1,1;
             6,4,rulea(39),1,1;
             6,5,rulea(40),1,1;
             6,6,rulea(41),1,1;
             6,7,rulea(42),1,1;
             
             7,1,rulea(43),1,1;
             7,2,rulea(44),1,1;
             7,3,rulea(45),1,1;
             7,4,rulea(46),1,1;
             7,5,rulea(47),1,1;
             7,6,rulea(48),1,1;
             7,7,rulea(49),1,1;    
    ];
a1 = addrule(a,rulelist);
a1 = setfis(a1,'DefuzzMethod','centroid'); %解模糊化 重心法解模糊化
writefis(a1,'fuzz_1');  %写入
a1 = readfis('fuzz_1');

simOut = sim('slidemodel');
s4all = 0;
for k = 1 : 1 : length(s4)
    s4all = s4all + abs(s4(k));
end
fitnessVal = 1 / s4all ;
end

