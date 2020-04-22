
% type mouse and protocal number
mouse = 1;
protocol = 1;

F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
% F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);


%%%Hover over multidata, and matlab suggests that you should pre-allocate
%%%space for this variable since it increases size with every loop (forcing
%%%matlab to recreate the variable into a bigger memory location each time, 
%%%which slows it down). Using the max_size values I typed in, set multidata 
%%%to be an array of that size filled with "NaN" values. (hint: "help nan")

max_size = [10 4 numfiles]; %This is how big the array should be to hold all the data
%multidata = ??? (change this line to pre-allocate space for multidata)
for k = 1:numfiles 
  load(fullfile(F,files(k).name));
  [nRow,nCol] = size(param.data); 
  multidata(1:nRow,1:nCol,k) = param.data; %matlab's suggestion will disappear when you're done
end
%size and organization of multidata at this point is [trials=10, datatypes=4, experiments=3]

[nRow,nCol,~] = size(multidata); 
correct = multidata(:,2,:)== multidata(:,3,:); 
%size of correct is [trials=10, datatype=1, exps=3]


%%%Instead of calculating the average by sum()/N, use matlab's "mean"
%%%function, using 'omitnan' to ignore "nan" values in the array.
%%%This way, the calculated average wont be messed up if different
%%%experiments have different numbers of trials (nRow will be the same for
%%%all exps even if they have different numbers of trials)

avgT = sum(multidata(:,4,:)) / nRow; %use "mean" function
perCor = sum(correct) / nRow; %use "mean" function
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