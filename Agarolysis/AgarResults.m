clear all
close
clc

folder='C:\Users\water\Documents\GitHub\Data\Target Data\Agar Data';
slash = '\';
exps=[1 2  3 4 5 7 8 9];
Intensityval = [700, 300, 700];

Lcfp=[];    Lyfp=[];    Lrfp=[];
Pcfp=[];    Pyfp=[];    Prfp=[];
Icfp=[];    Iyfp=[];    Irfp=[];
Fcfp=[];    Fyfp=[];    Frfp=[];
ncfp=[];    nyfp=[];    nrfp=[];
celllength = [];

    
j=1; 
for i=exps;
    E{j}=load(strcat(folder,slash,num2str(i),slash,'Results.mat')); 
    j=j+1;
end

allCFP_L = [];

Nexp=size(E,2);


for i=1:Nexp
    
    Ncells{i}=size(E{i}.DataStruct,2);
    
    
    for j=1:Ncells{i} 
        
        if ~isempty(E{i}.DataStruct(1,j).Lnorm)        
            LNormCFP{i,j}=E{i}.DataStruct(1,j).Lnorm;
        else
            LNormCFP{i,j}=0;
        end
        
        CellLength{i,j}=E{i}.DataStruct(1,j).CellLength;
        
        
        CFPld{i,j}=E{i}.DataStruct(1,j).ld;
        YFPld{i,j}=E{i}.DataStruct(2,j).ld;
        RFPld{i,j}=E{i}.DataStruct(3,j).ld;
                
        NspotsCFP=size(CFPld{i,j},2);
        NspotsYFP=size(YFPld{i,j},2);
        NspotsRFP=size(RFPld{i,j},2);        
     
        if NspotsCFP==0
            CFPld{i,j}{1}=[];
        else
            for k=1:NspotsCFP
                Lcfp=[Lcfp CellLength{i,j}];
                Pcfp=[Pcfp CFPld{i,j}{k}(1,2)/CellLength{i,j}];
                Icfp=[Icfp CFPld{i,j}{k}(1,1)/Intensityval(1)];
                Fcfp=[Fcfp CFPld{i,j}{k}(1,7)];
            end
        end
        ncfp = [ncfp NspotsCFP];
        celllength = [celllength CellLength{i,j}];
        
        if NspotsYFP==0
            YFPld{i,j}{1}=[];
        else
            for k=1:NspotsYFP
                Lyfp=[Lyfp CellLength{i,j}];
                Pyfp=[Pyfp YFPld{i,j}{k}(1,2)/CellLength{i,j}];
                Iyfp=[Iyfp YFPld{i,j}{k}(1,1)/Intensityval(2)];
                Fyfp=[Fyfp YFPld{i,j}{k}(1,7)];
            end
        end
        nyfp = [nyfp NspotsYFP];
        
        if NspotsRFP==0
            RFPld{i,j}{1}=[];
        else
            for k=1:NspotsRFP            
                Lrfp=[Lrfp CellLength{i,j}];
                Prfp=[Prfp RFPld{i,j}{k}(1,2)/CellLength{i,j}];
                Irfp=[Irfp RFPld{i,j}{k}(1,1)/Intensityval(3)];
                Frfp=[Frfp RFPld{i,j}{k}(1,7)];
            end
        end
        nrfp = [nrfp NspotsRFP];
    end
end

remove = Irfp<0;
Iyfp(remove) = [];
Lyfp(remove) = [];
Pyfp(remove) = [];
Fyfp(remove) = [];


%% Position vs. cell length
% CFP

fig1 = figure(1);
set(fig1,'Position',[20,300,1800,500])


subplot(1,3,1)
hold on
scatter(single(Lcfp),Pcfp,Icfp,'b','filled');
myfit=polyfit(Lcfp,Pcfp,4);
x=15:0.1:45;
y=polyval(myfit,x);
plot(x,y,'r','LineWidth',5)
xlabel('Cell Length'); ylabel('Normalized osition of spot in cell'); 
title('Agar data: CFP')
hold off
axis([12 43 -0.1 1.1])


% YFP

subplot(1,3,2);
hold on
scatter(single(Lyfp),Pyfp,Iyfp,'m','filled');
myfit=polyfit(Lyfp,Pyfp,4);
x=15:0.1:45;
y=polyval(myfit,x);
% plot(x,y,'k','LineWidth',5)
xlabel('Cell Length'); ylabel('Normalized osition of spot in cell'); 
title('Agar data: YFP')
hold off
axis([12 43 -0.1 1.1])
axis([12 43 -0.1 1.1])


