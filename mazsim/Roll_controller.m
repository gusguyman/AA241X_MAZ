function vars = Roll_controller(vars, i)
    vars.outputs.aileron(i) = max(-1.0, min(vars.gains.roll.kp * (vars.axes.roll_desired(i-1) - vars.axes.roll(i-1)), 1.0));
    vars.axes.p(i) = 20 * vars.outputs.aileron(i) + 0 * (rand - 0.5);