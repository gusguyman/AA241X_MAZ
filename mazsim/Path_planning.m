function vars = Path_planning(vars, i)

    vars.pos.N_desired(i) = vars.targets.N(1);
    vars.pos.E_desired(i) = vars.targets.E(1);
end