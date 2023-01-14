clc;
clear;
close all;
warning off;
cd TEST
delete 'Thumbs.db';
[J P]=uigetfile('.jpg','select a image for ROI ');
cd ..
I1=imread(strcat(P,J));
figure,imshow(I1);
R=getrect;
save R R ;
theta=[(pi/4)];ff=0.00568;Sy=1;Sx=1;
%========================
SE=imcrop(I1,R);
    [gabout, Fam, Fph, Fri] = gaborfilter(double(I1),Sx,Sy,ff,theta);    
    t1=mean2(Fam);
    t2=mean2(Fri);
    for kk=1:size(Fri,1)
        for tt=1:size(Fri,2)
            if Fam(kk,tt)>=t1
                Fmm(tt,kk)=1;
            else
                Fmm(tt,kk)=0;
            end
            if Fri(kk,tt)>=t1
                Frr(tt,kk)=1;
            else
                Frr(tt,kk)=0;
            end
        end
    end
 FQ=[Fmm(:); Frr(:)]; 


%=============================

F=dir('TRAIN');
F=char(F.name);
sz=size(F,1)-2;

for ii=1:sz
    cd TRAIN
    I=imread(F(ii+2,:));
    cd ..
    S=imcrop(I,R);
    [gabout, Fam, Fph, Fri] = gaborfilter(double(S),Sx,Sy,ff,theta);    
    t1=mean2(Fam);
    t2=mean2(Fri);
    for kk=1:size(Fri,1)
        for tt=1:size(Fri,2)
            if Fam(kk,tt)>=t1
                Fmm(tt,kk)=1;
            else
                Fmm(tt,kk)=0;
            end
            if Fri(kk,tt)>=t1
                Frr(tt,kk)=1;
            else
                Frr(tt,kk)=0;
            end
        end
    end
    FV{ii}=[Fmm(:); Frr(:)];       
    rr(ii)=dist(FQ',FV{ii},'hamming');        
end
sr=sort(rr)
ID=find(sr(2)==sr)
cd TRAIN
H=imread(F(ID+1,:));
cd ..
figure, subplot(121),imshow(H);title('Found')
subplot(122);imshow(I1);title('Query');
%=======================================
