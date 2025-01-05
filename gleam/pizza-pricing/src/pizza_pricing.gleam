pub type Pizza {
  Margherita
  Caprese
  Formaggio
  ExtraSauce(Pizza)
  ExtraToppings(Pizza)
}

pub fn pizza_price(pizza: Pizza) -> Int {
  pizza_pricer(pizza, 0)
}

fn pizza_pricer(pizza: Pizza, price: Int) -> Int {
  case pizza {
    ExtraSauce(pizza1) -> pizza_pricer(pizza1, price + 1)
    ExtraToppings(pizza1) -> pizza_pricer(pizza1, price + 2)
    Margherita -> price + 7
    Caprese -> price + 9
    Formaggio -> price + 10
  }
}

pub fn order_price(order: List(Pizza)) -> Int {
  case order {
    [_] -> order_pricer(order, 3)
    [_, _] -> order_pricer(order, 2)
    _ -> order_pricer(order, 0)
  }
}

fn order_pricer(order: List(Pizza), price: Int) -> Int {
  case order {
    [] -> price
    [pizza, ..rest] -> order_pricer(rest, price + pizza_price(pizza))
  }
}
