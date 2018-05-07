% Robust RANSAC algorithm

function [s2, avpoint,inliers] = RANSAC(data,iterations,threshDist,inlierRatioMin,inlierRatioMax )
    
    % Initialize values
    n = size(data, 1); 
    n_inliers = 0; 
    selected_inliers = ones(n,1); 
    
    for i=1:iterations
        
        % Pick a random sample of 2 points
        idx = randperm(n,2); 
        sample = data(idx,:)'; 
        line = sample(2,:)-sample(1,:); 
        
        % Define the axis along which distance is measured
        normal = line/norm(line); 
        normal_vector = [-normal(2) normal(1)]; 
        
        % Calculate the distances and qualify points as inliers
        distances = normal_vector*(data' - repmat(sample(1,:)',1,n) ); 
        iter_inliers = find(abs(distances) <= threshDist); 
        if (n_inliers < length(iter_inliers) && length(iter_inliers)/n < inlierRatioMin && length(iter_inliers)/n < inlierRatioMax) 
            selected_inliers = iter_inliers; 
            n_inliers = length(iter_inliers); 
        end
        
    end
    
    % Generate results 
    avpoint = mean(data(selected_inliers,:));
    inliers = selected_inliers;
    s2 = sample(:,2);
    
end



