function drawPR()
InputResults = './pr/';
customColor = cell(6,1);
customColor{1, 1}='r'; customColor{2, 1}='g';
customColor{3, 1}='b'; customColor{4, 1}='k';
customColor{5, 1}='c'; customColor{6, 1}='m';
bianli(InputResults, customColor);

function bianli(InputResults, customColor)
idsResults = dir(InputResults);
for i = 3:length(idsResults)
    if idsResults(i, 1).isdir==1
        bianli(strcat(InputResults, idsResults(i, 1).name,'/'), customColor);
    else
        figure;hold on;
        for curMatNum = 3:length(idsResults)
            if strcmp(idsResults(curMatNum, 1).name((end-3):end), '.mat')
                load(strcat(InputResults, idsResults(curMatNum, 1).name));
                lh = plot(recall, precision, 'LineWidth', 2);
                set(lh,'Color', customColor{(curMatNum-2),1});
            else
                continue;
            end
        end
        series=regexp(InputResults,'/');
        titlename=InputResults((series(end-1)+1):(series(end)-1));
        title(titlename);
        legend('IG','S','IG+S',3,'FontName','Times');
        xlabel('Recall','FontName','Times');
        ylabel('Precision','FontName','Times');
        set(gca,'FontName','Times');
        set(gcf,'paperpositionmode','auto');
        grid;
        print('-dtiff','-r1000',[InputResults, strcat(titlename,'.tif')]);
        break;
    end
end
