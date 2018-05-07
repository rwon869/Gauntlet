% Robust RANSAC circle detection

function [center, radius, n_inliers, idxn, mxd] = RANCIRCLE(data, iterations, threshold, minr, maxr)

    % Initialize values
    best_r = 0;
    best_in = 0;
    best_c = [0;0];
    n_in = 0;
    idxt = [];
    mxd = 0;
    
    for iter=1:iterations
        selected = [];
        n_in = 0;
        
        % Random independent sample of 3 points from the dataset        
        idx = randperm(size(data,1),3); 
        sample = data(idx,:);
        
        % Assign points to variables
        x1 = sample(1,1);
        y1 = sample(1,2);
        x2 = sample(2,1);
        y2 = sample(2,2);
        x3 = sample(3,1);
        y3 = sample(3,2);
        
        dist1 = sqrt((y2-y1).^2 + (x2-x1).^2);
        dist2 = sqrt((y2-y1).^2 + (x2-x1).^2);
        
        % Calculate two slopes between points
        mr = (y2-y1)./(x2-x1);
        mt = (y3-y2)./(x3-x2);
        
        % Solve formulae for center of circle
        xcyc = (mr.*mt.*(y3-y1)+mr.*(x2+x3)-mt.*(x1+x2))./(2*(mr-mt));
        xcyc(2,:) = -1./mr.*(xcyc-(x1+x2)/2)+(y1+y2)/2;
        
        % Derive radius from center using sample point and estimate circle
        r_guess = sqrt((xcyc(1,:)-x1).^2+(xcyc(2,:)-y1).^2);
        center_guess = xcyc;
        
        % Consider inliers within margin of radius
        error = (data' - xcyc);
        for i=1:size(error,2)
            if (abs(r_guess - norm(error(:,i))) < threshold)
                n_in = n_in + 1;
                selected = [selected; i];
            end
        end
%         & abs(mr-mt) > 
        % Select circle estimation with the most inliers        
        if best_in < n_in & r_guess < maxr & r_guess > minr
            best_r = r_guess;
            best_c = center_guess;
            best_in = n_in;
            idxt = selected';
        end
    end
    
    % Assign outputs
    center = [0 0]';
    radius = 0;
    n_inliers = 0;
    idxn = [];
    if best_in > 5
        center = best_c;
        radius = best_r;
        n_inliers = best_in;
        idxn = idxt;
        mxd = abs(mr-mt);
    end
end