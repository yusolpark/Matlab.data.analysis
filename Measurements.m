
% type mouse and protocal number
mouse = 1;
protocol = 1;

 F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
%F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

for k = 1:numfiles 
  load(fullfile(F,files(k).name));
  multidata(:,:,k) = param.data;
end


    [nRow,nCol,~] = size(multidata); 
    
    correct = multidata(:,2,:)== multidata(:,3,:); 
    
    perCor = sum(correct) / nRow; 
    
    %Average time
    avgT = sum(multidata(:,4,:)) / nRow;
    
    perCorP = permute(perCor, [1,3,2]);
    avgTP = permute(avgT, [1,3,2]);
 

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