
% type mouse and protocal number
mouse = 1;
protocol = 1;

F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

for k = 1:numfiles 
  load(files(k).name)
  multidata(:,:,k) = param.data;
end

for n = 1:numfiles 
    currentdata = multidata(:,:,n);
    
    %%Percent Correct
    [nRow,nCol]=size(currentdata);
    correct = currentdata(:,2)== currentdata(:,3);
    perCor(n) = sum(correct) / nRow;
    
    %Average time
    avgT(n) = sum(currentdata(:,4)) / nRow;
end

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

%%%now that both avgT and perCor have been calculated, we can plot them to
%%%show the progression over time

%put the session number on the x-axis (# of sessions = # of files)
%make 2 "subplots" in one "figure" -- one subplot with perCor on the y-axis and the
%other with avgT on the y-axis