% RFP

subplot(1,3,3)
hold on
scatter(single(Lrfp),Prfp,Irfp,'r','filled');
myfit=polyfit(Lrfp,Prfp,4);
x=15:0.1:45;
y=polyval(myfit,x);
xlabel('Cell Length'); ylabel('Normalized osition of spot in cell'); 
title('Agar data: RFP')
% plot(x,y,'k','LineWidth',5)
hold off
axis([12 43 -0.1 1.1])
axis([12 43 -0.1 1.1])


%% Intensity vs. position

% CFP

fig2 = figure(2);
set(fig2,'Position',[20,300,1800,500])
subplot(1,3,1)

hold on
scatter(Pcfp,Icfp,'b','x');
myfit=polyfit(Pcfp,Icfp,4);
x=0:00.1:1;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Position in cell'); ylabel('Spot Intensity'); 
title('Agar data: CFP')
hold off
axis([0 1 -0.1 90])


% YFP

subplot(1,3,2)
hold on
scatter(Pyfp,Iyfp,'m','x');
myfit=polyfit(Pyfp,Iyfp,4);
x=0:00.1:1;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Position in cell'); ylabel('Spot Intensity'); 
title('Agar data: YFP')
hold off
axis([0 1 -0.1 90])


% RFP

subplot(1,3,3)
hold on
scatter(Prfp,Irfp,'r','x');
myfit=polyfit(Prfp,Irfp,4);
x=0:00.1:1;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Position in cell'); ylabel('Spot Intensity'); 
title('Agar data: RFP')
hold off
axis([0 1 -0.1 90])


%% Numspots vs. position

bins = 15;
thisedge = (0:bins)/bins;

fig3 = figure(3);
set(fig3,'Position',[20,300,1800,500])

% CFP

subplot(1,3,1)
[numbin,edges] = histcounts(Pcfp,thisedge);
norm = max(numbin)/80;
X = diff(edges);
X = cumsum(X) - X(1)/2;
hold on
scatter(Pcfp,Icfp,'b','x');
plot(X,numbin/norm,'k','LineWidth',3)
hold off
xlabel('Position in cell'); ylabel('Amount of spots (normalized)');
title('Agar data: CFP')
axis([0 1 -0.1 90])

% YFP

subplot(1,3,2)
[numbin,edges] = histcounts(Pyfp,thisedge);
norm = max(numbin)/80;
X = diff(edges);
X = cumsum(X) - X(1)/2;
hold on
scatter(Pyfp,Iyfp,'m','x');
plot(X,numbin/norm,'k','LineWidth',3)
hold off
xlabel('Position in cell'); ylabel('Amount of spots (normalized)');
title('Agar data: YFP')
axis([0 1 -0.1 90])

% RFP

subplot(1,3,3)
[numbin,edges] = histcounts(Prfp,thisedge);
norm = max(numbin)/80;
X = diff(edges);
X = cumsum(X) - X(1)/2;
hold on
scatter(Prfp,Irfp,'r','x');
plot(X,numbin/norm,'k','LineWidth',3)
hold off
xlabel('Position in cell'); ylabel('Amount of spots (normalized)');
title('Agar data: RFP')
axis([0 1 -0.1 90])


%% Numspots vs. position & cell length

bins = 15;
thisedge2{1} = linspace(min(Lcfp),max(Lcfp),bins+1);
thisedge2{2} = (0:bins)/bins;

fig4 = figure(4);
set(fig4,'Position',[20,300,1800,500])
fig5 = figure(5);
set(fig5,'Position',[20,300,1800,500])

% CFP

subplot(1,3,1)
Numcfp(1,:) = Lcfp;
Numcfp(2,:) = Pcfp;

