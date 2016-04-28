function [ voteFactor ] = voting( matFactor, posValues, posVarName, hitFactor, missFactor, hitThresholdTrials, hitTopYield, hitToppcYield)
%VOTING Summary of this function goes here

global Varietiesmarkets

thresholdTrials = 10; %over this reveice extra vote 
numberTopYields = 3; %select top n yields to receive extra vote
numberTopPctYields = 3;

voteFactor = zeros(1,41);

yieldVect = zeros((size(matFactor,1)-1)/3,2);
pctYieldVect = zeros((size(matFactor,1)-1)/3,2);
yi = 1; %controls de number of line of the yield vector - used later to do the top 5 vote
pyi = 1;% same as above to pct yield

for i=2:size(matFactor,1)
    
    measure = matFactor{i,1};
       
    varietyName = matFactor{i,posVarName};
    varietyIndex = GetVarietyIndex(Varietiesmarkets,varietyName);
    
    yield = strcmp(measure, 'Mean yield (t/ha)');   
    trials = strcmp(measure, 'Number of trials');
    pctYield = strcmp(measure, 'Yield (% control varieties)');
    
    if yield == 1       
        %voteFactor(1,varietyIndex) =  voteFactor(1,varietyIndex) + hitFactor;  
        voteFactor(1,varietyIndex) =  voteFactor(1,varietyIndex) + matFactor{i,posValues} * hitFactor;
        %store yield vector
        yieldVect(yi,1) = varietyIndex;
        yieldVect(yi,2) = matFactor{i,posValues};
        yi = yi + 1;
    elseif trials == 1  %assign vote for varieties with trials over threshold
        if matFactor{i,posValues} > thresholdTrials;
            voteFactor(1,varietyIndex) = voteFactor(1,varietyIndex) + hitThresholdTrials;
        end
    elseif pctYield == 1
        %store %yield vector        
        pctYieldVect(pyi,1) = varietyIndex;
        pctYieldVect(pyi,2) = matFactor{i,posValues};
        pyi = pyi + 1;
    end

end    
    
% %assign vote for top yields    - excluded because logic it is done already in
% %yields and yield is evaluated in upper if clause
% [sortY,ixY] = sort(yieldVect(:,2),'descend'); %sort vector in descending order
% for i=1:numberTopYields
%     varietyIndex = yieldVect(ixY(i));
%     %a = voteFactor(1,varietyIndex);
%     voteFactor(1,varietyIndex) =  voteFactor(1,varietyIndex) + hitTopYield; %vote for being in top yields
% end


%assign vote for % top yields
[sortY,ixY] = sort(pctYieldVect(:,2),'descend'); %sort vector in descending order
for i=1:numberTopPctYields
    varietyIndex = yieldVect(ixY(i));
   % b= voteFactor(1,varietyIndex);
    voteFactor(1,varietyIndex) =  voteFactor(1,varietyIndex) + hitToppcYield; %vote for being in % top yields
end



end

