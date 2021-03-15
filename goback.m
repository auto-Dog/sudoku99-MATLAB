%back
finished(xcell,ycell) = 0;
knownNumsRow = sum(finished');
knownNumsCol = sum(finished);  
route(routedistance) = 0;
routedistance = routedistance-1;
cell = route(routedistance);



