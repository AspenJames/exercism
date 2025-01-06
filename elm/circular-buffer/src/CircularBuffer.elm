module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


type CircularBuffer a
    = CircularBuffer { buf : List (Cell a), readIdx : Int, writeIdx : Int }


type Cell a
    = Empty
    | Cell a


{-| Get next index, wrapping back to 0 if at end
-}
nextIdx : List (Cell a) -> Int -> Int
nextIdx buf idx =
    if List.length buf - 1 == idx then
        0

    else
        idx + 1


{-| New, empty CircularBuffer
-}
new : Int -> CircularBuffer a
new size =
    CircularBuffer { buf = List.repeat size Empty, readIdx = 0, writeIdx = 0 }


{-| Write element to buffer if an empty cell is available.
-}
write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write element buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            let
                nextBuf =
                    List.concat
                        [ List.take writeIdx buf
                        , [ Cell element ]
                        , List.drop (writeIdx + 1) buf
                        ]

                nextWriteIdx =
                    writeIdx |> nextIdx buf

                nextBuffer =
                    CircularBuffer { buf = nextBuf, readIdx = readIdx, writeIdx = nextWriteIdx }
            in
            case List.drop writeIdx buf |> List.head of
                Nothing ->
                    Nothing

                Just n ->
                    case n of
                        Empty ->
                            Just <| nextBuffer

                        Cell _ ->
                            Nothing


{-| Write element to buffer, overwriting oldest cell if no empty cell exists.
-}
overwrite : a -> CircularBuffer a -> CircularBuffer a
overwrite element buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            case List.drop writeIdx buf |> List.head of
                Nothing ->
                    buffer

                Just n ->
                    let
                        nextBuf =
                            List.concat
                                [ List.take writeIdx buf
                                , [ Cell element ]
                                , List.drop (writeIdx + 1) buf
                                ]

                        nextWriteIdx =
                            writeIdx |> nextIdx buf

                        -- Only advance read index if we're actually
                        -- overwriting a cell
                        nextReadIdx =
                            case n of
                                Empty ->
                                    readIdx

                                Cell _ ->
                                    readIdx |> nextIdx buf
                    in
                    CircularBuffer { buf = nextBuf, readIdx = nextReadIdx, writeIdx = nextWriteIdx }


{-| Read an element from buffer, if an element exists.
-}
read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            let
                nextBuf =
                    List.concat
                        [ List.take readIdx buf
                        , [ Empty ]
                        , List.drop (readIdx + 1) buf
                        ]

                nextReadIdx =
                    readIdx |> nextIdx buf

                nextBuffer =
                    CircularBuffer { buf = nextBuf, readIdx = nextReadIdx, writeIdx = writeIdx }
            in
            case List.drop readIdx buf |> List.head of
                Nothing ->
                    Nothing

                Just n ->
                    case n of
                        Empty ->
                            Nothing

                        Cell m ->
                            Just ( m, nextBuffer )


{-| Empty all cells of buffer
-}
clear : CircularBuffer a -> CircularBuffer a
clear buffer =
    case buffer of
        CircularBuffer { buf } ->
            new <| List.length buf
