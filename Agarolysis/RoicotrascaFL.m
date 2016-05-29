 function RoicotrascaFL(jarpath,Imgspath,Imgname,Beampath,Rval,Tval)
%% Presets
if nargin < 5;
    Rval = 1;
    Tval = [0,0];
end


if ~exist('jarpath','var')
    jarpath = 'C:\Users\water\Documents\GitHub\KymoCode\Agarolysis\SupportingFunctions\';
end
if ~exist('Imgspath','var')
    Imgspath = 'C:\Users\water\Documents\GitHub\Data\141230_dnaN_dif_tus\Fluorescence\CFP\';
end
if ~exist('Imgname','var')
    Imgname = 'CFP.tif';
end
if ~exist('Beampath','var')
    Beampath = 'C:\Users\water\Documents\GitHub\Data\141230_dnaN_dif_tus\Fluorescence\BeamShape457.tif';
end

% Add ImageJ and MIJI to path
javaaddpath(strcat(jarpath,'mij.jar'))
javaaddpath(strcat(jarpath,'ij.jar'))

%% Rolling ball
Rballedname = strcat('Rballed_',Imgname);
copyfile(strcat(Imgspath,Imgname),strcat(Imgspath,Rballedname));
disp('Copying file...')
pause(3)

MIJ.start
MIJ.run('Open...',strcat('path=[',Imgspath,Rballedname,']'))
MIJ.run('Subtract Background...', 'rolling=10 stack')
MIJ.run('Save','Tiff...')
MIJ.closeAllWindows
MIJ.exit

disp('Rolling ball finished')

%%

imgpath = strcat(Imgspath,Rballedname);
imginfo = imfinfo(imgpath);
num_images = numel(imginfo);
RIpath = strcat(Imgspath,'RI_',Imgname);
RITpath = strcat(Imgspath,'RIT_',Imgname);

Beamimg = im2double(imread(Beampath));
maxVAlue= max(max(Beamimg));
NewBeamImg = Beamimg./maxVAlue;

RXval = floor(Rval*imginfo(1).Width);
RYval = floor(Rval*imginfo(1).Height);

for k = 1:num_images;
    disp(['Processing image ',num2str(k),' out of ',num2str(num_images)])
    
    img = im2double(imread(imgpath,k,'Info',imginfo));
    
    % Illumunation Correction
    RIimg = double(imdivide(img,NewBeamImg));
    
    %% Transformation
    
    RITimg = RIimg;
    if ~isequal(Rval,0)
        RITimg = imresize(RITimg,[RXval,RYval],'bilinear');
    end
    
    if ~isequal(Tval,[0,0])
        RITimg = imtranslate(RITimg,Tval,'FillValues',0);
    end  
    
    % Write to file
    imwrite(uint16(65535*RITimg),RITpath,'WriteMode','append','Compression','none');
end

%% Transformation

% copyfile(RIpath,RITpath);
% disp('Copying file...')
% pause(3)
% 
% Xstr = num2str(floor(Rval*imginfo(1).Width));
% Ystr = num2str(floor(Rval*imginfo(1).Height));
% Rstr = num2str(Rval);
% 
% MIJ.start
% MIJ.run('Open...',strcat('path=[',RITpath,']'))
% if ~isequal(Rval,0);
%     MIJ.run('Scale...', ['x=',Rstr,' y=',Rstr,' width=',Xstr,' height=',Ystr,' interpolation=',...
%         'Bilinear average create title=RIT_',Imgname]);
% end
% if ~isequal(Tval,[0,0])
%     MIJ.run('Translate...', ['x=',num2str(Tval(1)),' y=',num2str(Tval(2)),' interpolation=None']);
% end
% MIJ.run('Save','Tiff...')
% MIJ.closeAllWindows
% MIJ.exit

disp('Done')
 end

