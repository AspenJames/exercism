module RobotSimulator exposing
    ( Bearing(..)
    , Robot
    , advance
    , defaultRobot
    , simulate
    , turnLeft
    , turnRight
    )


type Bearing
    = North
    | East
    | South
    | West


type alias Robot =
    { bearing : Bearing
    , coordinates : { x : Int, y : Int }
    }


defaultRobot : Robot
defaultRobot =
    { bearing = North
    , coordinates = { x = 0, y = 0 }
    }


turnRight : Robot -> Robot
turnRight robot =
    { robot
        | bearing =
            case robot.bearing of
                North ->
                    East

                East ->
                    South

                South ->
                    West

                West ->
                    North
    }


turnLeft : Robot -> Robot
turnLeft robot =
    { robot
        | bearing =
            case robot.bearing of
                North ->
                    West

                East ->
                    North

                South ->
                    East

                West ->
                    South
    }


advance : Robot -> Robot
advance robot =
    case ( robot.bearing, robot.coordinates ) of
        ( North, { x, y } ) ->
            { robot | coordinates = { x = x, y = y + 1 } }

        ( East, { x, y } ) ->
            { robot | coordinates = { x = x + 1, y = y } }

        ( South, { x, y } ) ->
            { robot | coordinates = { x = x, y = y - 1 } }

        ( West, { x, y } ) ->
            { robot | coordinates = { x = x - 1, y = y } }


simulate : String -> Robot -> Robot
simulate directions robot =
    let
        perform direction =
            case direction of
                'R' ->
                    turnRight

                'L' ->
                    turnLeft

                'A' ->
                    advance

                -- Ignore invalid input
                _ ->
                    identity
    in
    String.foldl perform robot directions
