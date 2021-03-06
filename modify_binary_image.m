function [modified_image,num]=modify_binary_image(binary_image,threshold,imgname,ext,outputdir)
%Remove the possible exist small noise.
modified_image=binary_image;
[L,num]=bwlabel(binary_image,4); 
for i=1:num
    f=find(L==i);
    if length(f)<threshold
        modified_image(f)=0;
    end
end
cc=bwconncomp(modified_image);
num=cc.NumObjects;
modified_img_name=strrep(imgname,ext,'-saliencymap-6-binary-cells.tif');
imwrite(modified_image,strcat(outputdir,modified_img_name),'tif','Resolution',300);

