%%
% d_a = [2,-10];
% v_a = [3, 4];
% d_left = [0, -3];
% d_right = [10, -4];
% v_left = d_left - d_a;
% v_right = d_right - d_a;
% ang_left = acosd(dot(v_a, v_left) / (norm(v_a) * norm(v_left)))
% ang_right = acosd(dot(v_a, v_right) / (norm(v_a) * norm(v_right)))
% int_left = dot(v_a/ norm(v_a), v_left) * v_a / norm(v_a) + d_a
% int_right = dot(v_a/ norm(v_a), v_right) * v_a / norm(v_a) + d_a
% v_int_left = d_left - int_left;
% v_int_left_n = v_int_left / norm(v_int_left)
% v_int_right = d_right - int_right;
% v_int_right_n = v_int_right / norm(v_int_right)

%%
r = 5;
d_a = [2,-10];
% d_a = [-6,-4];
v_a = [3, 4];
d_target = [4, -3];
v_target = d_target - d_a;
int_target = dot(v_a/ norm(v_a), v_target) * v_a / norm(v_a) + d_a;
v_int_target = d_target - int_target;
mask = sign(v_int_target) ./ sign(v_a);
%%
% d_a = [2,-10];
% v_a = [-3, -4];
v_d = [v_a(2), v_a(1)] .* mask;
d_d = d_a + r*v_d / norm(v_d);

%%

% x_c = -2;
% y_c = -7;
% x_p = 4;
% y_p = -3;
x_c = d_d(1);
y_c = d_d(2);
x_p = d_target(1);
y_p = d_target(2);
x_d = x_p - x_c;
y_d = y_p - y_c;


a_k = 8*x_c*x_p + 4*y_d^2 - ...
    4 * (x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2) -...
    4*x_p^2;
b_k = 8*y_d*x_d;
c_k = 4*x_c^2 - 4 * (x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2);
k = roots([a_k, b_k, c_k]);

a = (k.^2 + 1);
b = -2*x_p*k.^2 + 2*y_d*k - 2*x_c;
c = x_p^2*k.^2 - 2*x_p*y_d*k + ...
    x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2;

x = zeros(2,1);
xr = roots([a(1) b(1) c(1)]);
x(1) = xr(1);
xr = roots([a(2) b(2) c(2)]);
x(2) = xr(2);
y = k .* (x - x_p) + y_p;
% y(2) = k .* (x - x_p) + y_p;

%%
v_b = [x(1) - x_c, y(1)-y_c];
v_c = [x(2) - x_c, y(2)-y_c];
ang_b = acosd(dot(-v_d, v_b) / r^2);
ang_c = acosd(dot(-v_d, v_c) / r^2);
v_both = [x - x_c, y-y_c];
acosd(dot(-[v_d;v_d], v_both, 2) / r^2);
%%
figure;
hold on
v_up = [0, r];
ang_up = acosd(dot(v_up, v_b) / r^2);
w=ang_up*pi/180:0.001:ang_up*pi/180+ang_b*pi/180;
% w=0:0.01:ang_up*pi/180;
c = [x_c, y_c];
l_h=line(c(1)+r*sin(w),c(2)+r*cos(w));
scatter(x,y);
scatter(x_p, y_p);
xl = linspace(x(1), x_p);
yl = k(1) * (xl - x_p) + y_p;
plot(xl, yl)
xl = linspace(x(2), x_p);
yl = k(2) * (xl - x_p) + y_p;
plot(xl, yl)
scatter(d_a(1), d_a(2))
plot([d_a(1), d_d(1)], [d_a(2), d_d(2)]);
plot([x(1), d_d(1)], [y(1), d_d(2)]);
plot([x(2), d_d(1)], [y(2), d_d(2)]);

%%
%Run this section to find the best path among a list of targets
targets.N(1:5) = [100, 100, 200, 150, 50];
targets.E(1:5) = [-100, 100, 0, 75, -80];
targets_v = cat(1, targets.E, targets.N).';
d_start = [0, 0];
v_start = [1,0];
plot_num = 5;
tic
[order, time, distance] = Find_best_path(targets_v, d_start, v_start, plot_num);
targets_v = targets_v(order,:);

toc

