import gleam/dict
import gleam/list

pub opaque type Set(t) {
  Set(vals: dict.Dict(t, Nil))
}

pub fn new(members: List(t)) -> Set(t) {
  members
  |> list.fold(dict.new(), fn(vals, el) { dict.insert(vals, el, Nil) })
  |> Set
}

pub fn is_empty(set: Set(t)) -> Bool {
  dict.size(set.vals) == 0
}

pub fn contains(in set: Set(t), this member: t) -> Bool {
  set.vals
  |> dict.has_key(member)
}

pub fn is_subset(first: Set(t), of second: Set(t)) -> Bool {
  first.vals
  |> dict.keys
  |> list.all(fn(m) { second.vals |> dict.keys |> list.contains(m) })
}

pub fn disjoint(first: Set(t), second: Set(t)) -> Bool {
  first.vals
  |> dict.keys
  |> list.filter(fn(m) { second.vals |> dict.keys |> list.contains(m) })
  |> list.is_empty
}

pub fn is_equal(first: Set(t), to second: Set(t)) -> Bool {
  first.vals == second.vals
}

pub fn add(to set: Set(t), this member: t) -> Set(t) {
  set.vals
  |> dict.insert(member, Nil)
  |> Set
}

pub fn intersection(of first: Set(t), and second: Set(t)) -> Set(t) {
  first.vals
  |> dict.keys
  |> list.filter(fn(m) { second.vals |> dict.keys |> list.contains(m) })
  |> list.map(fn(m) { #(m, Nil) })
  |> dict.from_list
  |> Set
}

pub fn difference(between first: Set(t), and second: Set(t)) -> Set(t) {
  first.vals
  |> dict.keys
  |> list.filter(fn(m) { !{ second.vals |> dict.keys |> list.contains(m) } })
  |> list.map(fn(m) { #(m, Nil) })
  |> dict.from_list
  |> Set
}

pub fn union(of first: Set(t), and second: Set(t)) -> Set(t) {
  dict.merge(first.vals, second.vals) |> Set
}
