clear all;
clc;
x=-2:.001:12;
load('data120.mat','data')
for i=1:50
         plot(x,data(i,:),'-.b')
         hold on
    end
    for i=51:100
         plot(x,data(i,:),'-.g')
         hold on
    end
    for i=101:120
         plot(x,data(i,:),'-.m')
         hold on
    end

% size(data);
zt=data;
tic
W=[];
for i=1:size(zt,1)
    for j=1:size(zt,1)
    if i==j
       W(i,j)=0;
    else
        W(i,j)=L2(zt(i,:),zt(j,:),x);
    end
    end
end
%Dieu chinh lai sai so
for i=1:length(W)
for j=1:length(W)
if W(i,j)<0
    W(i,j)=0;
end
end
end
W;
%Tinh ds
Ws=sum(sum(W))/(length(W)*length(W)-length(W));
%Tinh sigma
% a=[]
% for i=1:size(W,2)
%     a=[a;diag(W,i)];
% end
% b=a;
% a=[a;b];
% sigma=std(a);
% alp=ones(size(W,1),size(W,2));
%Tinh ma tran K lamda
k=[];
for i=1:length(W)
    for j=1:length(W)
        if W(i,j)<Ws
            k(i,j)=exp(-W(i,j)/(Ws/5));
        else
            k(i,j)=0;
        end
    end
end
k;
%Tinh z(t+1)
ztmoi=[];
for i=1:length(W)
    tu=[];
    for l=1:length(x)
    tu=[tu,0];
    end
    mau=0;
    for j=1:length(W)
        tu=tu+zt(j,:)*k(i,j);
        mau=mau+k(i,j);
    end
    tu/mau;
    ztmoi=[ztmoi;tu/mau];
end
%so sanh chuan va do lech toi da cho phep
exilanh=10^-2;
max(max(abs(ztmoi-zt)));
vonglap=0;
while max(max(abs(ztmoi-zt)))>exilanh 
    vonglap=vonglap+1
    zt=ztmoi;
    figure
for i=1:120
     da(i,:)=plot(x,data(i,:),'-.b');
     set(gcf,'color','w');
     hold on
     mn(i,:)=plot(x,zt(i,:),'-r');
     set(gcf,'color','w');
end
legend([da(1,:) mn(1,:)],{'input probability density functions','Output of SNC'});
 hold off
    
    
    
W=[];
for i=1:size(zt,1)
    for j=1:size(zt,1)
    if i==j
       W(i,j)=0;
    else
        W(i,j)=L2(zt(i,:),zt(j,:),x);
    end
    end
end
%Dieu chinh lai sai so
for i=1:length(W)
for j=1:length(W)
if W(i,j)<0
    W(i,j)=0;
end
end
end
W;
% alp=alpha1(alp,k);
%Tinh ma tran K lamda
k=[];
for i=1:length(W)
    for j=1:length(W)
        if W(i,j)<Ws
            k(i,j)=exp(-W(i,j)/(Ws/5));
        else
            k(i,j)=0;
        end
    end
end
k;
%Tinh z(t+1)
ztmoi=[];
for i=1:length(W)
    tu=[];
    for l=1:length(x)
    tu=[tu,0];
    end
    mau=0;
    for j=1:length(W)
        tu=tu+zt(j,:)*k(i,j);
        mau=mau+k(i,j);
    end
    tu/mau;
    ztmoi=[ztmoi;tu/mau];
end
max(max(abs(ztmoi-zt)));
end
toc
kq=ztmoi;
 figure
for i=1:120
     da(i,:)=plot(x,data(i,:),'-.b')
     hold on
     mn(i,:)=plot(x,zt(i,:),'-r')
end
legend([da(1,:) mn(1,:)],{'input probability density functions','Output of SNC'})
 hold off
