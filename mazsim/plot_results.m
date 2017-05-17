function plot_results(vars)

%altitude
figure;
plot(vars.t, -vars.pos.D);
title('Altitude[m] vs time[s]')
xlabel('time[s]')
ylabel('Altitude[m]')

%N/E pos
figure;
plot(vars.pos.N, vars.pos.E);
title('2-D Position[m] vs time[s]')
xlabel('East -->')
ylabel('North -->')

%N/E pos
figure;
plot3(vars.pos.N, vars.pos.E, -vars.pos.D);
title('3-D Position[m] vs time[s]')
xlabel('East -->')
ylabel('North -->')
zlabel('Up -->')
end