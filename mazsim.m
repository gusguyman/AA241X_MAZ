dt = 0.1; %seconds
sim_time = 10; %seconds
steps = sim_time / dt;

vars = init(steps); %First row of environment is variables
vars.t(1) = 0;

for i = 2:steps
    vars = step_the_sim(dt, vars, i);
    vars.t(i) = vars.t(i-1) + dt;
end

%%
plot_results(vars);