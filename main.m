%%%read agronomic factors
%% Initialize variables.
filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/agronomicalFactorsList.csv';
delimiter = ',';

%% Format string for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
dataArray([2, 3]) = cellfun(@(x) num2cell(x), dataArray([2, 3]), 'UniformOutput', false);
agronomicalFactorsList = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;
%%%end reading agronomic factors - read this one first to include weights
%%%of user selection in the following second gui



[handles, market, optSoil, dataS, rotaionalPosition, region, district]= VarietySelection1();


[handles2, resLodNoPgr, resLodYesPgr, yelRust, septTric, septNod, oraWBlMi, mildew, fusEaBli, eyespot, broRust, ripDays, height] = VarietySelection2();

%this code is not dynamic
agronomicalFactorsList{1,4} = ripDays;
agronomicalFactorsList{2,4} = resLodNoPgr;
agronomicalFactorsList{3,4} = resLodYesPgr;
agronomicalFactorsList{4,4} = height;
agronomicalFactorsList{5,4} = yelRust;
agronomicalFactorsList{6,4} = septTric;
agronomicalFactorsList{7,4} = septNod;
agronomicalFactorsList{8,4} = oraWBlMi;
agronomicalFactorsList{9,4} = mildew;
agronomicalFactorsList{10,4} = fusEaBli;
agronomicalFactorsList{11,4} = eyespot;
agronomicalFactorsList{12,4} = broRust;



% Parameters
load('/home/phd/Documents/Matlab/varietySelection/RawData/treated/parameters.mat');

%site specific -based on yield results of trials
hitMarket = param(1);
missMarket = param(2);
hitThresholdTrials = param(3);
hitToppcYield = param(4);

wSeedPeriod = param(5);
wSoilType = param(6);
wRotPosi = param(7);
wDistrict = param(8);
wRegion = param(9);
nSelVar = param(10);

wSiteSpec = param(11);
wAgrParam = param(12);

% hitThresholdTrials = 2;
hitTopYield = 5; %not used anymore
% hitToppcYield = 5;
% 
% hitMarket = 15;
% missMarket = -15;
% wSeedPeriod = 3;
% wRegion = 2;
% wDistrict = 3;
% wSoilType = 4;
% wRotPosi = 3;
% %%site specific -based on yield results of trials
% 
% %weights
% wSiteSpec = 0.5;
% wAgrParam = 0.5;
% 
% 
 hit = 3; %general hit -not used anymore
 miss =3; %general hit - not used anymore
% 
% 
% nSelVar = 10; %compute Top N varieties selected for next phase - agronomical voting
% 

global Varietiesmarkets



%%%Read Soils

if optSoil == 1
    filename = 'RawData/treated/SoilType_Light.csv';
elseif optSoil == 2
    filename = 'RawData/treated/SoilType_Medium.csv';
elseif optSoil ==3
    filename = 'RawData/treated/SoilType_Heavy.csv';    
end

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/phd/Documents/Matlab/RawData/treated/SoilType_Heavy.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/03/06 19:46:19

