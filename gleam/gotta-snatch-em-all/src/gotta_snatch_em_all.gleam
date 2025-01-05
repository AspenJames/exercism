import gleam/list
import gleam/set.{type Set}

pub fn new_collection(card: String) -> Set(String) {
  set.from_list([card])
}

pub fn add_card(collection: Set(String), card: String) -> #(Bool, Set(String)) {
  #(set.contains(collection, card), set.insert(collection, card))
}

pub fn trade_card(
  my_card: String,
  their_card: String,
  collection: Set(String),
) -> #(Bool, Set(String)) {
  #(
    set.contains(collection, my_card) && !set.contains(collection, their_card),
    collection
      |> set.insert(their_card)
      |> set.delete(my_card),
  )
}

pub fn boring_cards(collections: List(Set(String))) -> List(String) {
  case collections {
    [] -> []
    [_] -> []
    [first, ..rest] ->
      rest
      |> list.fold(first, fn(acc, coll) { set.intersection(acc, coll) })
      |> set.to_list
  }
}

pub fn total_cards(collections: List(Set(String))) -> Int {
  collections
  |> list.fold(set.new(), fn(acc, coll) { set.union(acc, coll) })
  |> set.size
}

pub fn shiny_cards(collection: Set(String)) -> Set(String) {
  collection
  |> set.filter(fn(card) {
    case card {
      "Shiny " <> _ -> True
      _ -> False
    }
  })
}
