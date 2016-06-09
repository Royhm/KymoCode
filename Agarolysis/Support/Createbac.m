function [mmask, nmask,bacpic,croppedimg] = Createbac(init,imageframe,thismesh,thisBbox,thisbacsize,bacpath,frami)
            
    bound = init.Extrabound;
    framesize = size(imageframe);
    thisRbox = round(thisBbox)+2*bound+1;
    Rbacsize = round(thisbacsize);
    thismsize = round(thisbacsize/init.pcresize);

    % Create mask from mesh
    thismeshl = [thismesh(:,1:2);thismesh(:,3:4)];
    thiscropmesh = round([thismeshl(:,1)-thisBbox(1), thismeshl(:,2)-thisBbox(3)]/init.pcresize);
    mask = poly2mask(thiscropmesh(:,1)',thiscropmesh(:,2)',thismsize(2),thismsize(1));
    
    % Dilate mask to get entire spot
    dimask = imdilate(mask,strel('disk',init.strelval));

    % Add bound to imageframe
    nimgframe = zeros(framesize(1)+2*bound,framesize(2)+2*bound);
    nimgframe(bound+1:end-bound,bound+1:end-bound)=imageframe;
    
    % Create non-masked bacpic from Cellbox

    croppedimg = nimgframe(thisRbox(3):thisRbox(3)+Rbacsize(2)-1,thisRbox(1):thisRbox(1)+Rbacsize(1)-1);

    % Ensure that size of the mask is the same as the size of the bacpic
    cimgsize = size(croppedimg);
    nmask = double(imresize(dimask,cimgsize));
    mmask = double(imresize(mask,cimgsize));
    
    % Creating the masked bacpic by applying the mask to the bacpic
    bacpic = uint16(nmask.*croppedimg);
    thisbacpath = strcat(num2str(frami,'%03.0f'),'.tif');
    imwrite(bacpic,strcat(bacpath,thisbacpath));
end