
% type mouse and protocal number
mouse = 1;
protocol = 1;

% F = '/Users/yusolpark/Desktop/Matlab.data.analysis';
F = 'C:\Users\Matthew\Documents\Schaffer-Nishimura Lab\ROArena\Data\dummydata'; %Matt's save location

S = sprintf('* Mouse%03d Protocol%d *.mat', mouse, protocol);
files = dir(fullfile(F,S));
numfiles = length(files);

for k = 1:numfiles 
  load(fullfile(F,files(k).name));
  multidata(:,:,k) = param.data;
end


% for n = 1:numfiles %%%%remove this loop
%     currentdata = multidata(:,:,n); %old line
    
    %%Percent Correct
%     [nRow,nCol]=size(currentdata); %old line
    [nRow,nCol,~] = size(multidata); %new line works directly on multidata
    
%     correct = currentdata(:,2)== currentdata(:,3); old line
    correct = multidata(:,2,:)== multidata(:,3,:); %new line (finds correct choices, keeps 3D shape of multidata)
    
%     perCor(n) = sum(correct) / nRow; %old line
    %correct is now 3D, with the correct choices in the 1st dimension and
    %the number of files on the 3rd dimension
    perCor = sum(correct) / nRow; %sum adds along the 1st dimension by default, which is what we want
    
    %Average time
%     avgT(n) = sum(currentdata(:,4)) / nRow; %old line
    %avgT is now 3D as well
    avgT = sum(multidata(:,4,:)) / nRow;
    
    %%%%at this point perCor and avgT should still be 3 dimensional, of 
    %%%%the size [1 1 numfiles]. To get them to a size [1 numfiles 1] 
    %%%%which is the shape they're expected to be for the next plotting 
    %%lines (the plot function doesn't work with data > 2 dimensions),
    %%%check out the "permute" function and use it on the next line
    
% end %%%%remove this loop


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