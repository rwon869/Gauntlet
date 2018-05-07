figure()
hold on
plot(charges(:,1),charges(:,2),'x');
viscircles(center',r);
hold off

figure()
[x,y] = meshgrid(-3:0.1:3,-3:0.1:3);

F = log(sqrt((x-center(1)).^2+(y-center(2)).^2+2.*r.^2));

for i = 1:size(charges,1)
    point = charges(i,:);
    F = F - real(log( sqrt((x-point(1)).^2 + (y-point(2)).^2 ) ))./50;
end

[px,py] = gradient(F);
surf(x,y,F)
xlim([-3 1])

figure()
hold on
contour(x,y,F)
quiver(x,y,-px,-py)
hold off