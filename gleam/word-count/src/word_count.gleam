import gleam/dict.{type Dict}
import gleam/list
import gleam/option.{None, Some}
import gleam/regex
import gleam/string

pub fn count_words(input: String) -> Dict(String, Int) {
  let assert Ok(re) = regex.from_string("(?:\\s+|'(?!\\w)|\\W+)")
  input
  |> string.trim
  |> regex.split(re, _)
  |> list.fold(dict.new(), fn(acc, w) {
    case string.is_empty(w) {
      True -> acc
      False ->
        w
        |> string.lowercase
        |> dict.upsert(
          acc,
          _,
          fn(count) {
            case count {
              Some(c) -> c + 1
              None -> 1
            }
          },
        )
    }
  })
}
