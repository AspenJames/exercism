pub fn today(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [d, ..] -> d
  }
}

pub fn increment_day_count(days: List(Int)) -> List(Int) {
  case days {
    [] -> [1]
    [d, ..rest] -> [d + 1, ..rest]
  }
}

pub fn has_day_without_birds(days: List(Int)) -> Bool {
  case days {
    [] -> False
    [0, ..] -> True
    [_, ..rest] -> has_day_without_birds(rest)
  }
}

pub fn total(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [d, ..rest] -> d + total(rest)
  }
  // Using gleam/list:
  // list.fold(days, 0, fn(count, d) { count + d })
}

pub fn busy_days(days: List(Int)) -> Int {
  case days {
    [] -> 0
    [d, ..rest] if d >= 5 -> 1 + busy_days(rest)
    [_, ..rest] -> busy_days(rest)
  }
  // Using gleam/list:
  // list.fold(days, 0, fn(count, d) {
  //   case d >= 5 {
  //     True -> count + 1
  //     False -> count
  //   }
  // })
}
