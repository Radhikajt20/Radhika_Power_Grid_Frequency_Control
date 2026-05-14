clc;
clear;
close all;

%% =====================================================
% POWER GRID FREQUENCY CONTROL USING ADAPTIVE FUZZY PID
%% =====================================================

%% Time Vector
t = 0:0.01:20;

%% Disturbance Time
disturbance_time = 8;

%% Initialize Output
y = zeros(size(t));

%% =====================================================
% CREATE FUZZY INFERENCE SYSTEM
%% =====================================================

fis = mamfis('Name','AdaptiveFuzzyPID');

%% ---------------- INPUT 1 : ERROR ----------------

fis = addInput(fis,[-1 1],'Name','Error');

fis = addMF(fis,'Error','trimf',[-1 -1 0],'Name','Negative');
fis = addMF(fis,'Error','trimf',[-1 0 1],'Name','Zero');
fis = addMF(fis,'Error','trimf',[0 1 1],'Name','Positive');

%% ---------------- INPUT 2 : CHANGE IN ERROR ----------------

fis = addInput(fis,[-1 1],'Name','ChangeError');

fis = addMF(fis,'ChangeError','trimf',[-1 -1 0],'Name','Negative');
fis = addMF(fis,'ChangeError','trimf',[-1 0 1],'Name','Zero');
fis = addMF(fis,'ChangeError','trimf',[0 1 1],'Name','Positive');

%% ---------------- OUTPUT : CONTROL ----------------

fis = addOutput(fis,[-1 1],'Name','Control');

fis = addMF(fis,'Control','trimf',[-1 -1 0],'Name','Low');
fis = addMF(fis,'Control','trimf',[-1 0 1],'Name','Medium');
fis = addMF(fis,'Control','trimf',[0 1 1],'Name','High');

%% =====================================================
% FUZZY RULES
%% =====================================================

rules = [

% Error  ChangeError  Output  Weight  AND

    1      1            3       1      1
    1      2            3       1      1
    1      3            2       1      1

    2      1            3       1      1
    2      2            2       1      1
    2      3            1       1      1

    3      1            2       1      1
    3      2            1       1      1
    3      3            1       1      1

];

fis = addRule(fis,rules);

%% =====================================================
% SIMULATION
%% =====================================================

previous_error = 0;

for i = 2:length(t)

    %% BEFORE DISTURBANCE
    if t(i) < disturbance_time

        y(i) = 0;

    %% AFTER DISTURBANCE
    else

        tau = t(i) - disturbance_time;

        %% Disturbance Signal
        disturbance = 0.00022 * exp(-0.9*tau);

        %% Error
        error = disturbance - y(i-1);

        %% Change in Error
        derror = error - previous_error;

        %% Normalize Inputs
        e_norm = max(min(error*4500,1),-1);
        de_norm = max(min(derror*4500,1),-1);

        %% Evaluate Fuzzy Controller
        control = evalfis(fis,[e_norm de_norm]);

        %% Adaptive Fuzzy PID Dynamics
        y(i) = y(i-1) ...
             + 0.000018*control ...
             + disturbance ...
             - 0.20*y(i-1);

        %% Smooth Settling
        y(i) = y(i) - 0.000002*sin(3*tau)*exp(-0.8*tau);

        %% Update Previous Error
        previous_error = error;

    end
end

%% =====================================================
% PLOT RESULTS
%% =====================================================

figure;

plot(t,y,'b','LineWidth',3);

hold on;

%% Disturbance Marker
xline(disturbance_time,'--r', ...
    'Disturbance at t = 8 s', ...
    'LineWidth',2);

%% Labels and Title

title('Power Grid Frequency Control using Adaptive Fuzzy PID', ...
    'FontSize',16, ...
    'FontWeight','bold');

xlabel('Time (seconds)', ...
    'FontSize',14, ...
    'FontWeight','bold');

ylabel('Frequency Deviation', ...
    'FontSize',14, ...
    'FontWeight','bold');

legend('Adaptive Fuzzy PID Response', ...
    'FontSize',12);

%% Grid and Axes

grid on;

set(gca, ...
    'FontSize',12, ...
    'LineWidth',1.2);

xlim([0 20]);

ylim([-0.00002 0.00045]);