%% Initialize variables.
%filename = '/home/phd/Documents/Matlab/RawData/treated/SoilType_Heavy.csv';
delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%*s%*s%*s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[4,5,7,8]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [4,5,7,8]);
rawCellColumns = raw(:, [1,2,3,6]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
SoilType = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%%% end read soils




%%%read varieties and markets
%% Initialize variables.
filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/Varieties_markets.csv';
delimiter = ',';

%% Format string for each line of text:
%   column1: text (%s)
%	column2: double (%f)
%   column3: double (%f)
% For more information, see the TEXTSCAN documentation.
formatSpec = '%s%f%f%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Post processing for unimportable data.
% No unimportable data rules were applied during the import, so no post
% processing code is included. To generate code which works for
% unimportable data, select unimportable cells in a file and regenerate the
% script.

%% Create output variable
dataArray([2, 3]) = cellfun(@(x) num2cell(x), dataArray([2, 3]), 'UniformOutput', false);
Varietiesmarkets = [dataArray{1:end-1}];
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans;
%%%end read varieties market






%%% read cereal position

if rotaionalPosition == 1
    filename = 'RawData/treated/RotationalPosition_1stcereal.csv';    
elseif rotaionalPosition == 2
    filename = 'RawData/treated/RotationalPosition_2ndcereal.csv';
end

%% Import data from text file.
% Script for importing data from the following text file:
%
%    /home/phd/Documents/Matlab/RawData/treated/RotationalPosition_1stcereal.csv
%
% To extend the code to different selected data or a different text file,
% generate a function instead of a script.

% Auto-generated by MATLAB on 2016/03/06 20:26:15

%% Initialize variables.

delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%s%*s%s%*s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[3,5,6,8,9]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [3,5,6,8,9]);
rawCellColumns = raw(:, [1,2,4,7]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
RotationalPosition = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%end rotational position




%%%read region
if region == 'N'
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/Region_North_UK.csv';
elseif region == 'W'
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/Region_West_UK.csv';
elseif region == 'E'
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/Region_East_UK.csv';
end


%% Initialize variables.

delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%*s%s%s%s%s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[6,7,9,10]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [6,7,9,10]);
rawCellColumns = raw(:, [1,2,3,4,5,8]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
Region = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%%% end region reading




%%%read seed date

if dataS == 1
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/SownEarly_bf15Sept.csv';
elseif dataS ==2
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/SownMid_15sept-6Oct.csv';
elseif dataS ==3
    filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/SownLate_aft15Nov.csv';
end


%% Initialize variables.

delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%*s%s%s%*s%*s%s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[4,5,7,8]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [4,5,7,8]);
rawCellColumns = raw(:, [1,2,3,6]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
SownPeriod = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%%%end seed period reading


district;


%%% reads districts

%% Initialize variables.
a = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/District_';
b = strcat(district, '.csv');

filename =  strcat(a,b);
delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%*s%*s%s%*s%*s%*s%s%s%s%*s%s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[5,7,8]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [5,7,8]);
rawCellColumns = raw(:, [1,2,3,4,6]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
District = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%%end districts reading




%import agronomical factors
%% Initialize variables.
filename = '/home/phd/Documents/Matlab/varietySelection/RawData/treated/alternative_data_table_data.csv';
delimiter = ',';

%% Read columns of data as strings:
% For more information, see the TEXTSCAN documentation.
formatSpec = '%*s%s%s%*s%*s%s%s%s%[^\n\r]';

%% Open the text file.
fileID = fopen(filename,'r');

%% Read columns of data according to format string.
% This call is based on the structure of the file used to generate this
% code. If an error occurs for a different file, try regenerating the code
% from the Import Tool.
dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter,  'ReturnOnError', false);

%% Close the text file.
fclose(fileID);

%% Convert the contents of columns containing numeric strings to numbers.
% Replace non-numeric strings with NaN.
raw = repmat({''},length(dataArray{1}),length(dataArray)-1);
for col=1:length(dataArray)-1
    raw(1:length(dataArray{col}),col) = dataArray{col};
end
numericData = NaN(size(dataArray{1},1),size(dataArray,2));

for col=[3,5]
    % Converts strings in the input cell array to numbers. Replaced non-numeric
    % strings with NaN.
    rawData = dataArray{col};
    for row=1:size(rawData, 1);
        % Create a regular expression to detect and remove non-numeric prefixes and
        % suffixes.
        regexstr = '(?<prefix>.*?)(?<numbers>([-]*(\d+[\,]*)+[\.]{0,1}\d*[eEdD]{0,1}[-+]*\d*[i]{0,1})|([-]*(\d+[\,]*)*[\.]{1,1}\d+[eEdD]{0,1}[-+]*\d*[i]{0,1}))(?<suffix>.*)';
        try
            result = regexp(rawData{row}, regexstr, 'names');
            numbers = result.numbers;
            
            % Detected commas in non-thousand locations.
            invalidThousandsSeparator = false;
            if any(numbers==',');
                thousandsRegExp = '^\d+?(\,\d{3})*\.{0,1}\d*$';
                if isempty(regexp(thousandsRegExp, ',', 'once'));
                    numbers = NaN;
                    invalidThousandsSeparator = true;
                end
            end
            % Convert numeric strings to numbers.
            if ~invalidThousandsSeparator;
                numbers = textscan(strrep(numbers, ',', ''), '%f');
                numericData(row, col) = numbers{1};
                raw{row, col} = numbers{1};
            end
        catch me
        end
    end
