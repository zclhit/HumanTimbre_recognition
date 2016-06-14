clc;
clear;

load Sound_classification_1;

for i=1:10

SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 

classLoss(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
end

for i=1:10
classLoss(11,i)=mean(classLoss(1:10,i));
end
total=mean(classLoss(11,i));
% %vol
% load AD_classsification_testvol;
% 
% for i=1:10
% 
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 
% 
% classLossvol(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
% 
% for i=1:10
% classLossvol(11,i)=mean(classLossvol(1:10,i));
% end
% %fa
% load AD_classsification_testfa;
% 
% for i=1:10
% 
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 
% 
% classLossfa(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
% 
% for i=1:10
% classLossfa(11,i)=mean(classLossfa(1:10,i));
% end
% %adc
% load AD_classsification_testadc;
% 
% for i=1:10
% 
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 
% 
% classLossadc(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
% 
% for i=1:10
% classLossadc(11,i)=mean(classLossadc(1:10,i));
% end
% %rd
% load AD_classsification_testrd;
% 
% for i=1:10
% 
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 
% 
% classLossrd(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
% 
% for i=1:10
% classLossrd(11,i)=mean(classLossrd(1:10,i));
% end
% %mk
% load AD_classsification_testmk;
% 
% for i=1:10
% 
% SVMModel = fitcsvm(X,Y,'CrossVal','on','ClassNames',{'NC','AD'},'Standardize',true); 
% 
% classLossmk(i,1:10)=kfoldLoss(SVMModel,'mode','individual');
% end
% 
% for i=1:10
% classLossmk(11,i)=mean(classLossmk(1:10,i));
% end