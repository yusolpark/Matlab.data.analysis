
% type mouse and protocal number
mouse = 1;
protocol = 1;

F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
% F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

for k = 1:numfiles 
  load(files(k).name)
  multidata(:,:,k) = param.data;
end


%%%%Come up with a non-loop method to calculate perCor and avgT
%%%% not only will this speed up the script, but it will make it easier to
%%%% process data from multiple mice (and eventually multiple mice groups)
for n = 1:numfiles %%%%remove this loop
    currentdata = multidata(:,:,n);
    
    %%Percent Correct
    [nRow,nCol]=size(currentdata);
    
    %%%%try this: correct = multidata(:,2,:)== multidata(:,3,:);
    correct = currentdata(:,2)== currentdata(:,3);
    
    %%%%look up the "mean" function to replace "sum/nRow"
    perCor(n) = sum(correct) / nRow;
    
    %Average time
    avgT(n) = sum(currentdata(:,4)) / nRow;
    
    %%%%at this point perCor and avgT should still be 3 dimensional, of 
    %%%%the size [1 1 numfiles]. To get them to a size [1 numfiles 1],  
    %%%%check out the "permute" function
    
end %%%%remove this loop


%plot data 
s = 1 : numfiles;
subplot(2,2,1)
plot(s,perCor);
xlabel('Session'), ylabel('Percent Correct')
title('Percent Correct')

subplot(2,2,2)
plot(s,avgT);
xlabel('Session'), ylabel('Average Time')
title('Average Time')