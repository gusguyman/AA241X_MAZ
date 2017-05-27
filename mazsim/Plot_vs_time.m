function Plot_vs_time(some_var, vars, i)

    figure;
    plot(vars.t(1:i), some_var(1:i))
end