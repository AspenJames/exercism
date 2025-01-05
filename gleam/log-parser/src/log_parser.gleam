import gleam/option
import gleam/regex

pub fn is_valid_line(line: String) -> Bool {
  let assert Ok(re) =
    regex.from_string("^\\[(?:DEBUG|INFO|WARNING|ERROR)\\] \\w*")
  regex.check(re, line)
}

pub fn split_line(line: String) -> List(String) {
  let assert Ok(re) = regex.from_string("<[~*=-]*>")
  regex.split(re, line)
}

pub fn tag_with_user_name(line: String) -> String {
  let assert Ok(re) = regex.from_string("\\w*User\\s+(\\S+)")
  case regex.scan(re, line) {
    [] -> line
    [match, ..] ->
      case match.submatches {
        [] -> line
        [submatch, ..] ->
          "[USER] " <> option.unwrap(submatch, "") <> " " <> line
      }
  }
}
