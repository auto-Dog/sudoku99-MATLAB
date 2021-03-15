%front
moveTo = 0;
maxRow = 0;
maxCol = 0;
tmp = 0;
label = 0;

%while((moveTo==0)||(finished(moveTo)==1)||(moveTo==startpos))
    %moveTo = randi([1,81]);
%end
    %在已知信息最密集的行/列内填写 先找列再找行
for i = 1:9
    if(knownNumsCol(i)<9 && knownNumsCol(i)>maxCol)
        maxCol = knownNumsCol(i);
        moveTo = i;
    end

end
for j = 1:9
    if((knownNumsRow(j)<9) && (finished(j,moveTo) == 0) && (knownNumsRow(j)>maxRow))
        maxRow = knownNumsRow(j);
        tmp = 9*(j-1);
        label = 1;
    end
end
if label == 0
    fprintf('WARNING! tmp=0 \n');
end
moveTo = moveTo+tmp;
%debug


routedistance = routedistance+1;
route(routedistance) = moveTo;
cell = moveTo;
