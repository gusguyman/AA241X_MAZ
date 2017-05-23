function yaw_rate = Yaw_controller(vars, i)
    yaw_rate = 1 * (vars.axes.yaw_desired(i-1) - vars.axes.yaw(i-1));
    yaw_rate = max(-20.0, min(yaw_rate, 20.0));