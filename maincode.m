%Main procedure
finished = zeros(9,9);
startpos = 81;  %从该位置出生有较好的时间复杂度
init_data;  %填入数据

tic;    
cell=startpos;     %从最中间格子开始
%while (cell<=Order*Order && cell>0)
while(sum(sum(finished))~=81)
    oneround;   %一轮推演（推演前将状态保存在了diff_mark中）
end
%if cell==Order*Order+1  
    fprintf('\nIt took %6.2f s.\n',toc);
    fprintf('The answer is:\n');
    print_result;   %在命令窗以数组的形式显示结果
%elseif cell==0
   % fprintf('\nThe puzzle has no answer!\n');
%end
plot([1:cell_record_ptr-1],cell_record(1:cell_record_ptr-1),'-*');  %绘制迭代次数图像
title('运行迭代过程');
xlabel('迭代搜索轮数');
ylabel('方格编号');