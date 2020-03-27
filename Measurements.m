files = dir('TrainingResults Mouse001 Protocol1 20-03-2* 12-00-00.mat');
numfiles = length (files);

for k = 1:numfiles 
  load(files(k).name)
  multidata(:,:,k) = param.data;
end

for n = 1:numfiles 
    currentdata = multidata(:,:,n);
    
    %%Percent Correct
    correct=0;
    [nRow,nCol]=size(currentdata);

    for r = 1:nRow
        if currentdata(r,2)== currentdata(r,3)
            correct = correct + 1;    
        end
    end
    perCor(n) = correct / nRow;
    
    %Average time
    avgT(n) = sum(currentdata(:,4)) / nRow;
end