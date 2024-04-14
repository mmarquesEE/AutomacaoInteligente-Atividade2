close all;clear all;clc
%% Parâmetros
R = 0.195/2; L = 0.331;

poseR0 = [2,2,pi/4]; xg = 0; yg = 0;

emin = 0.05;
u_max = 1.2;
omega_max = (pi/180)*300;

%% Variantes do modelo

UNICYCLE_MODE = 1; CONTROL_MODE = 1; GOAL_MODE = 1;

UNICYCLE_SIMULINK   = Simulink.Variant('UNICYCLE_MODE == 1');
UNICYCLE_COPPELIA   = Simulink.Variant('UNICYCLE_MODE == 2');

CONTROL_LINEAR      = Simulink.Variant('CONTROL_MODE == 1');
CONTROL_NONLINEAR   = Simulink.Variant('CONTROL_MODE == 2');

GOAL_SIMULINK       = Simulink.Variant('GOAL_MODE == 1');
GOAL_COPPELIA       = Simulink.Variant('GOAL_MODE == 2');

%% Simulações (P e PD)
Color = {'b','k','r'};

ke = 0.3; kalpha = 1; c = 50; kd_alpha_max = -0.9;
kd_alpha_list = kd_alpha_max*[0,0.5,1];
%%
for i = 1:3
    kd_alpha = kd_alpha_list(i);
    simOut = sim('model');
    
    color = Color{i};

    plotErr(1,simOut.e,simOut.alpha,color);
    plotVel(2,simOut.u,simOut.omega,color);
    plotTraj(3,simOut.poseR,color);
end

%% Simulações (Não Linear):

CONTROL_MODE = 2;

gamma = 0.3; k_max = 2.5;
k_list = k_max*[0.2,0.4,1];
%%
for i = 1:3
    k = k_list(i);
    simOut = sim('model');

    color = Color{i};

    plotErr(4,simOut.e,simOut.alpha,color);
    plotVel(5,simOut.u,simOut.omega,color);
    plotTraj(6,simOut.poseR,color);
end

%% Simulação Coppelia

ke = 0.3; kalpha = 1; kd_alpha = -0.5;
gamma = 0.3; k = 1;

UNICYCLE_MODE = 2;

CONTROL_MODE = 1;
simOut = sim('model');
plotErr(7,simOut.e,simOut.alpha,'b');
plotVel(8,simOut.u,simOut.omega,'b');
plotTraj(9,simOut.poseR,'b');

CONTROL_MODE = 2;
simOut = sim('model');
plotErr(7,simOut.e,simOut.alpha,'k');
plotVel(8,simOut.u,simOut.omega,'k');
plotTraj(9,simOut.poseR,'k');

%% Salvando as figuras
figName = {'errPD','velPD','trajPD','errNL','velNL','trajNL',...
    'errCop','velCop','trajCop'};
for i = 1:9
    saveas(figure(i),['Images/',figName{i},'.png']);
end


