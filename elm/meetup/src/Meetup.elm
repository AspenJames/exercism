module Meetup exposing (Month(..), Week(..), Weekday(..), meetup)


type Month
    = January
    | February
    | March
    | April
    | May
    | June
    | July
    | August
    | September
    | October
    | November
    | December


type Weekday
    = Monday
    | Tuesday
    | Wednesday
    | Thursday
    | Friday
    | Saturday
    | Sunday


type Week
    = First
    | Second
    | Third
    | Fourth
    | Last
    | Teenth


{-| Determine if given year is a leap year
-}
isLeapYear : Int -> Bool
isLeapYear year =
    modBy 400 year == 0 || modBy 100 year /= 0 && modBy 4 year == 0


{-| Determine weekday for given date, based on the formula outlined at
<https://artofmemory.com/blog/how-to-calculate-the-day-of-the-week/>
-}
dayOfWeek : Int -> Month -> Int -> Weekday
dayOfWeek year month date =
    let
        -- yyYY
        y1 : Int
        y1 =
            year |> modBy 100

        -- YYyy
        y2 : Int
        y2 =
            (year - (year |> modBy 100)) // 100

        yearCode : Int
        yearCode =
            (y1 + (y1 // 4)) |> modBy 7

        monthCode : Int
        monthCode =
            case month of
                January ->
                    0

                February ->
                    3

                March ->
                    3

                April ->
                    6

                May ->
                    1

                June ->
                    4

                July ->
                    6

                August ->
                    2

                September ->
                    5

                October ->
                    0

                November ->
                    3

                December ->
                    5

        centuryCode : Int
        centuryCode =
            case y2 of
                17 ->
                    4

                18 ->
                    2

                19 ->
                    0

                20 ->
                    6

                21 ->
                    4

                22 ->
                    2

                23 ->
                    0

                -- May be inaccurate <1700s or >2300s
                _ ->
                    0

        leapYearCode : Int
        leapYearCode =
            case ( isLeapYear year, month ) of
                ( True, January ) ->
                    -1

                ( True, February ) ->
                    -1

                _ ->
                    0

        dayFromCode : Int -> Weekday
        dayFromCode idx =
            case idx of
                1 ->
                    Monday

                2 ->
                    Tuesday

                3 ->
                    Wednesday

                4 ->
                    Thursday

                5 ->
                    Friday

                6 ->
                    Saturday

                _ ->
                    Sunday
    in
    (yearCode + monthCode + centuryCode + date + leapYearCode)
        |> modBy 7
        |> dayFromCode


meetup : Int -> Month -> Week -> Weekday -> String
meetup year month week weekday =
    let
        -- Number of days in a given month.
        nDays : Int
        nDays =
            case month of
                January ->
                    31

                February ->
                    if isLeapYear year then
                        29

                    else
                        28

                March ->
                    31

                April ->
                    30

                May ->
                    31

                June ->
                    30

                July ->
                    31

                August ->
                    31

                September ->
                    30

                October ->
                    31

                November ->
                    30

                December ->
                    31

        -- Integer list representation of our candidate week.
        dateCandidates : List Int
        dateCandidates =
            case week of
                First ->
                    List.range 1 7

                Second ->
                    List.range 8 14

                Third ->
                    List.range 15 21

                Fourth ->
                    List.range 22 28

                Last ->
                    List.range (nDays - 6) nDays

                Teenth ->
                    List.range 13 19

        -- Does the weekday of a given date equal the target weekday?
        isCorrectWeekday : Int -> Bool
        isCorrectWeekday =
            dayOfWeek year month >> (==) weekday

        date : Int
        date =
            dateCandidates
                |> List.filter isCorrectWeekday
                |> List.head
                |> Maybe.withDefault 0
    in
    String.fromInt year ++ "-" ++ monthToString month ++ "-" ++ dateToString date


monthToString : Month -> String
monthToString month =
    case month of
        January ->
            "01"

        February ->
            "02"

        March ->
            "03"

        April ->
            "04"

        May ->
            "05"

        June ->
            "06"

        July ->
            "07"

        August ->
            "08"

        September ->
            "09"

        October ->
            "10"

        November ->
            "11"

        December ->
            "12"


dateToString : Int -> String
dateToString i =
    if i < 10 then
        "0" ++ String.fromInt i

    else
        String.fromInt i
