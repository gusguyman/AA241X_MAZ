function vars = Speed_controller(vars, i)
    vars.outputs.throttle(i) = max(0.0, min(vars.gains.speed.kp * (vars.v.U_desired(i-1) - vars.v.U(i-1)), 1.0));