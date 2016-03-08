%soilType
%1 - light
%2 - Medium
%3 - Heavy
optSoil = 1;


%rotationalPosition
%1 - first cereal
%2 - second cereal
rotaionalPosition = 1;


if optSoil == 1
    filename = 'RawData/treated/SoilType_Light.csv';
elseif opt == 2
    filename = 'RawData/treated/SoilType_Medium.csv';
elseif opt ==3
    filename = 'RawData/treated/SoilType_Heavy.csv';    
end


%region
%N = North
%W = West
%E = East
region = 'N';


% 
% data sown
% 1 = early - before september
% 2 = mid - 15 sept - 6 october
% 3 = late - after 15 november

dataS = 2;






%%%Read Soils

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

thresholdTrials = 10;

hitThresholdTrials = 2;
hitTopYield = 3;
hitToppcYield = 2;

hitMarket = 10;
missMarket = -10;

hitSeedPeriod = 3;
missSeedPeriod = -3;

numberTopYields = 5; %select top n yields to receive extra vote
numberTopPctYields = 5;

%market
% 1
% 2
% 3
% 4
% 5
market = 1;


global votingTable;

votingTable = zeros(5,41);

%compute votings
marketVoting = zeros(1,41);
seedingPeriodVoting = zeros(1,41);



for i=1:size(Varietiesmarkets,1)
    if market == Varietiesmarkets{i,2}
        marketVoting(1,i) = marketVoting(1,i) + hitMarket;
    else
        marketVoting(1,i) = marketVoting(1,i) + missMarket;
    end    
end



yieldVect = zeros((size(SownPeriod,1)-1)/3,2);
pctYieldVect = zeros((size(SownPeriod,1)-1)/3,2);
yi = 1; %controls de number of line of the yield vector - used later to do the top 5 vote
pyi = 1;% same as above to pct yield



%compute data sown
seedDateVoting = zeros(1,41);
for i=2:size(SownPeriod,1)
    
    measure = SownPeriod{i,1};
       
    varietyName = SownPeriod{i,6};
    varietyIndex = GetVarietyIndex(Varietiesmarkets,varietyName);
    
    yield = strcmp(measure, 'Mean yield (t/ha)');   
    trials = strcmp(measure, 'Number of trials');
    pctYield = strcmp(measure, 'Yield (% control varieties)');
    
    if yield == 1 %assign vote for varieties within the seeding period especified        
        seedingPeriodVoting(1,varietyIndex) =  seedingPeriodVoting(1,varietyIndex) + hitSeedPeriod;  
        %store yield vector
        yieldVect(yi,1) = varietyIndex;
        yieldVect(yi,2) = SownPeriod{i,8};
        yi = yi + 1;
    elseif trials == 1  %assign vote for varieties with trials over threshold
        if SownPeriod{i,8} > thresholdTrials;
            seedingPeriodVoting(1,varietyIndex) = seedingPeriodVoting(1,varietyIndex) + hitThresholdTrials;
        end
    elseif pctYield == 1
        %store %yield vector        
        pctYieldVect(pyi,1) = varietyIndex;
        pctYieldVect(pyi,2) = SownPeriod{i,8};
        pyi = pyi + 1;
    end
    
    
%    hitTop5Yield = 3;
% hitTop5pcYield = 2;
%     
%     seedingPeriodVoting(1,varietyIndex) =+ hitThresholdTrials;


end    
    
%assign vote for top yields    
[sortY,ixY] = sort(yieldVect(:,2),'descend'); %sort vector in descending order
for i=1:numberTopYields
    varietyIndex = yieldVect(ixY(i));
    seedingPeriodVoting(1,varietyIndex) =  seedingPeriodVoting(1,varietyIndex) + hitTopYield; %vote for being in top yields
end


%assign vote for % top yields
[sortY,ixY] = sort(pctYieldVect(:,2),'descend'); %sort vector in descending order
for i=1:numberTopYields
    varietyIndex = yieldVect(ixY(i));
    seedingPeriodVoting(1,varietyIndex) =  seedingPeriodVoting(1,varietyIndex) + hitToppcYield; %vote for being in % top yields
end
    

