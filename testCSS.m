pList = load('mountain_smooth2.itf');
%figure('NumberTitle','off','Name','raw graph'); 
%plot(pList(:,1),pList(:,2));

sigmalist = [0;4;8;16;32;64;128];
%sigmalist = 0:128;
cornercount = zeros(size(sigmalist));
len = length(sigmalist);
%assume len to be 3*n 
sm_pList = zeros([size(pList),len]);
rows = len/3 + 1;
figure('NumberTitle','off','Name','Curvature Scales');
subplot(rows,3,2); 
plot(pList(:,1),pList(:,2));
[dummy,count] = computeCSS(pList,3);
title('raw graph'); 
cornercount(1) = count;
for i = 2 : length(sigmalist)
    sigma = sigmalist(i);
    sm_pList(:,:,i) = GaussianSmooth(pList,sigma);
    subplot(rows,3,i+2); 
    plot(sm_pList(:,1,i),sm_pList(:,2,i));
    [dummy,count] = computeCSS(sm_pList(:,:,i),2^i+1);
    title(['sigma=',int2str(sigma)]);
    cornercount(i) = count;
end

% plot corner count trend
figure('NumberTitle','off','Name','Corner point count trend');
plot(sigmalist,cornercount,'.');
%for i = 1 :

