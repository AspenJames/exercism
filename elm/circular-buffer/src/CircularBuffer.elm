module CircularBuffer exposing (CircularBuffer, clear, new, overwrite, read, write)


type CircularBuffer a
    = CircularBuffer { buf : List (Maybe a), readIdx : Int, writeIdx : Int }


nextIdx buf idx =
    if List.length buf - 1 == idx then
        0

    else
        idx + 1


new : Int -> CircularBuffer a
new size =
    CircularBuffer { buf = List.repeat size Nothing, readIdx = 0, writeIdx = 0 }


write : a -> CircularBuffer a -> Maybe (CircularBuffer a)
write element buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            case List.drop writeIdx buf |> List.head of
                Nothing ->
                    Nothing

                Just n ->
                    case n of
                        Nothing ->
                            let
                                nextBuf =
                                    List.concat
                                        [ List.take writeIdx buf
                                        , [ Just element ]
                                        , List.drop (writeIdx + 1) buf
                                        ]
                            in
                            Just <| CircularBuffer { buf = nextBuf, readIdx = readIdx, writeIdx = writeIdx |> nextIdx buf }

                        Just m ->
                            Nothing


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
                                , [ Just element ]
                                , List.drop (writeIdx + 1) buf
                                ]
                    in
                    CircularBuffer { buf = nextBuf, readIdx = readIdx, writeIdx = writeIdx |> nextIdx buf }


read : CircularBuffer a -> Maybe ( a, CircularBuffer a )
read buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            case List.drop readIdx buf |> List.head of
                Nothing ->
                    Nothing

                Just n ->
                    let
                        _ =
                            buf |> Debug.log "read n: "

                        nextBuf =
                            List.concat
                                [ List.take readIdx buf
                                , [ Nothing ]
                                , List.drop (readIdx + 1) buf
                                ]
                                |> Debug.log "nextBuf on read: "
                    in
                    case n of
                        Nothing ->
                            Nothing

                        Just m ->
                            Just ( m, CircularBuffer { buf = nextBuf, readIdx = readIdx |> nextIdx buf, writeIdx = readIdx |> nextIdx buf } )


clear : CircularBuffer a -> CircularBuffer a
clear buffer =
    case buffer of
        CircularBuffer { buf, readIdx, writeIdx } ->
            CircularBuffer { buf = List.repeat (List.length buf + 1) Nothing, readIdx = 0, writeIdx = 0 }
