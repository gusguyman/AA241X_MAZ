function vars = Step_the_sim_simple(dt, vars, i)
    if vars.targets.turning
        %Find turn rate
        vars.axes.roll(i) = 60;
        vars.axes.yaw_rate(i) = (9.81/15) * sqrt(3);
        vars.axes.yaw(i) = vars.axes.yaw(i-1)
    else
        vars.v.U(i) = vars.v.U(i-1) + dt * vars.a.U(i-1);
        vars.v.V(i) = vars.v.V(i-1) + dt * vars.a.V(i-1);
        vars.v.W(i) = vars.v.W(i-1) + dt * vars.a.W(i-1);
    %     vars.v.N(i) = vars.v.N(i-1) + dt * vars.a.N(i-1);
    %     vars.v.E(i) = vars.v.E(i-1) + dt * vars.a.E(i-1);
    %     vars.v.D(i) = vars.v.D(i-1) + dt * vars.a.D(i-1);


        vars.axes.pitch(i) = vars.axes.pitch(i-1) + vars.axes.pitch_rate(i-1) * dt;
        vars.axes.yaw(i) = vars.axes.yaw(i-1) + vars.axes.yaw_rate(i-1) * dt;
        vars.axes.roll(i) = vars.axes.roll(i-1) + vars.axes.roll_rate(i-1) * dt;

        earth_v = Body_to_earth([vars.v.U(i); vars.v.V(i); vars.v.W(i)], ...
                vars.axes.roll(i),...
                vars.axes.pitch(i),...
                vars.axes.yaw(i));

        vars.v.N(i) = earth_v(1);
        vars.v.E(i) = earth_v(2);
        vars.v.D(i) = earth_v(3);

        vars.pos.N(i) = vars.pos.N(i-1) + (vars.v.N(i-1) + vars.v.N(i))/2 * dt;
        vars.pos.E(i) = vars.pos.E(i-1) + (vars.v.E(i-1) + vars.v.E(i))/2 * dt;
        vars.pos.D(i) = vars.pos.D(i-1) + (vars.v.D(i-1) + vars.v.D(i))/2 * dt;    


        %TODO - Need aircraft dynamics and/or controller to update these
    %     vars.axes.pitch_rate(i) = 0;
    %     vars.axes.roll_rate(i) = 0;

    %     vars.axes.yaw_desired(i) = 90;
    %     vars.axes.yaw_desired(i) = atan2d(...
    %         vars.pos.E_desired(i-1) - vars.pos.E(i-1), ...
    %         vars.pos.N_desired(i-1) - vars.pos.N(i-1));
    %     vars.axes.yaw_desired(i) = vars.axes.yaw(i) + 10;
    %     vars = Yaw_controller(vars, i);
    %     if abs(vars.axes.yaw_desired(i) - vars.axes.yaw(i)) > 180
    %         vars.axes.yaw_desired(i) = vars.axes.yaw(i) + abs(vars.axes.yaw_desired(i) - vars.axes.yaw(i)) - 360;
    %     end
    % %     vars.axes.pitch_desired(i) = vars.gains.alt.kp * (-100 - vars.pos.D(i)); 
    % %     vars.axes.roll_desired(i) = -0.1*(vars.axes.yaw(i) - vars.axes.yaw_desired(i));
    % 
    %     vars.axes.pitch_desired(i) = 50;
    %     vars.axes.roll_desired(i) = 0;
    %     vars = Pitch_controller(vars,i);
    %     vars = Roll_controller(vars, i);
        vars = Fake_controller(vars, i);
        T = [1, sind(vars.axes.roll(i))*tand(vars.axes.pitch(i)), cosd(vars.axes.roll(i))*tand(vars.axes.pitch(i));...
            0, cosd(vars.axes.roll(i)), -sind(vars.axes.roll(i));...
            0, sind(vars.axes.roll(i))*secd(vars.axes.pitch(i)), cosd(vars.axes.roll(i))*secd(vars.axes.pitch(i))];
        earth_angle_rates = T * [vars.axes.p(i); vars.axes.q(i); vars.axes.r(i)];
        vars.axes.roll_rate(i) = earth_angle_rates(1);
        vars.axes.pitch_rate(i) = earth_angle_rates(2);
        vars.axes.yaw_rate(i) = earth_angle_rates(3);
        vars = Speed_controller(vars, i);

        vars.forces.W(i) = vars.forces.W(i-1);
        vars.forces.L(i) = Lift(vars, i);
        vars.forces.D(i) = Drag(vars, i);

        vars = Thrust(vars, i);

    %     vars.a.D(i) = -vars.forces.L(i-1)*cosd(vars.axes.pitch(i-1)) + ...
    %         vars.forces.W(i-1) -...
    %         vars.forces.T(i-1) * sind(vars.axes.pitch(i-1)) +...
    %         vars.forces.D(i-1) * sind(vars.axes.pitch(i-1));
    %     
    %     a_xy = vars.forces.T(i-1) * cosd(vars.axes.pitch(i-1)) - ...
    %         vars.forces.D(i-1) * cosd(vars.axes.pitch(i-1)) - ...
    %         vars.forces.L(i-1) * sind(vars.axes.pitch(i-1));
    %     vars.a.U(i) = a_xy;

        body_W = Earth_to_body([0; 0; vars.forces.W(i-1)], ...
                vars.axes.roll(i-1),...
                vars.axes.pitch(i-1),...
                vars.axes.yaw(i-1));
        vars.a.U(i) = (vars.forces.T(i) - vars.forces.D(i) + body_W(1))...
            / vars.aircraft.mass;
        vars.a.V(i) = body_W(2) / vars.aircraft.mass;
        vars.a.W(i) = (-vars.forces.L(i) + body_W(3)) / vars.aircraft.mass;
    %         earth_a = Body_to_earth([vars.a.U(i); vars.a.V(i); vars.a.W(i)], ...
    %             vars.axes.roll(i),...
    %             vars.axes.pitch(i),...
    %             vars.axes.yaw(i)) - [0, -vars.axes.r(i), vars.axes.q(i);...
    %             vars.axes.r(i), 0, -vars.axes.p(i);...
    %             -vars.axes.q(i), vars.axes.p(i), 0] * [vars.v.U(i); vars.v.V(i); vars.v.W(i)];
    %         vars.a.N(i) = earth_a(1);
    %         vars.a.E(i) = earth_a(2);
    %         vars.a.D(i) = earth_a(3);

    %     vars.a.N(i) = a_xy * cosd(vars.axes.yaw(i-1));
    %     vars.a.E(i) = a_xy * sind(vars.axes.yaw(i-1));

        vars.pos.N_desired(i) = vars.pos.N_desired(i-1);
        vars.pos.E_desired(i) = vars.pos.E_desired(i-1);
    end
end