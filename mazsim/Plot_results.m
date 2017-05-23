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
circle([vars.pos.E_targets(1), vars.pos.N_targets(1)], vars.pos.r_targets(1));
circle([vars.pos.E_targets(2), vars.pos.N_targets(2)], vars.pos.r_targets(2));
circle([vars.pos.E_targets(3), vars.pos.N_targets(3)], vars.pos.r_targets(3));
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

function l_h=circle(c,r)
% function i=circle(centre,radius)
w=0:0.05:2*pi+0.05;
l_h=line(c(1)+r*sin(w),c(2)+r*cos(w));

%Your example: l=circle([0 0],2);
end