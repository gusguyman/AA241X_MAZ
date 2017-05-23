function vars = Get_new_target(vars)

    fair = 0;
    while(not(fair))
        x = rand * vars.bounds.w + vars.bounds.x_ll;
        y = rand * vars.bounds.h + vars.bounds.y_ll;
        bp = vars.bounds.boundary_padding;
        dist = sqrt((x - vars.pos.E)^2 + (y - vars.pos.N)^2);
        if (x > bp) &&...
                (x < vars.bounds.w - bp) && ...
                (y > bp) && ...
                (y < vars.bounds.h - bp) && ...
                (dist < vars.bounds.aircraft_padding)
            fair = 1;
            r = vars.bounds.min_r + ...
                rand * (vars.bounds.max_r - vars.bounds.min_r);
        end
        
    end
    vars.pos.E_targets = [vars.pos.E_targets(2:-1), x];
    vars.pos.N_targets = [vars.pos.N_targets(2:-1), y];
    vars.pos.r_targets  = [vars.pos.r_targets(2:-1), r];
end