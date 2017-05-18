function yaw_rate = Yaw_Controller(vars, i)
    yaw_rate = 10 * (vars.axes.yaw_desired(i-1) - vars.axes.yaw(i-1));
    yaw_rate = max(-30.0, min(yaw_rate, 30.0));