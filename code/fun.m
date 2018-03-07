function TAccuracy=fun(x,DF_demi)
%get global variable
global y1 w1 z1
DFactors=y1;
DKw=w1;
Randlable=z1;
K=10;
templabel=find(x(1:DF_demi)==1);
label=x(DF_demi+1:2*DF_demi+1);
timewindow=[label(templabel) label(end)];
clear label
NumberofHiddenNeurons=x(end);
Label_zero=find(Randlable==0);
tempKW=DKw{timewindow(end)};
% x,templabel,timewindow
for k1=1:K
    %         k1
    temp3=tempKW;
    Label_index=find(Randlable==k1);
    Testkw{k1}=temp3(:,Label_index);% folder for testing
    Label_all=[Label_index,Label_zero];
    temp3(:,Label_all)=[];
    Trainkw{k1}=temp3;
    clear temp3 Label_index Label_all
end
clear tempKW
temp=[];tempFACTOR=[];
if (length(templabel))>=1
    for j=1:(length(templabel))
        temp=DFactors{templabel(j)}{timewindow(j)};
        tempFACTOR=[tempFACTOR;temp];
    end
else tempFACTOR=[];
end
clear temp
if (length(templabel))>=1
    for k1=1:K
        temp3=tempFACTOR;
        Label_index=find(Randlable==k1);
        Testfactor=temp3(:,Label_index);% folder for testing
        Label_all=[Label_index,Label_zero];
        temp3(:,Label_all)=[];
        Trainfactor=temp3;
        Ftrain{k1}=[Trainfactor;Trainkw{k1}];
        Ftest{k1}=[Testfactor;Testkw{k1}];
        clear temp3 Label_index Label_all
    end
else
    Ftrain=Trainkw;
    Ftest=Testkw;
end
for i=1:K
    TAccuracy(i,:)=ELM(Ftrain{i},Ftest{i},NumberofHiddenNeurons,'sig');
end
TAccuracy=mean(TAccuracy);
