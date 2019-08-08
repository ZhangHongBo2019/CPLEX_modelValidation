/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-9-30 at 下午2:28:07
 *********************************************/
//检验模型的完工时间表达式是否正确
//using CP;
{string} Modules=...;//7个模块组成的集合
{string} Ins[Modules]=...;//不同的模块组成的模块实例集合
int MaxInstances=max(m in Modules)card(Ins[m]);//取最大的模块实例数
range Instances=1..MaxInstances;
float M=...;
int Q[Modules][Instances][Modules][Instances];//邻接矩阵，表示模块实例之间的包容和排斥关系
execute{
      for(var i in Modules)
         for(var p in Instances)
              for(var j in Modules)
                  for(var q in Instances)
                         Q[i][p][j][q]=0;
                         if(i="M2",j="M5",p=2,q=2)//包容条件
                         Q[i][p][j][q]=1;
                         if(i="M1",j="M5",p=2,q=1)//排斥条件
                         Q[i][p][j][q]=-1;
}
int D[Modules][Modules]=...;//邻接矩阵，表示模块与模块之间是否相连
float Time[Modules][Instances]=...;//时间模块
int Tm=...;//顾客要求完成的时间
constraint ct1;
constraint ct2;
constraint ct3;
constraint ct4;
constraint ct5;
dvar boolean select[Modules][Instances];//选择第i个模块的第j个模块实例
//dvar interval S[t in Instances] size Time[t];
dvar float+ S[Modules];//每个模块的开始时间
//dexpr float TTs=S["M6"]+sum(i in Instances)(select["M6"][i]*Time["M6"][i]);//服务总时间
dexpr float TTs=S["M7"];
minimize
  TTs;
subject to{
ct1=TTs<=Tm;//约束1：服务的总时间不能超过顾客要求的时间
ct2=forall(i in Modules)
sum(j in Instances)select[i][j]==1;//约束2：每个模块只选一个模块实例
ct3=forall(i,j in Modules)
S[i]+sum(k in Instances)(select[i][k]*Time[i][k])<=S[j]+M*(1-D[i][j]);//约束3：时间限制
ct4=forall(m in Modules)
S[m]>=0;//约束4：每个模块的开始时间要大于等于0
ct5=forall(ordered i,j in Modules)
      forall(p,q in Instances){//排斥和包容的关系
           if(Q[i][p][j][q]==1)
              select[i][p]==select[j][q];
           if(Q[i][p][j][q]==-1)
              select[j][q]!=select[i][p];;
}
}