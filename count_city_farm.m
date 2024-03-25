%img1=importdata([folder,'\landuse_',int2str(annual),'.tif']);
img1=importdata(['H:\landuse_biodiversity\Data\landuse_500m_new\landuse_10class_500m_part_change\landuse_2_to_1\landuse_500m_2020_2001.tif']);
folder="H:\landuse_biodiversity\Data\landuse_500m_new\landuse_10class_500m_part_change"
sum1=sum(img1>0);
sum=0;
for num=1:10
    img = importdata([folder,'landuse_2_to_',num,'\landuse_500m_2020_2001.tif']);
    sum2=sum(img>0);
    sum=sum2+sum;
end
out=sum1/sum2;