function vars = Step_the_sim(dt, vars, i)
    vars.v.U(i) = vars.v.U(i-1) + dt * vars.a.U(i-1);
%     vars.v.N(i) = vars.v.N(i-1) + vars.a.N(i-1) * dt;
%     vars.v.E(i) = vars.v.E(i-1) + vars.a.E(i-1) * dt;
    vars.v.N(i) = vars.v.U(i) * cosd(vars.axes.yaw(i-1));
    vars.v.E(i) = vars.v.U(i) * sind(vars.axes.yaw(i-1));
    vars.v.D(i) = vars.v.D(i-1) + vars.a.D(i-1) * dt;
    
    vars.pos.N(i) = vars.pos.N(i-1) + vars.v.N(i-1) * dt;
    vars.pos.E(i) = vars.pos.E(i-1) + vars.v.E(i-1) * dt;
    vars.pos.D(i) = vars.pos.D(i-1) + vars.v.D(i-1) * dt;
    
    vars.axes.pitch(i) = vars.axes.pitch(i-1) + vars.axes.pitch_rate(i-1) * dt;
    vars.axes.yaw(i) = vars.axes.yaw(i-1) + vars.axes.yaw_rate(i-1) * dt;
    vars.axes.roll(i) = vars.axes.roll(i-1) + vars.axes.roll_rate(i-1) * dt;
    
    %TODO - Need aircraft dynamics and/or controller to update these
    vars.axes.pitch_rate(i) = 0;
    vars.axes.roll_rate(i) = 0;
    
%     vars.axes.yaw_desired(i) = 90;
    vars.axes.yaw_desired(i) = atan2d(...
        vars.pos.E_desired(i-1) - vars.pos.E(i-1), ...
        vars.pos.N_desired(i-1) - vars.pos.N(i-1));
    vars.axes.yaw_rate(i) = Yaw_Controller(vars, i);
    
    vars.forces.W(i) = vars.forces.W(i-1);
    vars.forces.L(i) = Lift(vars.v.N(i-1), vars.v.E(i-1), vars.axes.pitch(i-1));
    vars.forces.D(i) = Drag(vars.v.N(i-1), vars.v.E(i-1), vars.axes.pitch(i-1));
    
    vars.forces.T(i) = Thrust(vars.forces.D(i-1));
    
    vars.a.D(i) = -vars.forces.L(i-1)*cosd(vars.axes.pitch(i-1)) + ...
        vars.forces.W(i-1) -...
        vars.forces.T(i-1) * sind(vars.axes.pitch(i-1)) +...
        vars.forces.D(i-1) * sind(vars.axes.pitch(i-1));
    
    a_xy = vars.forces.T(i-1) * cosd(vars.axes.pitch(i-1)) - ...
        vars.forces.D(i-1) * cosd(vars.axes.pitch(i-1)) - ...
        vars.forces.L(i-1) * sind(vars.axes.pitch(i-1));
    vars.a.U(i) = a_xy;
    
%     vars.a.N(i) = a_xy * cosd(vars.axes.yaw(i-1));
%     vars.a.E(i) = a_xy * sind(vars.axes.yaw(i-1));
    
    vars.pos.N_desired(i) = vars.pos.N_desired(i-1);
    vars.pos.E_desired(i) = vars.pos.E_desired(i-1);
end