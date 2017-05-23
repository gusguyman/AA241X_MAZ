dt = 1/10; %seconds
sim_time = 120; %seconds
steps = sim_time / dt;
num_targets = 3;
max_targets = 10;
vars = Init(steps, num_targets, max_targets); %First row of environment is variables
% for i = 1:max_targets
%     vars = Get_new_target(vars, i);
% end
vars.t(1) = 0;
tic
for i = 2:steps
    vars = Step_the_sim(dt, vars, i);
    vars.t(i) = vars.t(i-1) + dt;
    vars = Goal_check(vars, i);
    if vars.targets.count > max_targets
        break;
    end
    if vars.pos.D(i) >= 0.0
        disp('Crash!')
        break;
    end
end
fprintf('%d Targets Completed in %f Seconds\n', ...
    vars.targets.count, ...
    i * dt);
vars3 = vars;
toc
%%
Plot_results(vars, i);
