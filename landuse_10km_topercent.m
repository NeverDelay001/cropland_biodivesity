clear;

for annual=2001:2020
    for landuse_num=1:9
    %     [a,R]=geotiffread('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');%先投影信息
    %     info=geotiffinfo('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');
        country2=importdata('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif'); 
        [a,R]=geotiffread('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif');%先投影信息
        info=geotiffinfo('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif');
        class_list=['veg','grass','shrub','wet','urban','others'];
        disp(annual)
        %folder=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop\landsue_crop_10km']);
        folder=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_10class_mask_all\landuse_10class_10km_part\landuse_',int2str(landuse_num)]);
        imgpath=strcat(folder,'\landuse_10km_',int2str(annual),'.tif');
        img1=importdata(imgpath);
        img=img1./(24*24);
    %     img = zeros(size(country2));
        img(img>1)=1;

        %folder2=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop\landuse_crop_10km_percent']);
        folder2=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_10class_mask_all\landuse_10class_10km_part_percent\landuse_',int2str(landuse_num)]);


        if ~exist(folder2,'dir')%%判断文件夹是否存在
            mkdir(folder2);  %%不存在时候，创建文件夹
        else
            disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
        end
        filepath=strcat(folder2,'\landuse_10km_',int2str(annual),'.tif');
        geotiffwrite(filepath,img,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

    end
    clear;
end