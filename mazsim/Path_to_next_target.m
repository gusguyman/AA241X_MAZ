function [d_to_target, t_to_target, v_out] = Path_to_next_target(v_a, d_a, d_target, plot_path, color)
    %These are set by me, can change later
    r = 5;
    v_straight = 15; %m/s
    v_turn = 12; %m/s

    %Find turn direction (left or right)
    v_a_swap =[v_a(2), v_a(1)];
    v_target = d_target - d_a;
    int_target = dot(v_a/ norm(v_a), v_target) * v_a / norm(v_a) + d_a;
    v_int_target = d_target - int_target;
    mask = sign(sign(v_int_target) ./ sign(v_a_swap));
    mask(isnan(mask)) = -sign(sum(v_a));

    %Find center of turning circle
    v_d = v_a_swap .* mask;
    d_d = d_a + r*v_d / norm(v_d);

    %Find tangent points
    %Set the center of the circle and the target point
    x_c = d_d(1);
    y_c = d_d(2);
    x_p = d_target(1);
    y_p = d_target(2);
    x_d = x_p - x_c;
    y_d = y_p - y_c;

    %This is all really math-y, but basically you are using the 
    % equation of the circle and the line to find a polynomial
    % that depends on the unkown x coord of the tangent points
    % and the gradient k of the line. We want to find a k such
    % that the x points for that k are coincident (the same), which
    % happens for a quadratic ax^2 +bx + c = 0 when b=4ac. So use that
    % to find the two k option, then use those k values in the 
    % original quadratic to find the x coords, thenthe y coords. 
    % Voila! Tangent points and lines
    
    %Find the roots of the quadratic for k resulting from b=4ac
    a_k = 8*x_c*x_p + 4*y_d^2 - ...
        4 * (x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2) -...
        4*x_p^2;
    b_k = 8*y_d*x_d;
    c_k = 4*x_c^2 - 4 * (x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2);
    k = real(roots([a_k, b_k, c_k]));

    %plug k back into the original quadratic to find (x,y)
    a = (k.^2 + 1);
    b = -2*x_p*k.^2 + 2*y_d*k - 2*x_c;
    c = x_p^2*k.^2 - 2*x_p*y_d*k + ...
        x_c^2 + y_c^2 + y_p^2 -2*y_c*y_p - r^2;

    x = zeros(2,1);
    xr = real(roots([a(1) b(1) c(1)]));
    x(1) = xr(1);
    xr = real(roots([a(2) b(2) c(2)]));
    x(2) = xr(2);
    y = k .* (x - x_p) + y_p;

    %Identify which tangent point is correct
    v_both = [x_p - x, y_p - y];
%     ang_both = acosd(dot(-[v_d;v_d], v_both, 2) / r^2);
    ang_both_raw = atan2d(real(y) - d_d(2), real(x) - d_d(1));
    ang_start = atan2d(d_a(2) - d_d(2), d_a(1) - d_d(1));
    ang_both = mod([ang_start, ang_both_raw(1); ...
        ang_start, ang_both_raw(2)] * mask.', 360);
    [ang_min, ind_min] = min(ang_both);
    v_min = v_both(ind_min, :);

    %Find distance time 
    d_turn = ang_min*pi/180 * r;
    d_straight = sqrt((d_target(1) - x(ind_min))^ 2 +...
        (d_target(2) - y(ind_min))^ 2);
    t_turn = d_turn / v_turn;
    t_straight = d_straight / v_straight;
    d_to_target = d_turn + d_straight;
    t_to_target = t_turn + t_straight;
    v_out = v_min / norm(v_min);

    %Plot the path, if required.
    if plot_path
        hold on;
        v_up = [d_d(1), d_d(2)+r];
        ang_up = mod(...
            atan2d(v_up(2) - d_d(2), v_up(1) - d_d(1)) - ...
            atan2d(real(y(ind_min)) - d_d(2), real(x(ind_min)) - d_d(1))...
            , 360);
        beta = atan2d(real(y(ind_min)) - d_d(2), real(x(ind_min)) - d_d(1));
        gamma = atan2d(d_a(2) - d_d(2), d_a(1) - d_d(1));
        ang_step = mask(2) * 0.01;
        ang_end = mask(2)*mod(mask(2)*(beta-gamma),360) + ang_up;
        w=ang_up*pi/180:ang_step:ang_end*pi/180;
%         w=0:0.01:ang_up*pi/180+ang_min*pi/180;
        c = [x_c, y_c];
        l_h=line(c(1)+r*sin(w),c(2)+r*cos(w), 'color', color);
%         scatter(x(ind_min),y(ind_min));
%         scatter(x_p, y_p);
%         scatter(d_target(1), d_target(2));
%         plot([x_p, d_target(1)], [y_p, d_target(2)])
        xl = linspace(x(ind_min), x_p);
        yl = k(ind_min) * (xl - x_p) + y_p;
    %     xl = linspace(x(1), x_p);
    %     yl = k(1) * (xl - x_p) + y_p;
        plot(xl, yl, 'color', color)
    %     xl = linspace(x(2), x_p);
    %     yl = k(2) * (xl - x_p) + y_p;
    %     plot(xl, yl)
    %     scatter(d_a(1), d_a(2))
    %     plot([d_a(1), d_d(1)], [d_a(2), d_d(2)]);
    %     plot([x(1), d_d(1)], [y(1), d_d(2)]);
    %     plot([x(2), d_d(1)], [y(2), d_d(2)]);
    end
end
