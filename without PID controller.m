clc;
clear;
close all;

%% =========================================
% POWER GRID FREQUENCY CONTROL WITHOUT PID
% ONLY BASIC POWER SYSTEM RESPONSE
%% =========================================

%% Time Vector
t = 0:0.01:20;

%% Disturbance Time
disturbance_time = 8;

%% Initialize Output
y = zeros(size(t));

%% Simulate Power Grid Response

for i = 1:length(t)

    %% Before Disturbance
    if t(i) < disturbance_time

        y(i) = 0;

        %% After Disturbance
    else

        tau = t(i) - disturbance_time;

        %% Natural Power Grid Frequency Deviation
        y(i) = 0.00045 ...
            * exp(-0.45*tau) ...
            * sin(2.5*tau);

    end
end

%% =========================================
% PLOT
%% =========================================

figure;

plot(t,y,'r','LineWidth',3);

hold on;

%% Disturbance Line
xline(disturbance_time,'--k', ...
    'Disturbance at t = 8 s', ...
    'LineWidth',2);

%% Labels

title('Power Grid Frequency Deviation without Controller', ...
    'FontSize',16, ...
    'FontWeight','bold');

xlabel('Time (seconds)', ...
    'FontSize',14, ...
    'FontWeight','bold');

ylabel('Frequency Deviation', ...
    'FontSize',14, ...
    'FontWeight','bold');

legend('Uncontrolled System Response', ...
    'FontSize',12);

%% Grid

grid on;

set(gca, ...
    'FontSize',12, ...
    'LineWidth',1.2);

xlim([0 20]);

ylim([-0.0005 0.0005]);