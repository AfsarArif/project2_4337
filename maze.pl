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