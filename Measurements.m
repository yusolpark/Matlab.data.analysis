
% type mouse and protocal number
mouse = [1 2; 3 4]; %each row of mice is a different group
protocol = 1;

F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
% F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

[lg, lm] = size(mouse); %now there are 2 dimensions: number of groups and number of mice per group
max_size = [lg lm 10 4 3]; 
multidata = NaN(max_size); 

for g = 1:lg
    for m = 1:lm
    S = sprintf('* Mouse%03d Protocol%d *.mat', mouse(g,m), protocol);
    files = dir(fullfile(F,S));
    numfiles = length(files);
    
        for k = 1:numfiles 
            load(fullfile(F,files(k).name));
            [nRow,nCol] = size(param.data); 
            multidata(g,m,1:nRow,1:nCol,k) = param.data; 
        end
    end 
end 

%size and organization of multidata at this point is [groups=2, mice=2, trials=10, datatypes=4, experiments=3]

correct = multidata(:,:,:,2,:)== multidata(:,:,:,3,:); 
%size of correct is [groups=2, mice=2, trials=10, datatype=1, exps=3]

avgT = nanmean(multidata(:,:,:,4,:),3);
perCor = nanmean(correct,3);

%%%calculate average of all mice
allavg = nanmean(avgT);
allper = nanmean(perCor); 
%size of allavg and allper is [groups=2, miceavg=1, trialavg=1, datatype=1, exps=3]

%reshaped mouse averages into 2-D array
avgTP = reshape(permute(allavg, [1,5,2,3,4]),2,3);
perCorP = reshape(permute(allper, [1,5,2,3,4]),2,3); 
%size of perCorP and avgTP is [groups=2, exps=3] (all dimensions at the ending equaling 1 (aka "singleton" dimensions) will disappear)


%plot data (group averages)
s = 1:numfiles;
subplot(2,2,1)
plot(s,perCorP(1,:),'-g'); %%%plot group 1
hold on %this will prevent the previous plot from being overwritten
plot(s,perCorP(2,:),'-r'); %%%plot group 2
xlim([1 3])
ylim([0 1])
xlabel('Session'), ylabel('Percent Correct')
title('Percent Correct')

%%%make the same changes as above with this plot
subplot(2,2,2)
plot(s,avgTP(1,:),'-g'); %%%plot group 1
hold on %this will prevent the previous plot from being overwritten
plot(s,avgTP(2,:),'-r'); %%%plot group 2 

xlabel('Session'), ylabel('Average Time')
title('Average Time')
xlim([1 3])
ylim([0 30])
