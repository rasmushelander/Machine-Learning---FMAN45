function [state_action_feats, prev_grid, prev_head_loc] = extract_state_action_features(prev_grid, grid, prev_head_loc, nbr_feats)
%
% Code may be changed in this function, but only where it states that it is 
% allowed to do so.
%
% Function to extract state-action features, based on current and previous
% grids (game screens).
%
% Input:
%
% prev_grid     - Previous grid (game screen), N-by-N matrix. If initial
%                 time-step: prev_grid = grid, else: prev_grid != grid.
% grid          - Current grid (game screen), N-by-N matrix. If initial
%                 time-step: prev_grid = grid, else: prev_grid != grid.
% prev_head_loc - The previous location of the head of the snake (from the 
%                 previous time-step). If initial time-step: Assumed known,
%                 else: inferred in function "update_snake_grid.m" (so in
%                 practice it will always be known in this function).
% nbr_feats     - Number of state-action features per action. Set this 
%                 value appropriately in the calling script "snake.m", to
%                 match the number of state-action features per action you
%                 end up using.
%
% Output:
%
% state_action_feats - nbr_feats-by-|A| matrix, where |A| = number of
%                      possible actions (|A| = 3 in Snake), and nbr_feats
%                      is described under "Input" above. This matrix
%                      represents the state-action features extracted given
%                      the current and previous grids (game screens).
% prev_grid          - The previous grid as seen from one step in the
%                      future, i.e., prev_grid is set to the input grid.
% prev_head_loc      - The previous head location as seen from one step
%                      in the future, i.e., prev_head_loc is set to the
%                      current head location (the current head location is
%                      inferred in the code below).
%
% Bugs, ideas etcetera: send them to the course email.

% --------- DO NOT CHANGE ANYTHING BELOW UNLESS OTHERWISE NOTIFIED! -------

% Extract grid size.
N = size(grid, 1);

% Initialize state_action_feats to nbr_feats-by-3 matrix.
state_action_feats = nan(nbr_feats, 3);

% Based on how grid looks now and at previous time step, infer head
% location.
change_grid = grid - prev_grid;
prev_grid   = grid; % Used in later calls to "extract_state_action_features.m"

% Find head location (initially known that it is in center of grid).
if nnz(change_grid) > 0 % True, except in initial time-step
    [head_loc_m, head_loc_n] = find(change_grid > 0);
else % True only in initial time-step
    head_loc_m = round(N / 2);
    head_loc_n = round(N / 2);
end
head_loc = [head_loc_m, head_loc_n];

% Previous head location.
prev_head_loc_m = prev_head_loc(1);
prev_head_loc_n = prev_head_loc(2);

% Infer current movement directory (N/E/S/W) by looking at how current and previous
% head locations are related
if prev_head_loc_m == head_loc_m + 1 && prev_head_loc_n == head_loc_n     % NORTH
    movement_dir = 1;
elseif prev_head_loc_m == head_loc_m && prev_head_loc_n == head_loc_n - 1 % EAST
    movement_dir = 2;
elseif prev_head_loc_m == head_loc_m - 1 && prev_head_loc_n == head_loc_n % SOUTH
    movement_dir = 3;
else                                                                      % WEST
    movement_dir = 4;
end

% The current head_loc will at the next time-step be prev_head_loc.
prev_head_loc = head_loc;

% ------------- YOU MAY CHANGE SETTINGS BELOW! --------------------------

% HERE BEGINS YOUR STATE-ACTION FEATURE ENGINEERING. THE CODE BELOW IS 
% ALLOWED TO BE CHANGED IN ACCORDANCE WITH YOUR CHOSEN FEATURES. 
% Some skeleton code is provided to help you get started. Also, have a 
% look at the function "get_next_info" (see bottom of this function).
% You may find it useful.

for action = 1 : 3 % Evaluate all the different actions (left, forward, right).
    
    % Feel free to uncomment below line of code if you find it useful.
    %[next_head_loc, next_move_dir] = get_next_info(action, movement_dir, head_loc);
    
    % Replace this to fit the number of state-action features per features
    % you choose (3 are used below), and of course replace the randn() 
    % by something more sensible.
    [apple_loc_r, apple_loc_c] = find(grid == -1); 
    apple_loc = [apple_loc_r, apple_loc_c]; 
    [next_head_loc, next_move_dir] = get_next_info(action, movement_dir, head_loc); 
    dist = norm(next_head_loc-apple_loc,1);
    max = norm(size(grid), 1);
    state_action_feats(1, action) = dist/max; % normalized l1 distance to apple
    
    state_action_feats(2, action) = grid(next_head_loc(1), next_head_loc(2));
    
    [f, n] = bwlabel(grid == 0, 8) ;
    z = sum(grid == 0, 'all');
    if n <=  1
        s = 0;
    else 
        c = f(next_head_loc(1), next_head_loc(2)); 
        if c == 0
            s = 0; 
        else 
            s = (f == c);
            s = sum(s, 'all');
            if s < z / n
                s = 1;
            else
                s = 0; 
            end 
        end 
    end 
    state_action_feats(3, action) = s; 
    
