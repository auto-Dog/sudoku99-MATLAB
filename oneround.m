%一轮筛选过程
%fprintf('cell=%d\n',cell);  %当前所在格子 cell取值0-81
cell_record(cell_record_ptr)=cell;  %1x1000的数组，记录尝试过程
cell_record_ptr=cell_record_ptr+1;  

%将所在格子绝对坐标转换为xy坐标 行 列
xcell=ceil(cell/Order);     
ycell=mod(cell-1,Order)+1;  

goto_nextcell=0;
while((goto_nextcell==0) && (ptrs(cell)<=Order))
    if cur_mark(xcell,ycell,ptrs(cell))==0      %标记为0，指针后移
        ptrs(cell)=ptrs(cell)+1;
    else
        next_mark=refresh_mark(groups,cur_mark,xcell,ycell,ptrs(cell)); %标记为1，锁定该数字
       
        finished(xcell,ycell) = 1;
        knownNumsRow = sum(finished');
        knownNumsCol = sum(finished);

        
        if check_mark(next_mark)==1
            diff_mark(:,:,:,cell)=next_mark-cur_mark;   %记录修改值
            cur_mark=next_mark;
            %cell=cell+1;
            %{
                debug
            matt = finished;
            matt = [knownNumsCol; matt];
            countRow = [0 knownNumsRow];
            matt = [countRow' matt];
            disp(matt);
            %}

            gofront;
            goto_nextcell=1;
        else
            finished(xcell,ycell) = 0;
            knownNumsRow = sum(finished');
            knownNumsCol = sum(finished);  
            ptrs(cell)=ptrs(cell)+1;
        end
    end
end

if goto_nextcell==0
    ptrs(cell)=1;
    goback;
    %fprintf('go back to cell=%d\n',cell)
    %cell=cell-1;
    if routedistance~=0  %行进距离尚不等于0（没有回退到起始点）时还原到上一状态
        cur_mark=cur_mark-diff_mark(:,:,:,cell);
        ptrs(cell)=ptrs(cell)+1;
    end
end
