function d = Drag(vars, i)
    %TODO - Drag from aircraft dynamaics
%     AOA = vars.aircraft.AOA +...
%         (vars.axes.pitch(i) - atan2d(-vars.v.D(i), vars.v.U(i)));
%     if AOA < 6
%         L_D = 0.082 * AOA + 4;
%     else
%         L_D
%     end
    x = [-0.3, -0.2, -0.1, 0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0,];
    v = [0.026, 0.024, 0.022, 0.021, 0.022, 0.023, 0.0245, 0.028, 0.032, 0.037, 0.043, 0.052, 0.062, 0.076];
    Cl = vars.forces.L(i) /(0.5 * 1.225 * vars.v.U(i)^2 * vars.aircraft.area);
    Cd = interp1(x,v,Cl,'pchip', 'extrap');
    d = Cd * 0.5 * 1.225 * vars.v.U(i)^2 * vars.aircraft.area;
end
