function vars = Goal_check(vars, i)
    j = vars.targets.idx;
    dist = sqrt((vars.pos.N(i) - vars.targets.N(j))^2 + ...
        (vars.pos.E(i) - vars.targets.E(j))^2);

    if dist < vars.targets.r(j)
        disp('Hit target');
        vars.targets.count = vars.targets.count + 1;
        vars.targets.N_total(vars.targets.count) = vars.targets.N(j);
        vars.targets.E_total(vars.targets.count) = vars.targets.E(j);
        vars.targets.r_total(vars.targets.count) = vars.targets.r(j);
        vars = Get_new_target(vars, i);
        vars = Path_planning(vars, i);
    end
end