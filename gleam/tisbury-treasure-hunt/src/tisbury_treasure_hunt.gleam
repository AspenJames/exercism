import gleam/list

pub fn place_location_to_treasure_location(
  place_location: #(String, Int),
) -> #(Int, String) {
  let #(a, b) = place_location
  #(b, a)
}

pub fn treasure_location_matches_place_location(
  place_location: #(String, Int),
  treasure_location: #(Int, String),
) -> Bool {
  place_location_to_treasure_location(place_location) == treasure_location
}

pub fn count_place_treasures(
  place: #(String, #(String, Int)),
  treasures: List(#(String, #(Int, String))),
) -> Int {
  list.fold(treasures, 0, fn(count, treasure) {
    let #(_, treasure_loc) = treasure
    let #(_, place_loc) = place
    case treasure_location_matches_place_location(place_loc, treasure_loc) {
      True -> count + 1
      False -> count
    }
  })
}

pub fn special_case_swap_possible(
  found_treasure: #(String, #(Int, String)),
  place: #(String, #(String, Int)),
  desired_treasure: #(String, #(Int, String)),
) -> Bool {
  let #(ft_name, _) = found_treasure
  let #(place_name, _) = place
  let #(dt_name, _) = desired_treasure
  case ft_name {
    "Brass Spyglass" -> place_name == "Abandoned Lighthouse"
    "Amethyst Octopus" -> place_name == "Stormy Breakwater" && { dt_name == "Crystal Crab" || dt_name == "Glass Starfish" }
    "Vintage Pirate Hat" -> place_name == "Harbor Managers Office" && { dt_name == "Model Ship in Large Bottle" || dt_name == "Antique Glass Fishnet Float" }
    _ -> False
  }
}
