
% type mouse and protocal number
mouse = 1;
protocol = 1;

%F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
 F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

max_size = [10 4 numfiles]; %This is how big the array should be to hold all the data
multidata = NaN(max_size); 

for k = 1:numfiles 
  load(fullfile(F,files(k).name));
  [nRow,nCol] = size(param.data); 
  multidata(1:nRow,1:nCol,k) = param.data; 
end
%size and organization of multidata at this point is [trials=10, datatypes=4, experiments=3]

[nRow,nCol,~] = size(multidata); 
correct = multidata(:,2,:)== multidata(:,3,:); 
%size of correct is [trials=10, datatype=1, exps=3]


avgT = nanmean(multidata(:,4,:)); 
perCor = nanmean(correct); 
%size of avgT and perCor is [trialavg=1, datatype=1, exps=3]

%reshaped into 2-D array
perCorP = permute(perCor, [1,3,2]); 
avgTP = permute(avgT, [1,3,2]); 
%size of perCorP and avgTP is [trialavg=1, exps=3] (since the last dimension=1, it disappears)

%plot data 
s = 1:numfiles;
subplot(2,2,1)
plot(s,perCorP);
xlabel('Session'), ylabel('Percent Correct')
title('Percent Correct')

subplot(2,2,2)
plot(s,avgTP);
xlabel('Session'), ylabel('Average Time')
title('Average Time')