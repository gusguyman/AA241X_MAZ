function vars = Pitch_controller(vars, i)
    vars.outputs.elevator(i) = max(-1.0, min(vars.gains.pitch.kp * (vars.axes.pitch_desired(i-1) - vars.axes.pitch(i-1)), 1.0));
    vars.axes.q(i) = 20 * vars.outputs.elevator(i) + 0 * (rand - 0.5);