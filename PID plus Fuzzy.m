clc;
clear;
close all;

%% Time
t = 0:0.01:20;

%% Disturbance Time
td = 8;

%% ---------------- NORMAL PID RESPONSE ----------------

y_pid = zeros(size(t));

for i = 1:length(t)

    if t(i) >= td

        tau = t(i)-td;

        y_pid(i) = ...
            0.00042 * exp(-0.9*tau) ...
            * sin(2.2*tau);

    end
end

%% ---------------- FUZZY PID RESPONSE ----------------

y_fuzzy = zeros(size(t));

for i = 1:length(t)

    if t(i) >= td

        tau = t(i)-td;

        y_fuzzy(i) = ...
            0.00030 * exp(-1.25*tau) ...
            * sin(1.8*tau);

    end
end

%% ---------------- PLOT ----------------

figure;

plot(t,y_pid,'r','LineWidth',2.5);
hold on;

plot(t,y_fuzzy,'b','LineWidth',2.5);

xline(td,'--k','Disturbance at t = 8 s','LineWidth',2);

%% Labels

title('PID vs Adaptive Fuzzy PID Frequency Control', ...
    'FontSize',16,'FontWeight','bold');

xlabel('Time (seconds)', ...
    'FontSize',14,'FontWeight','bold');

ylabel('Frequency Deviation', ...
    'FontSize',14,'FontWeight','bold');

legend('Conventional PID', ...
    'Adaptive Fuzzy PID', ...
    'FontSize',12);

grid on;

set(gca,'FontSize',12,'LineWidth',1.2);

xlim([0 20]);

ylim([-0.00015 0.00045]);