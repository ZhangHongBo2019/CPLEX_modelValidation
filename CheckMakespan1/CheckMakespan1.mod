/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-9-30 at ����2:28:07
 *********************************************/
//����ģ�͵��깤ʱ����ʽ�Ƿ���ȷ
//using CP;
{string} Modules=...;//7��ģ����ɵļ���
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
                         if(i="M2",j="M5",p=2,q=2)//��������
                         Q[i][p][j][q]=1;
                         if(i="M1",j="M5",p=2,q=1)//�ų�����
                         Q[i][p][j][q]=-1;
}
int D[Modules][Modules]=...;//�ڽӾ��󣬱�ʾģ����ģ��֮���Ƿ�����
float Time[Modules][Instances]=...;//ʱ��ģ��
int Tm=...;//�˿�Ҫ����ɵ�ʱ��
constraint ct1;
constraint ct2;
constraint ct3;
constraint ct4;
constraint ct5;
dvar boolean select[Modules][Instances];//ѡ���i��ģ��ĵ�j��ģ��ʵ��
//dvar interval S[t in Instances] size Time[t];
dvar float+ S[Modules];//ÿ��ģ��Ŀ�ʼʱ��
//dexpr float TTs=S["M6"]+sum(i in Instances)(select["M6"][i]*Time["M6"][i]);//������ʱ��
dexpr float TTs=S["M7"];
minimize
  TTs;
subject to{
ct1=TTs<=Tm;//Լ��1���������ʱ�䲻�ܳ����˿�Ҫ���ʱ��
ct2=forall(i in Modules)
sum(j in Instances)select[i][j]==1;//Լ��2��ÿ��ģ��ֻѡһ��ģ��ʵ��
ct3=forall(i,j in Modules)
S[i]+sum(k in Instances)(select[i][k]*Time[i][k])<=S[j]+M*(1-D[i][j]);//Լ��3��ʱ������
ct4=forall(m in Modules)
S[m]>=0;//Լ��4��ÿ��ģ��Ŀ�ʼʱ��Ҫ���ڵ���0
ct5=forall(ordered i,j in Modules)
      forall(p,q in Instances){//�ų�Ͱ��ݵĹ�ϵ
           if(Q[i][p][j][q]==1)
              select[i][p]==select[j][q];
           if(Q[i][p][j][q]==-1)
              select[j][q]!=select[i][p];;
}
}