figure(4)
subplot(1,3,1)
Heatmap = hist3(Numcfp','Edges',thisedge2);
pcolor(thisedge2{1},(thisedge2{2}),Heatmap');
colormap(hot) % heat map
xlabel('Cell Length'); ylabel('Position in Cell');
title('Agar data: CFP');
grid on

figure(5)
subplot(1,3,1)
hold on
hist3(Numcfp','Edges',thisedge2)
colormap(hot) % heat map
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
xlabel('Cell Length'); ylabel('Position in Cell');zlabel('Amount of spots')
title('Agar data: CFP');
grid off
hold off
axis([min(Lcfp),max(Lcfp),0,1])
view(3)

% YFP
Numyfp(1,:) = Lyfp;
Numyfp(2,:) = Pyfp;

figure(4)
subplot(1,3,2)
Heatmap = hist3(Numyfp','Edges',thisedge2);
pcolor(thisedge2{1},(thisedge2{2}),Heatmap');
colormap(hot) % heat map
xlabel('Cell Length'); ylabel('Position in Cell');
title('Agar data: YFP');
grid on

figure(5)
subplot(1,3,2)
hold on
hist3(Numyfp','Edges',thisedge2)
colormap(hot) % heat map
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
xlabel('Cell Length'); ylabel('Position in Cell');zlabel('Amount of spots')
title('Agar data: YFP');
grid off
hold off
axis([min(Lyfp),max(Lyfp),0,1])
view(3)

% RFP
Numrfp(1,:) = Lrfp;
Numrfp(2,:) = Prfp;

figure(4)
subplot(1,3,3)
Heatmap = hist3(Numrfp','Edges',thisedge2);
h = pcolor(thisedge2{1},(thisedge2{2}),Heatmap');
colormap(hot) % heat map
xlabel('Cell Length'); ylabel('Position in Cell');
title('Agar data: RFP');
grid on

figure(5)
subplot(1,3,3)
hold on
hist3(Numrfp','Edges',thisedge2)
colormap(hot) % heat map
set(get(gca,'child'),'FaceColor','interp','CDataMode','auto');
xlabel('Cell Length'); ylabel('Position in Cell');zlabel('Amount of spots')
title('Agar data: RFP');
grid off
hold off
axis([min(Lrfp),max(Lrfp),0,1])
view(3)


%% Full cell intensity vs. celllength

clear plotcfp plotyfp plotrfp
fig6 = figure(6);
set(fig6,'Position',[20,300,1800,500])

% YFP

plotcfp(1,:) = Lcfp;
plotcfp(2,:) = Fcfp/max(Fcfp);
plotcfp = unique(plotcfp','rows')';

subplot(1,3,1)
hold on
scatter(plotcfp(1,:),plotcfp(2,:),'b','x');
myfit=polyfit(plotcfp(1,:),plotcfp(2,:),1);
x=12:0.1:43;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Cell Length'); ylabel('Normalized full cell intensity'); 
title('Agar data: CFP')
hold off
axis([12 43 -0.1 1.1])

% YFP

plotyfp(1,:) = Lyfp;
plotyfp(2,:) = Fyfp/max(Fyfp);
plotyfp = unique(plotyfp','rows')';

subplot(1,3,2)
hold on
scatter(plotyfp(1,:),plotyfp(2,:),'m','x');
myfit=polyfit(plotyfp(1,:),plotyfp(2,:),1);
x=12:0.1:43;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Cell Length'); ylabel('Normalized full cell intensity'); 
title('Agar data: YFP')
hold off
axis([12 43 -0.1 1.1])


% RFP

plotrfp(1,:) = Lrfp;
plotrfp(2,:) = Frfp/max(Frfp);
plotrfp = unique(plotrfp','rows')';

subplot(1,3,3)
hold on
scatter(plotrfp(1,:),plotrfp(2,:),'r','x');
myfit=polyfit(plotrfp(1,:),plotrfp(2,:),1);
x=12:0.1:43;
y=polyval(myfit,x);
plot(x,y,'k','LineWidth',3)
xlabel('Cell Length'); ylabel('Normalized full cell intensity'); 
title('Agar data: RFP')
hold off
axis([12 43 -0.1 1.1])


%% Numspots/cell vs. cell length
fig1 = figure(1);

p1 = find(nrfp == 1);
p2 = find(nrfp == 2);
p3 = find(nrfp == 3);
p4 = find(nrfp == 4);

m(1) = mean(celllength(p1));
m(2) = mean(celllength(p2));
m(3) = mean(celllength(p3));
m(4) = mean(celllength(p4));

myfit=polyfit(m,1:4,1);
x=[12,43];
y=polyval(myfit,x);

hold on
scatter(celllength,nrfp,'m')
plot(x,y,'k--','LineWidth',1)
axis([12, 43, 0, 5])
xlabel('Cell length'); ylabel('Number of spots per cell')
title('Numspots/cell vs. cell length for YFP')
hold off