function Plot_results(vars, i)

%altitude
figure;
plot(vars.t(1:i), -vars.pos.D(1:i));
title('Altitude[m] vs time[s]')
xlabel('time[s]')
ylabel('Altitude[m]')

%N/E pos
figure;
hold on;
grid on
plot(vars.pos.E(1:i), vars.pos.N(1:i));
title('2-D Position[m] vs time[s]')
for j = 1:vars.targets.count
        circle([vars.targets.E_total(j), vars.targets.N_total(j)], vars.targets.r_total(j), 'blue');
end
for j = 1:length(vars.targets.N)
        circle([vars.targets.E(j), vars.targets.N(j)], vars.targets.r(j), 'red');
end
axis('square')
xlabel('East -->')
ylabel('North -->')
hold off;
%N/E pos
figure;
plot3(vars.pos.E(1:i), vars.pos.N(1:i), -vars.pos.D(1:i));
title('3-D Position[m] vs time[s]')
xlabel('East -->')
ylabel('North -->')
zlabel('Up -->')
end

function l_h=circle(c,r, color)
% function i=circle(centre,radius)
w=0:0.05:2*pi+0.05;
l_h=line(c(1)+r*sin(w),c(2)+r*cos(w), 'color', color);

%Your example: l=circle([0 0],2);
end