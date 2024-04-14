close all;clear all;clc
%% Parâmetros
R = 0.195/2; L = 0.331;

n = 3; r = 3; 
beta = (1:n)*pi/(n+1) + pi/2;

poseR0_list = [r*cos(beta'), r*sin(beta'), pi/2*ones(n,1)];
poseR0 = poseR0_list(1,:); poseG = [0,0,0];

emin = 0.1;
u_max = 1.2;
omega_max = (pi/180)*300;

c = 50; ke = 0.3; kalpha = 0.9; ktheta = 0.8; kd_theta = 1;
gamma = 0.3; k = 0.5; h = 2.5;

%% Simulações

UNICYCLE_MODE = 1; CONTROL_MODE = 1;
UNICYCLE_SIMULINK   = Simulink.Variant('UNICYCLE_MODE == 1');
UNICYCLE_COPPELIA   = Simulink.Variant('UNICYCLE_MODE == 2');
CONTROL_LINEAR      = Simulink.Variant('CONTROL_MODE == 1');
CONTROL_NONLINEAR   = Simulink.Variant('CONTROL_MODE == 2');

for j = 1:2
    UNICYCLE_MODE = j;
    for i = 1:n
        poseR0 = poseR0_list(i,:);
        
        CONTROL_MODE = 1;
        kd_theta = 0;       simP  = sim('model');
        kd_theta = 0.8;     simPD = sim('model');
        CONTROL_MODE = 2;   simNL = sim('model');
        
        if(i==1)
            plotErr(3*j-2,simP.e,simP.alpha,simP.theta,'b');
            plotErr(3*j-2,simPD.e,simPD.alpha,simPD.theta,'r');
            plotErr(3*j-2,simNL.e,simNL.alpha,simNL.theta,'k');
            
            plotVel(3*j-1,simP.u,simP.omega,'b');
            plotVel(3*j-1,simPD.u,simPD.omega,'r');
            plotVel(3*j-1,simNL.u,simNL.omega,'k');
        end
        
        plotTraj(3*j,simP.poseR,'b');
        plotTraj(3*j,simPD.poseR,'r');
        plotTraj(3*j,simNL.poseR,'k');
    end
end

%% Salvar imagens
figContent = {'Error','Vel','Traj'};
figModel = {'Simulink','Coppelia'};

for i = 1:6
    saveas(figure(i),[...
        'Images/',figModel{(i>3)+1},figContent{mod(i-1,3)+1},'.png']);
end