%     if next_move_dir == 1 
%         idx = next_head_loc;   
%         idx(1) = idx(1) - 1; 
%         i = grid(idx(1), idx(2));
%         d = d + 1;
%             
%        
%     elseif next_move_dir == 2
%         idx = next_head_loc;
%         i = 0; 
%         d = 0; 
%         if grid(idx(1), idx(2)) == 0
%             while i == 0
%                 idx(2) = idx(2) + 1; 
%                 i = grid(idx(1), idx(2));
%                 d = d + 1;
%             end  
%         end
%     elseif next_move_dir == 3
%         idx = next_head_loc;
%         i = 0; 
%         d = 0; 
%         if grid(idx(1), idx(2)) == 0
%             while i == 0
%                 idx(1) = idx(1) + 1; 
%                 i = grid(idx(1), idx(2));
%                 d = d + 1;
%             end 
%         end
%     elseif next_move_dir == 4
%         idx = next_head_loc;
%         i = 0; 
%         d = 0; 
%         if grid(idx(1), idx(2)) == 1 & 
%             while i == 0
%                 idx(2) = idx(2) - 1; 
%                 i = grid(idx(1), idx(2));
%                 d = d + 1;
%             end 
%         end
%     end 
%     s =  size(grid); 
%     s = s(1); 
%     d  = d / s;
%     d = d(1); 
%     
%     i1 = next_head_loc + [1,0]; 
%     i2 = next_head_loc + [-1,0]; 
%     i3 = next_head_loc + [0, 1]; 
%     i4 = next_head_loc + [0,-1]; 
%     n = 0;
%     if grid(next_head_loc(1), next_head_loc(2)) == 0
%         if grid(i1(1), i1(2)) == 1
%             n = n + 1; 
%         end 
%         if grid(i2(1), i2(2)) == 1
%             n = n + 1; 
%         end
%         if grid(i3(1), i3(2)) == 1
%             n = n + 1; 
%         end
%         if grid(i4(1), i4(2)) == 1
%             n = n + 1; 
%         end
%     end 
%     n = n -1; 
%     n = n / 3; 
%     
%     state_action_feats(3, action) = n;
    
    % ... and so on ...
end
end

%
% DO NOT CHANGE ANYTHING IN THE FUNCTION get_next_info BELOW!
%
function [next_head_loc, next_move_dir] = get_next_info(action, movement_dir, head_loc)
% Function to infer next haed location and movement direction

% Extract relevant stuff
head_loc_r = head_loc(1);
head_loc_c = head_loc(2);

if movement_dir == 1 % NORTH
    if action == 1     % left
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c - 1;
        next_move_dir   = 4; 
    elseif action == 2 % forward
        next_head_loc_r = head_loc_r - 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 1;
    else               % right
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c + 1;
        next_move_dir   = 2;
    end
elseif movement_dir == 2 % EAST
    if action == 1
        next_head_loc_r = head_loc_r - 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 1;
    elseif action == 2
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c + 1;
        next_move_dir   = 2;
    else
        next_head_loc_r = head_loc_r + 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 3;
    end
elseif movement_dir == 3 % SOUTH
    if action == 1
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c + 1;
        next_move_dir   = 2;
    elseif action == 2
        next_head_loc_r = head_loc_r + 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 3;
    else
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c - 1;
        next_move_dir   = 4;
    end
else % WEST
    if action == 1
        next_head_loc_r = head_loc_r + 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 3;
    elseif action == 2
        next_head_loc_r = head_loc_r;
        next_head_loc_c = head_loc_c - 1;
        next_move_dir   = 4;
    else
        next_head_loc_r = head_loc_r - 1;
        next_head_loc_c = head_loc_c;
        next_move_dir   = 1;
    end
end
next_head_loc = [next_head_loc_r, next_head_loc_c];
end
