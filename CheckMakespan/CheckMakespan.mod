/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-9-30 at ����12:54:38
 *********************************************/
//����ģ�͵��깤ʱ����ʽ�Ƿ���ȷ
//using CP;
{string} Modules=...;//6��ģ����ɵļ���
{string} Ins[Modules]=...;//��ͬ��ģ����ɵ�ģ��ʵ������
int MaxInstances=max(m in Modules)card(Ins[m]);//ȡ����ģ��ʵ����
range Instances=1..MaxInstances;
float M=...;
int D[Modules][Modules];
execute{
      for(var i in Modules)
              for(var j in Modules)
                         D[i][j]=0;
                         if(i="M1",j="M2")
                         D[i][j]=1;//M1��M2����
                         if(i="M2",j="M3")
                         D[i][j]=1;//M2��M3����
                         if(i="M2",j="M4")
                         D[i][j]=1;
                         if(i="M4",j="M5")
                         D[i][j]=1;//M4��M5����
                         if(i="M5",j="M6")
                         D[i][j]=1;//M5��M6����
                         if(i="M3",j="M6")
                         D[i][j]=1;
}
float Time[Modules][Instances]=...;
int Tm=...;
constraint ct1;
constraint ct2;
constraint ct3;
constraint ct4;
//dvar boolean select[Instances];
dvar boolean select[Modules][Instances];
//dvar interval S[t in Instances] size Time[t];
dvar float+ S[Modules];
dexpr float TTs=S["M6"]+sum(i in Instances)(select["M6"][i]*Time["M6"][i]);
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
}