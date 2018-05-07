% Applies RANSAC on a proportion of the data scanned by the Neato's LIDAR,
% extracting a single circular object and all detected line markers.

function [charges, r, center] = extractFeatures(data)

    % Identify and delete the data points that best fit a circle
    charges_temp = [];
    
    [center, r, ~, idx,mxd] = RANCIRCLE(data, 10000, 0.01, 0.10, 0.12)
    data(idx,:) = [];
    
    n = size(data,1);
    
    % Attempt to explain 33% of all current lidar data up to 10% at a time
    while size(data,1) > n/4
        
        % minInlierRatio,maxInlierRatio best @ 0.09-0.1 (each line should be
        % somewhere between 9% and 10% of the total unique data points.
        [~,~,idxs] = RANSAC(data,10000,0.04,0.093,0.095);
        inliers = data(idxs,:);
        
        % Remove recently registered inliers from consideration from future iterations
        data(idxs,:) = [];
        
        % Select 4 evenly spaced inliers from each identified line group
        ridx = round(linspace(1,size(inliers,1),4));
        charges_temp = [charges_temp; inliers(ridx,1),inliers(ridx,2);];
    end
    
    if r == 0
        [center, r, ~, idx,mxd] = RANCIRCLE(data, 20000, 0.01, 0.11, 0.42)
        data(idx,:) = [];
    end
    
    % Assign outputs    
    charges = charges_temp;
    
    
    
%     plot(data(:,1),data(:,2),'o');
    
end