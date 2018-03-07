function x=TransRange(y,d1,D,TimWindow_scale,minHiddenrange,maxHiddenrange)
minTimerange=min(TimWindow_scale);maxTimerange=max(TimWindow_scale);
for i=1:size(y,1)
    x(i,1:d1)=round(y(i,1:d1));
    x(i,d1+1:D-1)=round((maxTimerange-minTimerange)*y(i,d1+1:D-1)+minTimerange);
    temp=fix((((maxHiddenrange-minHiddenrange)*y(i,D)+minHiddenrange))/50);
    x(i,D)=temp*50;
end