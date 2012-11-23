function [ curvatures,count] = computeCSS( pointList,dim )
%COMPUTECSS compute the Curvature Scale Space of the given pointList
%   pointList a list of points [0,0;1,1]
% the normal approach for computing curvature
fODrvtvX = computeDerivative(1,pointList(:,1));
fODrvtvY = computeDerivative(1,pointList(:,2));
sODrvtvX = computeDerivative(2,pointList(:,1));
sODrvtvY = computeDerivative(2,pointList(:,2));
curvatures = (fODrvtvX.*sODrvtvY - fODrvtvY.*sODrvtvX) ... 
             ./(fODrvtvX.^2 + fODrvtvY.^2).^1.5 ;
         
% the discrete approach for computing curvature
%K = 7;
%curvatures = altCurvature(pointList,K);

%dim = floor(0.03*size(pointList,1));
%if mod(dim,2) == 0
%    dim = dim + 1;
%end

% get Maximas 
% dim = 129;
thresh = 0.005;
maximas = getLocalMaximas(curvatures,dim,thresh);
idxs = find(maximas(:,1) == 1);

% get derivative zero crossings
% maximas = computeDerivative(1,curvatures);
% idxs = find(abs(maximas) <= 0.000001);

count = length(idxs);
%plot(pointList(:,1),pointList(:,2));
hold on;
plot(pointList(idxs,1),pointList(idxs,2),'r.');
end

