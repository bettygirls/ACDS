clc;
clear all;
inputdir='../DATA/MicroscopicImages/multiple/';
outputdir='../RESULTS/4MET/multiple/';
extgroup={'.tif','.bmp','.jpg','.png','.gif','.jpeg'};
timefile='../RESULTS/4MET-multiple.time';
cellsfile='../RESULTS/4MET-multiple.cells';
if exist(timefile,'file')
    delete(timefile);
end
if exist(cellsfile,'file')
    delete(cellsfile)
end
timefid=fopen(timefile,'a+');
cellsfid=fopen(cellsfile,'a+');
fprintf(cellsfid,'4MET');
tstart=tic;%Total time start
for i = 1:length(extgroup)
    ext=extgroup(i);
    ext=ext{1};
    extwild=strcat('*',ext);
    inputdirformat= [inputdir extwild];
    files= dir(inputdirformat);
    for j=1:length(files)
        timg=tic;%t start
        imgname = files(j).name; 
        f = imread(strcat(inputdir,imgname));
        [row,col,dim] = size(f);
        if dim==1
            continue
        else
        img_color=imresize(f,1);
        numCells=met_entrance(img_color,imgname,ext,outputdir);
        fprintf(cellsfid,'\n%d',numCells);
        end
        timgtime=toc(timg);%t end
        fprintf(timefid,'%10s\tMinimum error thresholding: %9.5f\n',imgname,timgtime);
     end
end
ttime=toc(tstart);%Total time end
fprintf(timefid,'\n\tTotal running time: %g\t%s',ttime,datestr(now));
fclose(cellsfid);
fclose(timefid);