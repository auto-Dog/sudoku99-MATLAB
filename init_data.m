%数独游戏阶数
Order=9;
%mark 表格，下标含义：行坐标，列坐标，数项
cur_mark=ones(Order,Order,Order);
%记录每行/列/宫内已经确定的格数
knownNumsRow = zeros(1,9);
knownNumsCol = zeros(1,9);
%knownNumsPal = zeros(1,9);

%记录每一步的 mark 表格变化
%%第 4 维下标代表第几格（从 1 到 Order*Order 对应从左到右，逐行向下）
diff_mark=zeros(Order,Order,Order,Order*Order);
%记录实际的路径
route=zeros(1,Order*Order);
route(1) = startpos;
routedistance = 1;
%数项选择指针
%%下标表示第几格，数值代表下一轮将对应的数项
ptrs=ones(1,Order*Order);
%数格成组（哪几个组成一宫）定义
%%第 3 维下标表示第几组（宫）
%%数值含义：行坐标，列坐标
groups=zeros(Order,2,9);
groups(:,:,1)=[1 1;	    1 2;	1 3;
                2 1;	2 2;	2 3;
                3 1;	3 2;	3 3
            ];
groups(:,:,2)=[1 4;	    1 5;	1 6;
                2 4;	2 5;	2 6;
                3 4;	3 5;	3 6
                ];
groups(:,:,3)=[1 7;	    1 8;	1 9;
                2 7;	2 8;	2 9;
                3 7;	3 8;	3 9
                ];
groups(:,:,4)=[4 1;	    4 2;	4 3;
                5 1;	5 2;	5 3;
                6 1;	6 2;	6 3
                ];  
groups(:,:,5)=[4 4;	    4 5;	4 6;
                5 4;	5 5;	5 6;
                6 4;	6 5;	6 6
                ];
groups(:,:,6)=[4 7;	    4 8;	4 9;
                5 7;	5 8;	5 9;
                6 7;	6 8;	6 9
                ];
groups(:,:,7)=[7 1;	    7 2;	7 3;
                8 1;	8 2;	8 3;
                9 1;	9 2;	9 3
                ];
groups(:,:,8)=[7 4;	    7 5;	7 6;
                8 4;	8 5;	8 6;
                9 4;	9 5;	9 6
                ];
groups(:,:,9)=[7 7;	    7 8;	7 9;
                8 7;	8 8;	8 9;
                9 7;	9 8;	9 9
                ];
%预先已填的数字
%%数值含义：行坐标，列坐标，数项
%图13的数独
init_digit1 =[1 3 7; 1 7 2; 2 5 3; 3 1 2; 3 4 6; 3 5 9; 3 6 5;
            3 9 7; 4 3 5; 4 7 7; 5 2 9; 5 3 4; 5 5 8; 5 7 5;
            5 8 2; 6 3 8; 6 7 3; 7 1 4; 7 4 9; 7 5 1; 7 6 7;
            7 9 6; 8 5 5; 9 3 3; 9 7 1 ];
%图14的数独
init_digit2 = [ 1 3 7; 1 5 2; 2 4 3; 2 7 4; 3 1 9; 3 5 1; 3 8 2;
                4 2 1; 4 6 2; 5 1 7; 5 3 8; 5 7 3; 5 9 9; 6 4 4;
                6 8 7; 7 2 5; 7 5 7; 7 9 8; 8 3 3; 8 6 6; 9 5 3;
                9 7 1];

init_digit_course = [ 1 3 5; 1 5 7;1 8 8;
2 4 9; 2 9 2;3 1 4; 4 2 6; 4 5 2;5 1 2; 5 4 3;5 6 6; 5 9 9;
6 5 9; 6 8 3;7 9 7;8 1 3;8 6 4;9 2 8;9 5 1;9 7 4];

init_digit = [1 1 8; 2 3 3; 2 4 6; 3 2 7; 3 5 9; 3 7 2;
    4 2 5; 4 6 7; 5 5 4; 5 6 5; 5 7 7; 6 4 1; 6 8 3;
    7 3 1; 7 8 6; 7 9 8; 8 3 8; 8 4 5; 8 8 1;
    9 2 9; 9 7 4];
%按预设值修改cur_mark（即数独矩阵）
for i=1:size(init_digit,1)
    cur_mark=refresh_mark(groups,cur_mark,init_digit(i,1),init_digit(i,2),init_digit(i,3));
    finished(init_digit(i,1),init_digit(i,2)) = 1;
    knownNumsRow(init_digit(i,1)) = knownNumsRow(init_digit(i,1))+1;
    knownNumsCol(init_digit(i,2)) = knownNumsCol(init_digit(i,2))+1;
end

%记录搜索过程,预开足够多个记录单元
cell_record=zeros(1,1000);
cell_record_ptr=1;