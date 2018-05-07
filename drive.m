
% Initialization
clear all
%;;connect('192.168.16.85');
[scanner, sender, tftree] = subMobility();

% Main Loop

scans = [];
tic
time = 0;
while time < (5)
    
    scan = receive(scanner);
    cloud = readXYZ(scan);
    data = clean(cloud);
    scans = [scans; data];
    pause(0.5)
    time = toc;
    
end

[charges, r, center] = extractFeatures(scans);
hold on
plot(scans(:,1),scans(:,2),'.')
plot(charges(:,1),charges(:,2),'x');
viscircles(center',r)