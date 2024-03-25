mask=importdata(['H:\landuse_biodiversity\Data\landuse_500m\land_mask_500m_Clip.tif']); 
continent=importdata(['H:\landuse_biodiversity\Data\other_data\continent_10km.tif']); 

area=importdata(['H:\landuse_biodiversity\Data\landuse_500m\MODBA10_Stand.tif']); 
Result=[];
for annual=2001:2020
    disp(annual)
    result=zeros(1,2);
    %result=zeros(1,10)+NaN;
    %img=importdata(['E:\landuse_biodiversity\Data\landuse_300m\landuse_300m\CCI_LU',int2str(annual),'.tif']); 
    %img=importdata(['H:\landuse_biodiversity\Data\landuse_future_300m\landuse_300m\','landuse_300m_SSP1.tif']); 
    img=importdata(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_10class_mask_all\landuse_10class_10km_percent\landuse_10km_',int2str(annual),'.tif']); 
    result(1,1)=annual; 
    %img(mask<1)=0;
    img(isnan(img))=0;
    area(isnan(area))=0;
    sum_area=img.*area;
    
    %folder=(['E:\landuse_biodiversity\Data\landuse_count\landuse_class_part\landuse_',int2str(landuse_num)]);
    result(1,1)=annual;
    percent=sum(sum(sum_area));
    result(1,2)=percent; 

    Result=[Result;result];
end
filename=(['E:\landuse_biodiversity\Data\csv\landuse_500m\landuse_500m_10class_area.csv']);
%Result=array2table(Result,'VariableNames',{'annual','TSMBF','TSDBF','TSCF','TBMF','TCF','BFT','TSGSS','TGSS','FGS','MGS','TD','MFWS','DXS','MG'});
%Result=array2table(Result,'VariableNames',{'c_num','2001','2002','2003','2004','2005','2006','2007','2008','2009','2010','2011','2012','2013','2014','2015','2016','2017','2018','2019'});
Result=array2table(Result,'VariableNames',{'year','area'});
%Result=array2table(Result,'VariableNames',{'annual','UNITED STATES','India','China','Russia','Brazil','Argentina','Canada','Nigeria','Ukraine','Australia'});
writetable(Result,filename);