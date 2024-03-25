clear;

for annual=2001:2019
    [a,R]=geotiffread('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');%先投影信息
    info=geotiffinfo('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');
    class_list=['veg','grass','shrub','wet','urban','others'];
    disp(annual)
    for landuse_num=1:6
         if landuse_num==1
            class_name='veg' ;
            value=1;
        elseif landuse_num==2
            class_name='grass';
            value=2;
        elseif landuse_num==3
            class_name='shrub';
            value=4;
        elseif landuse_num==4
            class_name='wet';
            value=5;
        elseif landuse_num==5
            class_name='urban';
            value=6;
        elseif landuse_num==6
            class_name='others';
            value=7;
        end
        
        
        annual2=annual+1;
        %folder=(['E:\landuse_biodiversity\Data\landuse_count\landuse_part\landuse_',int2str(landuse_num)]);
        folder=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_',class_name]);
        folder1=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop']);
        img1=importdata([folder1,'\landuse_500m_',int2str(annual),'.tif']); 
        img=importdata([folder,'\landuse_500m_',int2str(annual2),'.tif']); 
        %img2=importdata(['E:\landuse_biodiversity\Data\landuse_1km\landuse_500m_',int2str(annual2),'.tif']); 
        img=(int8(img)-int8(img1));
        %folder=(['E:\landuse_biodiversity\Data\landuse_part\landuse_',int2str(landuse_num)]);
        value2=value-3;
        img(img1~=3)=0;
        img(img==value2)=20;
        img(img~=20)=0;
        img(img==20)=1;
        folder2=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop_change_source4\','crop_to_',class_name]);
        if ~exist(folder2,'dir')%%判断文件夹是否存在
            mkdir(folder2);  %%不存在时候，创建文件夹
        else
            disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
        end
        filepath=strcat(folder2,'\landuse_500m_',int2str(annual2),'-',int2str(annual),'.tif');
        geotiffwrite(filepath,img,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

    end
    clear;
end