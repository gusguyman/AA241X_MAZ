function [order, time, distance] = Find_best_path(targets, d_start, v_start, plot_num)
    colors = lines(plot_num);
    N = size(targets, 1);
    %Find all the permutations of the target sequence
    orders = perms(1:N);
    M = size(orders,1);
    times = zeros(M,1);
    distances = zeros(M,1);
    %Find the times and distances for each path permutation
    for i = 1:M
        [d_path, t_path] =  Path_to_targets(targets(orders(i, :), :), d_start, v_start, 0, [0, 0, 0]);
        times(i) = t_path;
        distances(i) = d_path;
    end
    %Sort by time
    [sorted_t, sort_idxs] = sort(times);
    sorted_d = distances(sort_idxs);
    sorted_orders = orders(sort_idxs, :);
    %Return the order and stats for the best time
    order = sorted_orders(1, :);
    time = sorted_t(1);
    distance = sorted_d(1);
    %Plot the top plot_num paths
    if plot_num ~= 0
        figure;
        hold on;
        r = 10;
        for i = 1:(min(plot_num, M))
            Path_to_targets(targets(sorted_orders(i, :), :), d_start, v_start,...
                1, colors(i, :));
        end
    %     legend('show')
        for i = 1:N
            w=0:0.01:2*pi;
            c = targets(i, :);
            l_h=line(c(1)+r*sin(w),c(2)+r*cos(w), 'color', [0 0 0]);
        end
    end

end