end

%% Split data into numeric and cell columns.
rawNumericColumns = raw(:, [3,5]);
rawCellColumns = raw(:, [1,2,4]);


%% Replace non-numeric cells with NaN
R = cellfun(@(x) ~isnumeric(x) && ~islogical(x),rawNumericColumns); % Find non-numeric cells
rawNumericColumns(R) = {NaN}; % Replace non-numeric cells

%% Create output variable
agronomicalFactors = raw;
%% Clear temporary variables
clearvars filename delimiter formatSpec fileID dataArray ans raw col numericData rawData row regexstr result numbers invalidThousandsSeparator thousandsRegExp me rawNumericColumns rawCellColumns R;
%end reading agronomical factors
%%%%END READING



%start voting procedure
votingTable = zeros(6,41);

%compute market votings
marketVoting = zeros(1,41);
seedingPeriodVoting = zeros(1,41);

for i=1:size(Varietiesmarkets,1)
    if market == Varietiesmarkets{i,2}
        marketVoting(1,i) = marketVoting(1,i) + hitMarket;
    else
        marketVoting(1,i) = marketVoting(1,i) + missMarket;
    end    
end

%miss penalty is just used in markek, voting of other site specific do not
%need miss parameters
%[ voteFactor ] = voting( matFactor, posValues, posVarName, hitFactor, missFactor, hitThresholdTrials, hitTopYield, hitToppcYield);

%seeding period
[ seedingVotes ] = voting(SownPeriod, 8, 6, wSeedPeriod, miss, hitThresholdTrials, hitTopYield, hitToppcYield);

%soilType
[ soilVotes ] = voting(SoilType, 8, 6, wSoilType, miss, hitThresholdTrials, hitTopYield, hitToppcYield);

%RotationalPosition
[ rotationalPosVotes ] = voting(RotationalPosition, 9, 7, wRotPosi, miss, hitThresholdTrials, hitTopYield, hitToppcYield);

%Region
[ regionVotes ] = voting(Region, 10, 8, wRegion, -5, hitThresholdTrials, hitTopYield, hitToppcYield);

%district
[ districtVotes ] = voting(District, 8, 6, wDistrict, -5, hitThresholdTrials, hitTopYield, hitToppcYield);


%allocate votes on voting table
votingTable(1,1:41) = marketVoting;
votingTable(2,1:41) = seedingVotes;
votingTable(3,1:41) = soilVotes;
votingTable(4,1:41) = rotationalPosVotes;
votingTable(5,1:41) = regionVotes;
votingTable(6,1:41) = districtVotes;

votesVar = sum(votingTable);



global selVarIndex;
selVarIndex = zeros(nSelVar,2);

[sortVar,ixV] = sort(votesVar,'descend'); %sort vector in descending order
for i=1:nSelVar
    selVarIndex(i,1) = ixV(1,i); %subset of selected varieties 
    selVarIndex(i,2) = sortVar(1,i); 
end


 %CLEAR VARIABLES 
clear Region RotationalPosition SoilType SownPeriod 


%agronomic weights are choosen on the second gui. The values are multiplied
%by the matching variety's agronomic performance  

nAgFac = size(agronomicalFactorsList,1); 
nVar = size(selVarIndex,1);
votingAgronomic = zeros(nVar, nAgFac);
m = 0; %controls line number of ag voting

