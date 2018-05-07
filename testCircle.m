
load('playpensample.mat')

[x,y] = pol2cart(deg2rad(theta),r);
plot(x,y,'.')

data = [x y];
data = data(any(data,2),:);

[center, radius, n_in] = RANCIRCLE(data, 10000, 0.005,0.10,0.11);
viscircles(center', radius);