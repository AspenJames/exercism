import gleam/option.{type Option, None, Some}

pub type Player {
  Player(name: Option(String), level: Int, health: Int, mana: Option(Int))
}

pub fn introduce(player: Player) -> String {
  case player.name {
    Some(n) -> n
    None -> "Mighty Magician"
  }
}

pub fn revive(player: Player) -> Option(Player) {
  case player.health {
    0 ->
      case player.level >= 10 {
        True -> Some(Player(..player, health: 100, mana: Some(100)))
        False -> Some(Player(..player, health: 100))
      }
    _ -> None
  }
}

pub fn cast_spell(player: Player, cost: Int) -> #(Player, Int) {
  case player.mana {
    None -> #(do_damage(player, cost), 0)
    Some(mana) ->
      case mana >= cost {
        True -> #(Player(..player, mana: Some(mana - cost)), 2 * cost)
        False -> #(player, 0)
      }
  }
}

fn do_damage(player: Player, damage: Int) -> Player {
  case player.health >= damage {
    True -> Player(..player, health: player.health - damage)
    False -> Player(..player, health: 0)
  }
}
