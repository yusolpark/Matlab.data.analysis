
% type mouse and protocal number
mouse = [1 2]; %will load files from multiple mice
protocol = 1;

% F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

max_size = [10 4 3]; %add a new dimension for number of mice
multidata = NaN(max_size); 

%%%loop for multiple mice
S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

for k = 1:numfiles 
  load(fullfile(F,files(k).name));
  [nRow,nCol] = size(param.data); 
  multidata(1:nRow,1:nCol,k) = param.data; %add a new dimension for mouse
end
%%%end loop for multiple mice
%size and organization of multidata at this point is [mice=2, trials=10, datatypes=4, experiments=3]

correct = multidata(:,2,:)== multidata(:,3,:); 
%size of correct is [mice=2, trials=10, datatype=1, exps=3]

avgT = nanmean(multidata(:,4,:)); 
perCor = nanmean(correct); 
%size of avgT and perCor is [mice=2 trialavg=1, datatype=1, exps=3]

%%%calculate average of all mice
%size of ___ and ___ is [miceavg=1 trialavg=1, datatype=1, exps=3]

%reshaped mouse averages into 2-D array
perCorP = permute(perCor, [1,3,2]); 
avgTP = permute(avgT, [1,3,2]); 
%size of perCorP and avgTP is [miceavg=1, exps=3] (since the last dimensions=1, they disappear)

%plot data (mouse averages)
s = 1:numfiles;
subplot(2,2,1)
plot(s,perCorP);
xlabel('Session'), ylabel('Percent Correct')
title('Percent Correct')

subplot(2,2,2)
plot(s,avgTP);
xlabel('Session'), ylabel('Average Time')
title('Average Time')