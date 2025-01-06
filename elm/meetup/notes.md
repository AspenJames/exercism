# Meetup

## Determining day of week

| IsLeap | Year | Day | DayIdx |
| --- | --- | --- | --- |
| F | 2025 | Wed | 2 |
| T | 2024 | Mon | 0 |
| F | 2023 | Sun | 6 |
| F | 2022 | Sat | 5 |
| F | 2021 | Fri | 4 |
| T | 2020 | Wed | 2 |
| F | 2019 | Tue | 1 |

* Leap year is highly significant
* If we know first day, we can calculate any other day
    * Only Jan is significant
* We need to find a relationship between year & day Jan starts with

## Look it up dummy

From [this website](https://artofmemory.com/blog/how-to-calculate-the-day-of-the-week/),

```
(Year Code + Month Code + Century Code + Date Number - Leap Year Code) mod 7
```

where

```
Year Code = (YY + (YY div 4)) mod 7
Month Code = Enum(033614625035) # From Jan -> Dec
Centry Code = Enum(4206420) # From 1700s -> 2300s
Date Number = Date of week # e.g. 17
Leap Year Code = IF Month is Jan or Feb AND is leap year Then -1 Else 0
```

