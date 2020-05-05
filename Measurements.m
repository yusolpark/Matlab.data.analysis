
% type mouse and protocal number
mouse = [1 2; 3 4]; %each row of mice is a different group
protocol = 1;

F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
% F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

[lg, lm] = size(mouse); %now there are 2 dimensions: number of groups and number of mice per group
max_size = [lg lm 10 4 3]; %I added a new dimension for number of mice groups
multidata = NaN(max_size); 

%%%add another loop for multiple groups
for m = 1:l
    S = sprintf('* Mouse%03d Protocol%d *.mat', mouse(m), protocol);
    files = dir(fullfile(F,S));
    numfiles = length(files);
    
    for k = 1:numfiles 
        load(fullfile(F,files(k).name));
        [nRow,nCol] = size(param.data); 
        multidata(m,1:nRow,1:nCol,k) = param.data; %%%add a new dimension for group
    end
end 
%%%end loop for multiple mice
%size and organization of multidata at this point is [groups=2, mice=2, trials=10, datatypes=4, experiments=3]

correct = multidata(:,:,2,:)== multidata(:,:,3,:); %%%change this to accomadate groups
%size of correct is [groups=2, mice=2, trials=10, datatype=1, exps=3]

avgT = nanmean(multidata(:,:,4,:),2); %%%change this to accomadate groups
perCor = nanmean(correct,2); %%%change this accomadate groups (take mean across trial dimension)
%size of avgT and perCor is [groups=2, mice=2, trialavg=1, datatype=1, exps=3]

%%%calculate average of all mice
allavg = nanmean(avgT); %%%change this to accomadate groups
allper = nanmean(perCor); %%%change this to accomadate groups
%size of allavg and allper is [groups=2, miceavg=1, trialavg=1, datatype=1, exps=3]

%reshaped mouse averages into 2-D array
avgTP = permute(allavg, [1,4,3,2]);%%%change this to accomadate groups
perCorP = permute(allper, [1,4,3,2]); %%%change this to accomadate groups
%size of perCorP and avgTP is [groups=2, exps=3] (all dimensions at the ending equaling 1 (aka "singleton" dimensions) will disappear)

%plot data (group averages)
s = 1:numfiles;
subplot(2,2,1)
plot(s,perCorP); %%%change this to only plot group 1
hold on %this will prevent the previous plot from being overwritten
plot(s,perCorP); %%%change this to plot group 2 in a different color
xlabel('Session'), ylabel('Percent Correct')
title('Percent Correct')

%%%make the same changes as above with this plot
subplot(2,2,2)
plot(s,avgTP);
xlabel('Session'), ylabel('Average Time')
title('Average Time')
