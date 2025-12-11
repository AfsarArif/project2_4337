find_exit(Maze) :-
    find_exit(Maze, _).

find_exit(Maze, Actions) :-
    valid_maze(Maze),
    start_position(Maze, SR, SC),
    follow_actions(Maze, SR, SC, Actions, ER, EC),
    cell_at(Maze, ER, EC, e).