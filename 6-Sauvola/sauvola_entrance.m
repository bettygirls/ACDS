function numObjects=sauvola_entrance(img_color,imgname,ext,outputdir)

img_gray=rgb2gray(img_color);
img = imadjust(img_gray);
img = ~sauvola(img);
img_binary_name=strrep(imgname,ext,'-binary-Sauvola.tif');
imwrite(img,strcat(outputdir,img_binary_name),'tif','Resolution',300);

se=strel('disk',5);
binary_close=imclose(img,se);
binary_holes=imfill(binary_close,'holes');
[L,num]=bwlabel(binary_holes,4);
numObjects=num;

max=0;
label=0;
for i=1:num;
f=find(L==i);
if max<length(f)
max=length(f);
label=i;
end
end
L(find(L~=label))=0;
img_R=img_color(:,:,1);
img_G=img_color(:,:,2);
img_B=img_color(:,:,3);
img_R(L==0)=0;
img_G(L==0)=0;
img_B(L==0)=0;
img_color=cat(3,img_R,img_G,img_B);
img_object_name=strrep(imgname,ext,'-object-Sauvola.tif');
imwrite(img_color,strcat(outputdir,img_object_name),'tif','Resolution',300);