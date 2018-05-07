% testDriving the Gauntlet

load('playpensample.mat')

% Processing the data
[X,Y] = pol2cart(deg2rad(theta),r);
data = [X Y];
data = clean(data);

% Getting lines and detected circle
[charges, r, center] = extractFeatures(data);

hold on
plot(charges(:,1),charges(:,2),'x');
viscircles(center',r);
hold off

% Get artificial potential vector field and gradient path to circle
[x,y,F] = genField(charges, r, center, 25);
[gx, gy] = gradient(F);

% Visualize data
figure()
hold on
contour(x,y,F)
quiver(x,y,-gx,-gy)
streamline(x,y,-gx,-gy,-2,-1.5)
hold off

