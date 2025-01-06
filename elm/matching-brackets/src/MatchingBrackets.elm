module MatchingBrackets exposing (isPaired)


isPaired : String -> Bool
isPaired input =
    input
        |> String.toList
        |> isBalanced []


isPair : Char -> Char -> Bool
isPair close open =
    case close of
        ']' ->
            open == '['

        '}' ->
            open == '{'

        ')' ->
            open == '('

        _ ->
            False


isOpen : Char -> Bool
isOpen c =
    List.member c [ '[', '{', '(' ]


isClose : Char -> Bool
isClose c =
    List.member c [ ']', '}', ')' ]


isBalanced : List Char -> List Char -> Bool
isBalanced state input =
    case input of
        [] ->
            List.isEmpty state

        x :: xs ->
            if isOpen x then
                isBalanced (x :: state) xs

            else if isClose x then
                case state of
                    [] ->
                        False

                    y :: ys ->
                        if isPair x y then
                            isBalanced ys xs

                        else
                            False

            else
                isBalanced state xs
