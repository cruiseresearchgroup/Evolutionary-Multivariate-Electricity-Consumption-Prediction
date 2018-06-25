% main
clc;close all;clear all;
load DFactors 
load DKw
load Randlabel
global y1 w1 z1
y1=DFactors;
w1=DKw;
z1=Randlable;
% NumberofELM=3;
DF_demi=size(DFactors,2);
Dimension= 2*DF_demi+2;
VRmin=0;VRmax=1;
group_num=3;
Particle_Number=10;
Max_FES=100*group_num*Particle_Number;
TimWindow=5:1:35;
TimWindow_scale=1:length(TimWindow);
 for i=1:10
%     i
    [gbest(i,:),gbestval(i,:),gbestval_hist{i}]=DMS_PSO_func(Max_FES,group_num,Particle_Number,Dimension,VRmin,VRmax,DF_demi,TimWindow_scale);
    TestAccuracy(i,:)=gbestval_hist{i}(end,:);
end
clear DFactors DKw Randlabel
save result

% Please refer to http://www5.zzu.edu.cn/cilab/Code.htm for DMSPSO code. 
