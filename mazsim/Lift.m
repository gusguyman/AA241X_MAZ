function l = Lift(vars, i)
    %TODO - Lift from aircraft dynamics
    Cl = 0.082 * vars.aircraft.AOA + 0.13;
    
    l = Cl * 0.5 * 1.225 * vars.v.U(i)^2 * vars.aircraft.area;
end