for i=1:nVar
    ltVarName = regexprep(Varietiesmarkets{selVarIndex(i,1),1},'[^\w'']',''); %name whithout spaces or special char
    m = m+1;
    for j=2:size(agronomicalFactors,1) %goes through ag factors data table        
        tbVarName = regexprep(agronomicalFactors{j,4},'[^\w'']','');
        
        cmp = strcmp(tbVarName,ltVarName);  %compare variety of subset with the agronomic factor data in line
        if cmp ==1
            factorName = agronomicalFactors{j,1};
            
            for k=1:size(agronomicalFactorsList,1)             
                cmp2 = strcmp(factorName,agronomicalFactorsList{k,1}); %compare actual factor with the trials data
                
                if cmp2 == 1
                    category = agronomicalFactorsList{k,3};
                    
                    if category == 1 %(1-9)  
                        votingAgronomic(m,agronomicalFactorsList{k,2}) = agronomicalFactors{j,5} * (agronomicalFactorsList{k,4}/5); %multiply for measured factor                          
                    
                    elseif category == 2 %1 or 0 
                        votingAgronomic(m,agronomicalFactorsList{k,2}) = ( ((agronomicalFactors{j,5} + 8) * agronomicalFactors{j,5})  * agronomicalFactorsList{k,4}/5); % 0+8*0*importance=0 or 1+8*1*importance = >0; takes maaximum or minimum importance                         
%                         a1 = agronomicalFactors{j,5};
%                         b1 = agronomicalFactorsList{k,4}/5;
%                         c1 = votingAgronomic(m,agronomicalFactorsList{k,2});
                        
                    elseif category == 3 %ripening days                        
                        if agronomicalFactorsList{k,4} == 1
                            
                        elseif agronomicalFactorsList{k,4} == 2 %(-1-0)
                            if agronomicalFactors{j,5} == -1 || agronomicalFactors{j,5} == 0
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit
                            end
                        elseif agronomicalFactorsList{k,4} == 3 %(1-2)
                            if agronomicalFactors{j,5} == 1 || agronomicalFactors{j,5} == 2
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit
                            end
                        elseif agronomicalFactorsList{k,4} == 4 %(2-3)
                            if agronomicalFactors{j,5} == 2 || agronomicalFactors{j,5} == 3
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit
                            end
                        elseif agronomicalFactorsList{k,4} == 5 %(3-5)
                            if agronomicalFactors{j,5} > 3
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit
                            end
                        end                       
                        
                    elseif category == 4 %height
                        if agronomicalFactorsList{k,4} == 1
                        
                        elseif agronomicalFactorsList{k,4} == 2 %(72-77)
                            if agronomicalFactors{j,5} < 78
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit                                
                            end                            
                        elseif agronomicalFactorsList{k,4} == 3 %(78-82)
                            if agronomicalFactors{j,5} > 77 && agronomicalFactors{j,5} < 83
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit                                
                            end
                        elseif agronomicalFactorsList{k,4} == 4 %(82-86)
                            if agronomicalFactors{j,5} > 82 && agronomicalFactors{j,5} < 87
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit                                
                            end 
                        elseif agronomicalFactorsList{k,4} == 5 %(87-91+)
                            if agronomicalFactors{j,5} > 86 
                                votingAgronomic(m,agronomicalFactorsList{k,2}) = 9/2 * 5/5; %half of maximum hit                                
                            end 
                        end                    
                    end
                end
            end
        end
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%normalize site-specific
minv = min(selVarIndex(:,2));
maxv = max(selVarIndex(:,2));

if ((maxv - minv) > 0)
   SiteSpecV = (selVarIndex(:,2) - minv)/(maxv - minv);   
else
    SiteSpecV = 1;
end

%normalize agronomic factors
av = sum(votingAgronomic,2);

minv = min(av);
maxv = max(av);

if maxv - minv > 0
   agFacV = (av(:) - minv)/(maxv - minv);   
else
    agFacV = 1;
end

%sum
selVarIndex(:,2) = ((SiteSpecV + agFacV)/2)*100;


[sortVar,ixV] = sort(selVarIndex,'descend');

%create cell array to display on gui3
Nmax = nSelVar;

global resumeVotes;

resumeVotes = cell(Nmax,4);

ix = selVarIndex(ixV(:,2),1);
votes = selVarIndex(ixV(:,2),2);

for i=1:Nmax
     resumeVotes{i,1} = ix(i);%index
     resumeVotes{i,2} = char(Varietiesmarkets(ix(i),1));
     resumeVotes{i,3} = votes(i);     
     resumeVotes{i,4} = Varietiesmarkets{ix(i),2};
end

 VarietySelection3();
 
 
 
 