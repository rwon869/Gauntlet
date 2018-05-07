
load('playpensample.mat')

[X,Y] = pol2cart(deg2rad(theta),r);
figure()
% plot(X,Y,'.');
xlim([-3 1]);
ylim([-3 1]);

data = [X Y];
data = data(any(data,2),:);

hold on

% remove extra-similar lines

charges = [];
vecs = [0;0];

[center, radius, n_in, idx] = RANCIRCLE(data, 10000, 0.003, 1);
viscircles(center',radius);
data(idx,:) = [];

plot(data(:,1),data(:,2),'.')

n = size(data,1);
% Attempt to explain 33% of all current lidar data up to 10% at a time
while size(data,1) > n/3
%     minInlierRatio,maxInlierRatio best @ 0.09-0.1 (each line should be
%     somewhere between 9% and 10% of the total unique data points.
    [s2,avpoint,idxs] = RANSAC(data,10000,0.008,0.093,0.095);
%     plot(data(idxs,1),data(idxs,2),'o');
    quiver(avpoint(1), avpoint(2),v(1),v(2),'Color','g')
    quiver(avpoint(1), avpoint(2),-v(1),-v(2),'Color','g')
    inliers = data(idxs,:);
    ridx = round(linspace(1,size(inliers,1),4));
    plot(inliers(ridx,1),inliers(ridx,2),'x');
    data(idxs,:) = [];
    charges = [charges; inliers(ridx,1),inliers(ridx,2);];
end
hold off

hold on
figure()
plot(charges(:,1),charges(:,2),'x');
viscircles(center',radius);
hold off





