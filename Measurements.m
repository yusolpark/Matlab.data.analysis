%%%change the method for getting a list of files so that it searches for
%%%all files of a particular mouse and protocol that is defined at the top

% mouse = 1; %needs to be converted to 001 (i.e. to a "field width" of 3)
% protocol = 1;
%
% functions you might want to look into: "strcat", "num2str" or "sprintf"
files = dir('TrainingResults Mouse001 Protocol1 20-03-2* 12-00-00.mat');
numfiles = length(files);

for k = 1:numfiles 
  load(files(k).name)
  multidata(:,:,k) = param.data;
end

for n = 1:numfiles 
    currentdata = multidata(:,:,n);
    
    %%Percent Correct
    correct=0;
    [nRow,nCol]=size(currentdata);
    
    
    %%%"for loops" are a nice way to repeat code or calculations multiple 
    %%%times, but they can be significantly slower than non-loop methods. 
    %%%Professional programmers try to avoid loops wherever possible so 
    %%%that there code doesn't slow down, even when it gets long. Try 
    %%%getting perCor = [0.6 0.7 0.9] without using this next for loop:
    
    %hint: currentdata(:,2) includes all correct positions
    %      curentdata(:,3) includes all chosen positions
    %      ??? = currentdata(:,2)==curentdata(:,3)
    for r = 1:nRow
        if currentdata(r,2)== currentdata(r,3)
            correct = correct + 1;    
        end
    end
    perCor(n) = correct / nRow;
    
    %Average time
    avgT(n) = sum(currentdata(:,4)) / nRow;
end


%%%now that both avgT and perCor have been calculated, we can plot them to
%%%show the progression over time

%put the session number on the x-axis (# of sessions = # of files)
%make 2 "subplots" in one "figure" -- one subplot with perCor on the y-axis and the
%other with avgT on the y-axis