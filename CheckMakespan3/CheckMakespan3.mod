/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-10-1 at ����3:43:47
 *********************************************/
//����ģ�͵��깤ʱ����ʽ�Ƿ���ȷ
//using CP;
{string} Modules=...;//11��ģ����ɵļ���
{string} Ins[Modules]=...;//��ͬ��ģ����ɵ�ģ��ʵ������
int MaxInstances=max(m in Modules)card(Ins[m]);//ȡ����ģ��ʵ����
range Instances=1..MaxInstances;
float M=...;
int Q[Modules][Instances][Modules][Instances];//�ڽӾ��󣬱�ʾģ��ʵ��֮��İ��ݺ��ų��ϵ
execute{
      for(var i in Modules)
         for(var p in Instances)
              for(var j in Modules)
                  for(var q in Instances)
                         Q[i][p][j][q]=0;
                         if(i="M7",j="M9",p=3,q=2)//��������
                         Q[i][p][j][q]=1;
                         if(i="M3",j="M10",p=2,q=3)//�ų�����
                         Q[i][p][j][q]=-1;
}
int D[Modules][Modules]=...;
float Time[Modules][Instances]=...;
int Tm=...;
constraint ct1;
constraint ct2;
constraint ct3;
constraint ct4;
constraint ct5;
//dvar boolean select[Instances];
dvar boolean select[Modules][Instances];
//dvar interval S[t in Instances] size Time[t];
dvar float+ S[Modules];
dexpr float TTs=S["M11"]+sum(i in Instances)(select["M11"][i]*Time["M11"][i]);
minimize
  TTs;
subject to{
ct1=TTs<=Tm;
ct2=forall(i in Modules)
sum(j in Instances)select[i][j]==1;
ct3=forall(i,j in Modules)
S[i]+sum(k in Instances)(select[i][k]*Time[i][k])<=S[j]+M*(1-D[i][j]);
ct4=forall(m in Modules)
S[m]>=0;
ct5=forall(ordered i,j in Modules)
      forall(p,q in Instances){//�ų�Ͱ��ݵĹ�ϵ
           if(Q[i][p][j][q]==1)
              select[i][p]==select[j][q];
           if(Q[i][p][j][q]==-1)
              select[j][q]!=select[i][p];
}
}