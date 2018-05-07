% ROSTOPIC HANDLER

function [sub, pub, tftree] = subMobility()

    sub = rossubscriber('/projected_stable_scan', 'sensor_msgs/PointCloud2');
    pub = rospublisher('/raw_vel');
    tftree = rostf;
    
end