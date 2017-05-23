function vars = Get_new_target(vars, i)

    fair = 0;
    while(not(fair))
        x = rand * vars.bounds.w + vars.bounds.x_ll;
        y = rand * vars.bounds.h + vars.bounds.y_ll;
        bp = vars.bounds.boundary_padding;
        dist = sqrt((x - vars.pos.E(i))^2 + (y - vars.pos.N(i))^2);
        if (x > bp + vars.bounds.x_ll) &&...
                (x < vars.bounds.x_ll + vars.bounds.w - bp) && ...
                (y > bp + vars.bounds.y_ll) && ...
                (y < vars.bounds.y_ll + vars.bounds.h - bp) && ...
                (dist > vars.bounds.aircraft_padding)
            fair = 1;
            r = vars.bounds.min_r + ...
                rand * (vars.bounds.max_r - vars.bounds.min_r);
        end
        
    end
    vars.targets.E = [vars.targets.E(2:end), x];
    vars.targets.N = [vars.targets.N(2:end), y];
    vars.targets.r  = [vars.targets.r(2:end), r];
end