/*********************************************
 * OPL 12.6.1.0 Model
 * Author: Administrator
 * Creation Date: 2018-9-30 at ����6:24:08
 *********************************************/
//���ģ�ͷ��ú���
{string} Modules=...;//9��ģ����ɵļ���
{string} Ins[Modules]=...;//��ͬ��ģ����ɵ�ģ��ʵ������
int MaxInstances=max(m in Modules)card(Ins[m]);//ȡ����ģ��ʵ����
range Instances=1..MaxInstances;
int Q[Modules][Instances][Modules][Instances];//�ڽӾ��󣬱�ʾģ��ʵ��֮��İ��ݺ��ų��ϵ
execute{
      for(var i in Modules)
         for(var p in Instances)
              for(var j in Modules)
                  for(var q in Instances)
                         Q[i][p][j][q]=0;
                         if(i="M6",j="M8",p=2,q=1)//��������
                         Q[i][p][j][q]=1;
                         if(i="M3",j="M5",p=2,q=1)//�ų�����
                         Q[i][p][j][q]=-1;
}
float Expense=...;//�˿����ܳе������۸�
float rate=...;//������
float Cost[Modules][Instances]=...;//ÿ��ģ���ģ��ʵ������Ӧ�ļ۸�
//float Time[Instances]=...;
dvar boolean select[Modules][Instances];//0-1������ѡ���i��ģ��ĵ�j��ģ��ʵ��
constraint ct1;
constraint ct2;	
constraint ct3; 
dexpr float TotalCost=sum(i in Modules,j in Instances)Cost[i][j]*select[i][j];//�ܷ���
minimize
  TotalCost;
subject to{
ct1=TotalCost*(1+rate)<=Expense;//����Լ��
ct2=forall(m in Modules)
      sum(i in Instances)select[m][i]==1;//ÿ��ģ���ģ��ʵ��ֻѡһ��
ct3=forall(ordered i,j in Modules)
      forall(p,q in Instances){//�ų�Ͱ��ݵĹ�ϵ
           if(Q[i][p][j][q]==1)
              select[i][p]==select[j][q];//������ݣ���ѡ�򶼲�ѡ
           if(Q[i][p][j][q]==-1)
              select[j][q]!=select[i][p];//�����ų⣬��ѡһ
}                  
}