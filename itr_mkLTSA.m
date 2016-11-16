% itr_mkLTSA.m
% Iterates over a directory of TPWS files and calls mkLTSAsessions for each
% one.

clearvars
clear global
% setup info - modify to fit your site, species and path
stn = 'GofMX_MP'; % sitename
dpn = '02'; % deployment code
sp = 'De'; % your species code
itnum = 1; % which iteration you are looking for
LTSApath = 'I:\MPmetadata\ltsa\MP01'; % directory containing all LTSAs   for this deployment
tpwsPath = 'I:\MPmetadata\MP01\MP01_TPWS'; %directory of TPWS files



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

% Find all TPWS files that fit your specifications (does not look in subdirectories)
diskList = dir(fullfile(tpwsPath,[stn,dpn,'_*TPWS',num2str(itnum),'.mat']));

% for each TPWS file found, make LTSA.mat file
for iD = 1:length(diskList);
    % if there's any extra info in your file name, between the deployment
    % code and species name (eg. disk number in dolphin detections), parse that out here. 
    extraTextLoc = strfind(diskList(iD).name,dpn)+length(dpn)+1;
    nextUscore = strfind(diskList(iD).name(extraTextLoc:end),'_');
    dsk = diskList(iD).name(extraTextLoc:(extraTextLoc+nextUscore(1)-1));
    
    mkLTSAsessions('stn', stn, 'dpn', dpn, 'disk',dsk,'itnum', num2str(itnum),...
       'sp', sp, 'lpn', LTSApath, 'sdir', tpwsPath)
end