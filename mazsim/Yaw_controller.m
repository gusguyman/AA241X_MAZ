function vars = Yaw_controller(vars, i)
    vars.outputs.rudder(i) = max(-1.0, min(vars.gains.yaw.kp * (vars.axes.yaw_desired(i-1) - vars.axes.yaw(i-1)), 1.0));
    vars.axes.r(i) = 20 * vars.outputs.rudder(i) + 0 * (rand - 0.5);