% Generates vector field of the mapped global coordinate system

function [x,y,F] = genField(charges, r, center, degree)

    % Describe space with meshgrid
    [x,y] = meshgrid(-3:0.1:3,-3:0.1:3);
    
    % Weight bucket location by depressing outline of bucket on surface logarithmically
    Ft = log(sqrt((x-center(1)).^2+(y-center(2)).^2+2.*r.^2)).*3;

    for i = 1:size(charges,1)
        point = charges(i,:);
        
        % Weight wall marker locations by raising marker point locations on
        % surface logarithmically
        Ft = Ft - real(log( sqrt((x-point(1)).^2 + (y-point(2)).^2 ) ))./degree;
    end
    
    % Assign outputs    
    F = Ft;

end