% Data cleaning and preprocessing

function data = clean(cloud)

    % Retreive values from 3D Point Cloud
    x = cloud(:,1);
    y = cloud(:,2);
    data_raw = [x y];
    
    % Remove zero (faulty) values from data matrix   
    data = data_raw(any(data_raw,2),:);
    
end