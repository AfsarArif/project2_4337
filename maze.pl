find_exit(Maze) :-
    find_exit(Maze, _).

find_exit(Maze, Actions) :-
    valid_maze(Maze),
    start_position(Maze, SR, SC),
    follow_actions(Maze, SR, SC, Actions, ER, EC),
    cell_at(Maze, ER, EC, e).

valid_maze(Maze) :-
    is_list(Maze),
    Maze \= [],

    % all rows must be lists
    maplist(is_list, Maze),

    % ensure rectangular
    Maze = [Row0 | _],
    length(Row0, Cols),
    Cols > 0,
    maplist(same_length(Cols), Maze),

    % exactly one start
    findall((R,C), cell_at(Maze, R, C, s), Starts),
    length(Starts, 1),

    % at least one exit
    findall((R,C), cell_at(Maze, R, C, e), Exits),
    Exits \= [].

same_length(N, Row) :- length(Row, N).

cell_at(_, _, _, n) :- !, fail.

cell_at(Maze, R, C, V) :-
    nth0(R, Maze, Row),
    nth0(C, Row, V).

start_position(Maze, R, C) :-
    cell_at(Maze, R, C, s).

follow_actions(_, R, C, [], R, C).

follow_actions(Maze, R, C, [Move | Rest], ER, EC) :-
    step(Maze, R, C, Move, R2, C2),
    follow_actions(Maze, R2, C2, Rest, ER, EC).

step(Maze, R, C, Move, R2, C2) :-
    delta(Move, DR, DC),
    R2 is R + DR,
    C2 is C + DC,

    % Must stay in bounds
    in_bounds(Maze, R2, C2),

    % Must not hit a wall
    cell_at(Maze, R2, C2, Cell),
    Cell \= w.

% Movement direction deltas
delta(left,  0, -1).
delta(right, 0,  1).
delta(up,   -1,  0).
delta(down,  1,  0).
