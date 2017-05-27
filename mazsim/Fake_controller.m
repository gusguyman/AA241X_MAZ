function vars = Fake_controller(vars, i)
%     vars.outputs.rudder(i) = max(-1.0, min(vars.gains.yaw.kp * (vars.axes.yaw_desired(i-1) - vars.axes.yaw(i-1)), 1.0));
%     vars.axes.r(i) = 20 * vars.outputs.rudder(i) + 0 * (rand - 0.5);
%     
%     vars.outputs.elevator(i) = max(-1.0, min(vars.gains.pitch.kp * (vars.axes.pitch_desired(i-1) - vars.axes.pitch(i-1)), 1.0));
%     vars.axes.q(i) = 20 * vars.outputs.elevator(i) + 0 * (rand - 0.5);
%     
%     vars.outputs.aileron(i) = max(-1.0, min(vars.gains.roll.kp * (vars.axes.roll_desired(i-1) - vars.axes.roll(i-1)), 1.0));
%     vars.axes.p(i) = 20 * vars.outputs.aileron(i) + 0 * (rand - 0.5);

    vars.outputs.rudder(i) = 0;
    vars.axes.r(i) = 25;
    
    vars.outputs.elevator(i) = 0;
    vars.axes.q(i) = vars.axes.r(i) * tand(vars.axes.roll(i));
    
    vars.outputs.aileron(i) = 0;
    vars.axes.p(i) = 0;
end