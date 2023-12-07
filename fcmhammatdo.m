clear all;
clc
x=-2:.001:12;
load('data125.mat','data')
Z=data';
% Z=[Z,Z(:,[9,99,120])];
U = initfcm(3,size(Z,2));	
% load('U50.mat');
% load('inima.mat');
% U=[ 1 0 0 1 0 0  0; 0 1 0 0 1 0 1; 0 0 1 0 0 1 0];
% Z=f;
% x=0:.005:1;
%Tinh phan tu dai dien chum
chieuu=size(U);
for i=1:chieuu(1,1)
fv(:,i)=Z*(U(i,:)'.*U(i,:)')/sum(U(i,:).*U(i,:));
end
fv;
%5 bieu do dai dien
for i=1:3
x=x';
  gv(i) = plot(x,fv(:,i),'-.b')
%   pause(.5)
  hold on
end
legend(gv,'W_1','W_2','W_3')
xlabel('x')
ylabel('fv')
%Tinh ma tran do rong chum
W=[];
for j=1:chieuu(1,2)
    for i=1:chieuu(1,1)
    W(i,j)=L2(fv(:,i),Z(:,j),x);
    end
end
W;
%Cap nhat ma tran phan vung 
   for j=1:chieuu(1,2)
    m=0;
    for k=1:chieuu(1,1)
       if W(k,j)==0
           m=m+1;
       end
    end
    if m==0
    for i=1:chieuu(1,1)
        tong=0;
        for k=1:chieuu(1,1)
        tong=tong+(W(i,j)^2)/(W(k,j)^2);
        end
        Umoi(i,j)=1/tong;
    end
        else
        for l=1:chieuu(1,1)
            if W(l,j)==0
                Umoi(l,j)=1/m;
            else
                Umoi(l,j)=0;
            end
        end
    end
end
Umoi;

%Tinh chuan
chuan=0;
ff=[];
for i=1:chieuu(1,1)
    for j=1:chieuu(1,2)
    lech(i,j)=abs(Umoi(i,j)-U(i,j));
    if lech(i,j)>chuan
        chuan=lech(i,j);
    end
    end
end
chuan;
ff=[ff;chuan]
%lap lai thuat toan cho den khi chuan nho hon exilanh cho truoc, gia su 
% exilanh=0.01
vonglap=1;
while chuan>0.00001
    U=Umoi;
%Tinh phan tu dai dien chum
chieuu=size(U);
for i=1:chieuu(1,1)
fv(:,i)=Z*(U(i,:)'.*U(i,:)')/sum(U(i,:).*U(i,:));
end
fv;

%Tinh ma tran do rong chum
W=[];
for j=1:chieuu(1,2)
    for i=1:chieuu(1,1)
    W(i,j)=L2(fv(:,i),Z(:,j),x);
    end
end
W;
%Cap nhat ma tran phan vung 
   for j=1:chieuu(1,2)
    m=0;
    for k=1:chieuu(1,1)
       if W(k,j)==0
           m=m+1;
       end
    end
    if m==0
    for i=1:chieuu(1,1)
        tong=0;
        for k=1:chieuu(1,1)
        tong=tong+(W(i,j)^2)/(W(k,j)^2);
        end
        Umoi(i,j)=1/tong;
    end
        else
        for l=1:chieuu(1,1)
            if W(l,j)==0
                Umoi(l,j)=1/m;
            else
                Umoi(l,j)=0;
            end
        end
    end
end
Umoi;
%Tinh chuan
chuan=0;
for i=1:chieuu(1,1)
    for j=1:chieuu(1,2)
    lech(i,j)=abs(Umoi(i,j)-U(i,j));
    if lech(i,j)>chuan
        chuan=lech(i,j);
    end
    end
end
vonglap=vonglap+1;
end
Umoi;
Fv=fv';
gi = data([end-4:end],:);
for h=1:size(gi,1)
domain=gi(h,:);
for i=1:k
squared_diff=Fv(i,:);
integral_value (i,h) = 1-trapz(domain, squared_diff);
end
integral_value ;
end
[dc, classify]= max(Umoi(:,[end-4:end]).*integral_value,[],1)

subplot(3,1,1)
bar(1:125,Umoi(1,:))
xlabel('Cluster 1');
ylabel('Probability');
hold on
subplot(3,1,2)
bar(1:125,Umoi(2,:))
xlabel('Cluster 2');
ylabel('Probability');

subplot(3,1,3)
bar(1:125,Umoi(3,:))
xlabel('Cluster 3');
ylabel('Probability');