clear;

for annual=2001:2019
%     [a,R]=geotiffread('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');%先投影信息
%     info=geotiffinfo('H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop\landuse_500m_2001.tif');
    country2=importdata('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif'); 
    [a,R]=geotiffread('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif');%先投影信息
    info=geotiffinfo('E:\landuse_biodiversity\Data\All_data_10km\world_range_10km.tif');
    class_list=['veg','grass','shrub','wet','urban','others'];
    disp(annual)
    for landuse_num=1:6
        if landuse_num==1
            class_name='veg' ;
        elseif landuse_num==2
            class_name='grass';
        elseif landuse_num==3
            class_name='shrub';
        elseif landuse_num==4
            class_name='wet';
        elseif landuse_num==5
            class_name='urban';
        elseif landuse_num==6
            class_name='others';
        end
        annual2=annual+1;
        folder=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop_change_source4\','crop_to_',class_name]);
        imgpath=strcat(folder,'\landuse_500m_',int2str(annual2),'-',int2str(annual),'.tif');
        img1=importdata(imgpath);
        img = zeros(size(country2));
        for i=1:1400
%             b=datestr(now); 
            for j = 1: 3398
        %         a(i,j)=sum(country(round(27.7785*(i-1))+1:round(27.7785*i),round(27.7785*(j-1))+1:round(27.7785*j)));
%                 %1km 重采样为25km
%                 mat=img1(round(27.7785*(i-1))+1:round(27.7785*i),round(27.7785*(j-1))+1:round(27.7785*j));
                mat=img1(round(24.0278*(i-1))+1:round(24.0278*i),round(24.0235*(j-1))+1:round(24.0235*j));
                img(i,j)=sum(sum(mat(:)>0));
                %img(i,j)=round(mean(mean(mat)));
                %img(i,j)=((sum(sum(img1(round(27.7785*(i-1))+1:round(27.7785*i),round(27.7785*(j-1))+1:round(27.7785*j)))))/landuse_num);
            end
%             c=datestr(now); 
            %disp(c-b);
        end
%         %folder=(['E:\landuse_biodiversity\Data\landuse_count\landuse_part\landuse_',int2str(landuse_num)]);
% %         folder=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_others']);
% %         folder1=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_class\landuse_crop']);
% %         img1=importdata([folder1,'\landuse_500m_',int2str(annual2),'.tif']); 
% %         img=importdata([folder,'\landuse_500m_',int2str(annual),'.tif']); 
%         %img2=importdata(['E:\landuse_biodiversity\Data\landuse_1km\landuse_500m_',int2str(annual2),'.tif']); 
%         img=(int8(img1)-int8(img));
%         %folder=(['E:\landuse_biodiversity\Data\landuse_part\landuse_',int2str(landuse_num)]);
%         img(img1~=3)=0;
%         img(img==-4)=20;
%         img(img~=20)=0;
%         img(img==20)=1;
        img=int16(img);
        %folder2=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop_change_source\','crop_from_others']);
        folder2=(['H:\landuse_biodiversity\Data\landuse_500m\landuse_500m_crop_change_source4\','crop_to_',class_name,'_10km']);
        
        if ~exist(folder2,'dir')%%判断文件夹是否存在
            mkdir(folder2);  %%不存在时候，创建文件夹
        else
            disp('dir is exist'); %%如果文件夹存在，输出:dir is exist
        end
        filepath=strcat(folder2,'\landuse_10km_',int2str(annual2),'-',int2str(annual),'.tif');
        geotiffwrite(filepath,img,R,'GeoKeyDirectoryTag',info.GeoTIFFTags.GeoKeyDirectoryTag);

    end
    clear;
end