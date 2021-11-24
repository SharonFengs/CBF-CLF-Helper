close all;
clear all;
clc;
% Init state.
x0 = [0; 0; 0; 0];

% Target position
params.p_d = [13; 10];
% wall location
params.x_o = 12;
% params.y_o = 15;
% % obstacle.
% params.p_o = [3,3];
% params.r_o = 1; 

dt = 0.01;
sim_t = 5;
F=[0 1;0 0];
G=[0;1];
C=[0 1];
p=[-2 -3];
gain_c=place(F,G,p);

params.gain = gain_c;

params.u_max =5;
params.u_min  = -5;

params.clf.rate = 5;
params.cbf.rate = 1;

params.weight.slack = 1;
params.weight.input = 100;

dynsys = Test2D(params);

odeFun = @dynsys.dynamics;
% controller = @dynsys.ctrlECbf;
controller = @dynsys.ctrlCbfClfQp;
odeSolver = @ode45;

total_k = ceil(sim_t / dt);
x = x0;
t = 0;   
% initialize traces.
xs = zeros(total_k, dynsys.xdim);
ts = zeros(total_k, 1);
us = zeros(total_k-1, dynsys.udim);
hs = zeros(total_k-1, 3);
Vs = zeros(total_k-1, 1);
xs(1, :) = x0';
ts(1) = t;
u_prev = [0;0];
for k = 1:total_k-1
    % Determine control input.
    % dV_hat: analytic Vdot based on model.
    [u, slack, h, V] = controller(x);        
%     [u, slack, h, V] = controller(s, u_prev); % optimizing the difference between the previous timestep.       
    us(k, :) = u';
    hs(k,:) = h;
    Vs(k) = V;

    % Run one time step propagation.
    [ts_temp, xs_temp] = odeSolver(@(t, s) odeFun(t, s, u), [t t+dt], x);
    x = xs_temp(end, :)';

    xs(k+1, :) = x';
    ts(k+1) = ts_temp(end);
    u_prev = u;
    t = t + dt;
end

% plot_results(ts, xs, us, params.x_o, params.r_o)
figure(1)
plot(xs(:, 1), xs(:, 3));
hold on
plot(x0(1),x0(3),'o','linewidth',2);
plot(params.p_d(1),params.p_d(2),'x','linewidth',2);
xline(params.x_o, 'r');
% yline(params.y_o, 'r');
% draw_circle(params.p_o, params.r_o);
xlim([0 20]);
ylim([0 20]);
hold off;
figure(2)
plot(ts(2:end),us(:,1));
hold on
plot(ts(2:end),us(:,2));
xlabel('t')
ylabel('u')

figure(3)
plot(ts,xs(:,2));
hold on
plot(ts,xs(:,4));
xlabel('t')
ylabel('v')

figure(4)
plot(ts,xs(:,1));
hold on
plot(ts,xs(:,3));
xlabel('t')
ylabel('x')

function h = draw_circle(center,r)
th = 0:pi/50:2*pi;
xunit = r * cos(th) + center(1);
yunit = r * sin(th) + center(2);
h = plot(xunit, yunit,'r');
end