function initval=A001_Images_Set_Experiment(exp)
%This function stores paths etc. of various bacteria experiments. Kers2012

%common settings---------------------------------------------
if nargin<1, exp='002_oriZ_dif_2304_DnaNsignal';end
user='Roy';
switch user
      case 'Jacob', 
          projectpath='D:\jkerssemakers\My Documents\BN_ND_ActiveProjects\BN_ND11_CharlBacterialReplication\';
          versionpath='2014_01 DnaNDnaX DualColor';
          toolspath='\SupportingFunctions';          
          initval.skippicturesavingbecauseCharlislogginghislive=0;
      case 'Sriram', 
          projectpath='D:\jkerssemakers\My Documents\BN_ND_ActiveProjects\BN_ND11_CharlBacterialReplication\';
          versionpath='2014_01 DnaNDnaX DualColor';
          toolspath='\SupportingFunctions';          
          initval.skippicturesavingbecauseCharlislogginghislive=0;
      case 'Roy' ,
          projectpath='/Users/rleeuw/Work/DataAnalysis/';
          versionpath='201511_TUSdifDnaN_Montage/';
          toolspath='SupportingFunctions';    
      case 'RoyPC' ,
          projectpath='D:\rleeuw\DataAnalysis\';
          versionpath='201511_TUSdifDnaN_Montage\';
          toolspath='SupportingFunctions';
end
addpath(strcat(projectpath,versionpath));
addpath(strcat(projectpath,versionpath,toolspath));

initval.plotintermediateresults=0;
%experiment-specific settings-------------------------------------
switch exp    
    case   '001_DnaN_TUS_dif_30122014_DnaNsignal',            initval=Exp001_DnaN_TUS_dif_30122014_DnaNsignal(initval, user);
   case   '001_DnaN_TUS_dif_30122014_TUSsignal',             initval=Exp001_DnaN_TUS_dif_30122014_TUSsignal(initval, user);
   case   '001_DnaN_TUS_dif_30122014_difsignal',             initval=Exp001_DnaN_TUS_dif_30122014_difsignal(initval, user);
   case   '002_oriZ_dif_2304_DnaNsignal',             initval=Exp002_oriZ_dif_23042015_DnaNsignal(initval, user);
   case   '002_oriZ_dif_2304_R2signal',             initval=Exp002_oriZ_dif_23042015_R2signal(initval, user);
end

