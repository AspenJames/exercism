import gleam/list

pub fn new_list() -> List(String) {
  []
}

pub fn existing_list() -> List(String) {
  ["Gleam", "Go", "TypeScript"]
}

pub fn add_language(languages: List(String), language: String) -> List(String) {
  [language, ..languages]
}

pub fn count_languages(languages: List(String)) -> Int {
  //list.fold(languages, 0, fn(count, _) { count + 1 })
  case languages {
    [] -> 0
    [_] -> 1
    [_, ..rest] -> 1 + count_languages(rest)
  }
}

pub fn reverse_list(languages: List(String)) -> List(String) {
  list.fold(languages, [], fn(new_list, e) { [e, ..new_list] })
}

pub fn exciting_list(languages: List(String)) -> Bool {
  case languages {
    ["Gleam", .._] -> True
    [_, "Gleam"] -> True
    [_, "Gleam", _] -> True
    _ -> False
  }
}
