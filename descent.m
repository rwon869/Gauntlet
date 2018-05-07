% connect('192.168.16.62');

% Describe space with meshgrid
% [x,y] = meshgrid(0:0.1:10,0:0.1:10);

syms x
syms y
    
% Weight bucket location by depressing outline of bucket on surface logarithmically
Ft = log(sqrt((x-7).^2+(y-4.5).^2+(0.11).^2))*10;
obstacles = [2,3; 4,4.5; 5.5,2;];

figure()
hold on
plot(obstacles(:,1), obstacles(:,2), 'o');
viscircles([7 4.5], 0.5);
axis('equal')
xlim([0 10])


for i = 1:size(obstacles,1)
    point = obstacles(i,:);
    Ft = Ft - real(log( sqrt((x-point(1)).^2 + (y-point(2)).^2 ) ))./2;
end

% [px,py] = gradient(Ft);
% contour(x,y,Ft)
% stream = streamline(x,y,-px,-py,0,4.5)


% Need the gradient value at a given point 
d = 0.24;
gg = gradient(Ft,[x,y])
x = 0
y = 0
th = 0
VL = [];
VR = [];
lambda = 0.1;

pub = rospublisher('/raw_vel');
msg = rosmessage(pub);

while sqrt(x.^2+y^2) < 6
    point = round(double(-subs(gg)));
    quiver(x,y,point(1),point(2))
    mag = (sqrt(point(1).^2+point(2).^2));
    theta = atan2(point(2), point(1))-th;
    dt = 1;
    w = (theta./mag);
        
    
%     STOP
    msg.Data = [0, 0];
    msg.Data = toSend;
    send(pub, msg);
    pause(1)
    
%     GO
%     VLs = 1./(mag.*2.7);
%     VRs = 1./(mag.*2.7);
%     [double(VLs), double(VRs)]
%     if double(VLs) > 0.3
%         VLs = 0.3;
%         VLR = 0.3;
%     end
%     toSend = [double(VLs), double(VRs)]
%     msg = rosmessage(pub);
%     send(pub, msg);
%     pause(0.3)
%     
% %     STOP
%     msg.Data = [0, 0];
%     msg.Data = toSend;
%     send(pub, msg);
%     pause(0.3)
%     
% %     TURN
%     VLs = - w.*(d/2);
%     VRs = w.*(d/2);
%     double(w)
%     toSend = [double(VLs), double(VRs)];
%     msg = rosmessage(pub);
%     send(pub, msg);
%     pause(0.3)
    
    x = x+point(1);
    y = y+point(2);
    th = th + theta;
end







