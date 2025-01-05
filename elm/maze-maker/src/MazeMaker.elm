module MazeMaker exposing (..)

import Random exposing (Generator)


type Maze
    = DeadEnd
    | Room Treasure
    | Branch (List Maze)


type Treasure
    = Gold
    | Diamond
    | Friendship


deadend : Generator Maze
deadend =
    Random.constant DeadEnd


treasure : Generator Treasure
treasure =
    Random.uniform Gold [ Diamond, Friendship ]


room : Generator Maze
room =
    treasure |> Random.map Room


branch : Generator Maze -> Generator Maze
branch mazeGenerator =
    let
        branchOfLength len =
            Random.list len mazeGenerator |> Random.map Branch
    in
    Random.int 2 4
        |> Random.andThen branchOfLength


maze : Generator Maze
maze =
    Random.weighted
        ( 60, deadend )
        [ ( 15, room )
        , ( 25, Random.lazy (\_ -> branch maze) )
        ]
        |> Random.andThen identity


mazeOfDepth : Int -> Generator Maze
mazeOfDepth depth =
    if depth <= 0 then
        Random.uniform deadend [ room ]
            |> Random.andThen identity

    else
        branch <| mazeOfDepth <| depth - 1
