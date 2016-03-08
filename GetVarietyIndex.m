function [ varietyIndex ] = GetVarietyIndex(Varietiesmarkets, varietyName )
%get variety index on varietiesmarkets table

for i=1:size(Varietiesmarkets,1)    
    c = strcmp(char(Varietiesmarkets(i,1)),varietyName);
    if c == 1
        varietyIndex = Varietiesmarkets{i,3};
        return
    end    
end

end

