function [gbest,gbestval,gbestval_hist]=DMS_PSO_func(Max_FES,group_num,Particle_Number,Dimension,VRmin,VRmax,DF_demi,TimWindow_scale)
rand('state',sum(100*clock));% get a random seed
group_ps=Particle_Number;
ps=group_num*group_ps;
D=Dimension;
cc=[1.49445 1.49445];   %acceleration constants
iwt=0.729;
%----Define bounds for velocity Vmax and the search bounds [VRmin,VRmax]----%
if length(VRmin)==1
    VRmin=repmat(VRmin,1,D);
    VRmax=repmat(VRmax,1,D);
end
mv=0.2*(VRmax-VRmin);
VRmin=repmat(VRmin,ps,1);
VRmax=repmat(VRmax,ps,1);
Vmin=repmat(-mv,ps,1);
Vmax=-Vmin;
pos=VRmin+(VRmax-VRmin).*rand(ps,D);
pos1=TransRange(pos,DF_demi,D,TimWindow_scale,50,600);
for i=1:ps
    %     e(i)=feval(fhd,X,A,S,pos(i,:),varargin{:});
    e(i,:)=fun(pos1(i,:),DF_demi);
end
fitcount=ps;
vel=Vmin+2.*Vmax.*rand(ps,D);%initialize the velocity of the particles
pbest=pos;
pbestval=e; %initialize the pbest and the pbest's fitness value

%---Divide the particles randomly into group_num sub-swarms----%
for k=1:group_num
    group_id(k,:)=[((k-1)*group_ps+1):k*group_ps];
    pos_group(group_id(k,:))=k;
    [tmp,tmpid]=sort(pbestval(group_id(k,:),1));
    gbestid=group_id(k,tmpid(1));
    gbestval(k,:)=pbestval(gbestid,:);
    gbest(k,:)=pbest(gbestid,:);%initialize the gbest and the gbest's fitness value, each sub-swarm has a gbest.
end
% gbestval
i=1;%initialize the generation.
converge_flag=0;%if fitcount>=0.9*Max_FES,set converge_flag=1 and put all particle into one big swarm and start local search.
[gbestval_value,gbestval_index]=min(gbestval(:,1));
gbestval_hist(1,:)=[gbestval(gbestval_index,:) length(find(gbest(gbestval_index,:)==1))];
while fitcount<=Max_FES
    i=i+1;
    for k=1:ps
        aa(k,:)=cc(1).*rand(1,D).*(pbest(k,:)-pos(k,:))+cc(2).*rand(1,D).*(gbest(pos_group(k),:)-pos(k,:));
        vel(k,:)=iwt.*vel(k,:)+aa(k,:);
        vel(k,:)=(vel(k,:)>mv).*mv+(vel(k,:)<=mv).*vel(k,:);
        vel(k,:)=(vel(k,:)<(-mv)).*(-mv)+(vel(k,:)>=(-mv)).*vel(k,:);
        pos(k,:)=pos(k,:)+vel(k,:); % update the demision of time window
        for k1=1:D
            if ((pos(k,k1)>VRmax(k,k1))==1)|((pos(k,k1)<VRmin(k,k1))==1)
                pos(k,k1)=VRmin(k,k1)+(VRmax(k,k1)-VRmin(k,k1)).*rand;
            end
        end
        pos1=TransRange(pos,DF_demi,D,TimWindow_scale,50,500);
        e(k,:)=fun(pos1(k,:),DF_demi);
        fitcount=fitcount+1;
        tmp=(pbestval(k,1)<e(k,1));
        temp=repmat(tmp,1,D);
        pbest(k,:)=temp.*pbest(k,:)+(1-temp).*pos(k,:);
        pbestval(k,:)=tmp.*pbestval(k,:)+(1-tmp).*e(k,:);%update the pbest
        if pbestval(k)<gbestval(pos_group(k))
            gbest(pos_group(k),:)=pbest(k,:);
            gbestval(pos_group(k),:)=pbestval(k,:);
        end
    end
    if converge_flag==0 & fitcount>=0.9*Max_FES %if fitcount>=0.9*Max_FES, put all particle into one big swarm and start local search.
        converge_flag=1;
        group_id=1:ps;
        pos_group(1:ps)=1;
        [gbestval_value,gbestid]=min(pbestval(:,1));
        gbestval=pbestval(gbestid,:);
        gbest=pbest(gbestid,:);
    end
    if mod(i,5)==0 & converge_flag==0 % regroup the sub-swarms every 7 generations
        rc=randperm(ps);
        group_id=[];gbest=[];gbestval=[];
        for k=1:group_num
            group_id(k,:)=rc(((k-1)*group_ps+1):k*group_ps);
            pos_group(group_id(k,:))=k;
            [gbestval_value(k),gbestid]=min(pbestval(group_id(k,:),1));
            gbest(k,:)=pbest(group_id(k,gbestid),:);
            gbestval(k,:)=pbestval(group_id(k,gbestid),:);
        end    
    end
%     gbestval
    [gbestval_value,gbestval_index]=min(gbestval(:,1));
    gbestval_hist(i,:)=[gbestval(gbestval_index,:) length(find(gbest(gbestval_index,:)==1))];
    if fitcount>=Max_FES
        break;
    end
end