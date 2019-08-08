/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-9-30 at 下午6:24:08
 *********************************************/
//检查模型费用函数
{string} Modules=...;//9个模块组成的集合
{string} Ins[Modules]=...;//不同的模块组成的模块实例集合
int MaxInstances=max(m in Modules)card(Ins[m]);//取最大的模块实例数
range Instances=1..MaxInstances;
int Q[Modules][Instances][Modules][Instances];//邻接矩阵，表示模块实例之间的包容和排斥关系
execute{
      for(var i in Modules)
         for(var p in Instances)
              for(var j in Modules)
                  for(var q in Instances)
                         Q[i][p][j][q]=0;
                         if(i="M6",j="M8",p=2,q=1)//包容条件
                         Q[i][p][j][q]=1;
                         if(i="M3",j="M5",p=2,q=1)//排斥条件
                         Q[i][p][j][q]=-1;
}
float Expense=...;//顾客所能承担的最大价格
float rate=...;//利润率
float Cost[Modules][Instances]=...;//每个模块的模块实例所对应的价格
//float Time[Instances]=...;
dvar boolean select[Modules][Instances];//0-1变量，选择第i个模块的第j个模块实例
constraint ct1;
constraint ct2;	
constraint ct3; 
dexpr float TotalCost=sum(i in Modules,j in Instances)Cost[i][j]*select[i][j];//总费用
minimize
  TotalCost;
subject to{
ct1=TotalCost*(1+rate)<=Expense;//费用约束
ct2=forall(m in Modules)
      sum(i in Instances)select[m][i]==1;//每个模块的模块实例只选一个
ct3=forall(ordered i,j in Modules)
      forall(p,q in Instances){//排斥和包容的关系
           if(Q[i][p][j][q]==1)
              select[i][p]==select[j][q];//互相包容：都选或都不选
           if(Q[i][p][j][q]==-1)
              select[j][q]!=select[i][p];//互相排斥，二选一
}                  
}