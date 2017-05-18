dt = 0.1; %seconds
sim_time = 60; %seconds
steps = sim_time / dt;
num_targets = 3;

vars = init(steps, num_targets); %First row of environment is variables
vars.t(1) = 0;

for i = 2:steps
    vars = step_the_sim(dt, vars, i);
    vars.t(i) = vars.t(i-1) + dt;
    new_target_idx = goal_check(vars, i);
    if new_target_idx > num_targets
        break;
    else
        vars.pos.N_desired(i) = vars.pos.N_targets(new_target_idx);
        vars.pos.E_desired(i) = vars.pos.E_targets(new_target_idx);
        vars.pos.target_idx = new_target_idx;
    end
end

%%
plot_results(vars);