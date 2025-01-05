import gleam/list

pub type Usd

pub type Eur

pub type Jpy

pub opaque type Money(currency) {
  Money(amount: Int)
}

pub fn dollar(amount: Int) -> Money(Usd) {
  // let dollar: Money(Usd) = Money(amount)
  Money(amount)
}

pub fn euro(amount: Int) -> Money(Eur) {
  // let euro: Money(Eur) = Money(amount)
  Money(amount)
}

pub fn yen(amount: Int) -> Money(Jpy) {
  // let yen: Money(Jpy) = Money(amount)
  Money(amount)
}

pub fn total(prices: List(Money(currency))) -> Money(currency) {
  prices
  |> list.fold(0, fn(acc, curr) { acc + curr.amount })
  |> Money
}
