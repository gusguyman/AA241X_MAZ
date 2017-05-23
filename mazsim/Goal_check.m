function new_target_idx = Goal_check(vars, i)
    j = vars.pos.target_idx;
    dist = sqrt((vars.pos.N(i) - vars.pos.N_targets(j))^2 + ...
        (vars.pos.E(i) - vars.pos.E_targets(j))^2);

    if dist < vars.pos.r_targets(j)
        disp('Hit target');
        new_target_idx = vars.pos.target_idx + 1;
    else
        new_target_idx = vars.pos.target_idx;
    end
end