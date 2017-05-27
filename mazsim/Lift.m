function l = Lift(vars, i)
    %TODO - Lift from aircraft dynamics
    AOA = vars.aircraft.AOA +...
        (vars.axes.pitch(i) - atan2d(-vars.v.D(i), vars.v.U(i)));
    Cl = 0.082 * AOA + 0.13;
    
    l = Cl * 0.5 * 1.225 * vars.v.U(i)^2 * vars.aircraft.span^2 / vars.aircraft.AR;
    l = (1 / cosd(vars.axes.roll(i)))*vars.aircraft.W;
end