% Neato connection protocol

function res = connect(ip)

    % SYSTEM VARIABLES 
    n1_ip = '10.0.75.2';
    n2_ip = '10.0.75.1';
    neato_ip = ip;

    % DOCKER INSTANTIATION
    rosshutdown()
    command = strcat('cmd /c docker run --net=host -e HOST=', neato_ip, ' -it paulruvolo/neato_docker:qea &')
    system(command);
    rosinit(n1_ip, 11311, 'NodeHost', n2_ip);
    
    % EXECUTION STATUS
    res = 1;
    
end