function [d_path, t_path] =  Path_to_targets(targets, d_start, v_start, plot_path, color)
    d_path = 0;
    t_path = 0;
    for i = 1:size(targets,1)
        [d_to_target, t_to_target, v_out] = Path_to_next_target(v_start, d_start, targets(i, :), plot_path, color);
        d_path = d_path + d_to_target;
        t_path = t_path + t_to_target;
        d_start = targets(i, :);
        v_start = v_out;
    end
    hold off;
end