function vars = Thrust(vars, i)
    x = [0.0, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0];
    v = [0.0, 3.49, 4.25, 5.15, 6.17, 7.30, 7.89];
    vars.forces.T(i) = interp1(x,v,vars.outputs.throttle(i));
end
