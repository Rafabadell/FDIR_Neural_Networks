clear;clc;
rr=0;
while rr<=99
    Initialization
    Gyros = zeros(3,6);
    Thrus = ones(1,8);
    ReWhe = zeros(3,4);
    
    %Probability of Gyroscope failure
    PG0 = 0.45;  % P 0 gyro failure
    PG1 = 0.35;  % P 1 gyro failure
    PG2 = 0.20;  % P 2 gyro failure
    
    %Probability of Thruster Failure
    PT0 = 0;%0.5;   % P 0 Thruster failure
    PT1 = 0;%0.4;   % P 1 Thruster failure
    PT2 = 0;%0.1;   % P 2 Thruster failure
    
    %Probability of RW Failure
    PR0 = 0.5;   % P 0 Reaction Wheels failure
    PR1 = 0.4;   % P 1 Reaction Wheel  failure
    PR2 = 0.1;   % P 2 Reaction Wheels failure
    
    %% Generate Gyroscope failure scenario
    sc=rand;
    if sc<PG0
        
    elseif sc<(PG0+PG1)
        Gyros(randi(3),randi(6))=1;
    else
        g1=randi(6);
        g2=g1;
        while g2==g1
            g2=randi(6);
        end
        Gyros(randi(3),g1)=1;
        Gyros(randi(3),g2)=1;
    end   
    
    %% Generate Thruster failure scenario
    sc=rand;
    if sc<PT0
        
    elseif sc<(PT0+PT1)
        Thrus(randi(8))=0;
    else
        t1=randi(8);
        t2=t1;
        while t2==t1
            t2=randi(8);
        end
        Thrus(t1)=0;
        Thrus(t2)=0;
    end   
    
    %% Generate reaction wheels failure scenario
    sc=rand;
    if sc<PR0
        
    elseif sc<(PR0+PR1)
        ReWhe(randi(3),randi(4))=1;
    else
        g1=randi(4);
        g2=g1;
        while g2==g1
            g2=randi(4);
        end
        ReWhe(randi(3),g1)=1;
        ReWhe(randi(3),g2)=1;
    end  
    %% Run Simulation 
    try 
        sim('AOCS_FDIR.slx',200)
        rr=rr+1;
        %% Manage Outputs
        Data_Export(rr, Gyros, Gyros_Data, ReWhe, ReWhe_Data, Thrus, Thrus_Data)
    catch 
        
    end
end
    