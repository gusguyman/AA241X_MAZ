dt = 0.1; %seconds
sim_time = 120; %seconds
steps = sim_time / dt;
num_targets = 3;
max_targets = 10;

vars = Init(steps, num_targets, max_targets); %First row of environment is variables
vars.t(1) = 0;
tic
for i = 2:steps
    vars = Step_the_sim(dt, vars, i);
    vars.t(i) = vars.t(i-1) + dt;
    vars = Goal_check(vars, i);
    if new_target_idx > max_targets
        break;
    else
        vars = Get_new_target(vars);
    end
end
fprintf('%d Targets Completed in %f Seconds\n', ...
    num_targets, ...
    i * dt);
vars3 = vars;
toc
%%
Plot_results(vars, i);