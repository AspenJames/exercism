module TicketPlease exposing (..)

import TicketPleaseSupport exposing (Status(..), Ticket(..), User(..))


emptyComment : ( User, String ) -> Bool
emptyComment ( _, comment ) =
    comment == ""


numberOfCreatorComments : Ticket -> Int
numberOfCreatorComments (Ticket { createdBy, comments }) =
    let
        ( creator, _ ) =
            createdBy
    in
    comments
        |> List.foldl
            (\( user, _ ) ->
                \count ->
                    if user == creator then
                        count + 1

                    else
                        count
            )
            0


assignedToDevTeam : Ticket -> Bool
assignedToDevTeam (Ticket { assignedTo }) =
    case assignedTo of
        Nothing ->
            False

        Just user ->
            case user of
                User "Alice" ->
                    True

                User "Bob" ->
                    True

                User "Charlie" ->
                    True

                _ ->
                    False


assignTicketTo : User -> Ticket -> Ticket
assignTicketTo user (Ticket ({ status } as ticket)) =
    case status of
        Archived ->
            Ticket ticket

        New ->
            Ticket { ticket | status = InProgress, assignedTo = Just user }

        _ ->
            Ticket { ticket | assignedTo = Just user }
