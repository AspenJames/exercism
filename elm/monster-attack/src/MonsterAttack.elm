module MonsterAttack exposing (..)


type alias MonsterDamage =
    String


attackWithSword1 : MonsterDamage -> Int -> MonsterDamage
attackWithSword1 monsterDamage strength =
    monsterDamage ++ "Attacked with sword of strength " ++ String.fromInt strength ++ "."


attackWithClaw1 : MonsterDamage -> Int -> MonsterDamage
attackWithClaw1 monsterDamage strength =
    monsterDamage ++ "Attacked with claw of strength " ++ String.fromInt strength ++ "."


attack1 : MonsterDamage -> MonsterDamage
attack1 monsterDamage =
    -- attackWithSword1 (attackWithClaw1 (attackWithClaw1 (attackWithSword1 monsterDamage 5) 1) 1) 5
    let
        md1 =
            attackWithSword1 monsterDamage 5

        md2 =
            attackWithClaw1 md1 1

        md3 =
            attackWithClaw1 md2 1
    in
    attackWithSword1 md3 5


attackWithSword2 : Int -> MonsterDamage -> MonsterDamage
attackWithSword2 strength monsterDamage =
    attackWithSword1 monsterDamage strength


attackWithClaw2 : Int -> MonsterDamage -> MonsterDamage
attackWithClaw2 strength monsterDamage =
    attackWithClaw1 monsterDamage strength


attack2 : MonsterDamage -> MonsterDamage
attack2 monsterDamage =
    monsterDamage
        |> attackWithSword2 5
        |> attackWithClaw2 1
        |> attackWithClaw2 1
        |> attackWithSword2 5


attack3 : MonsterDamage -> MonsterDamage
attack3 =
    attackWithSword2 5
        >> attackWithClaw2 1
        >> attackWithClaw2 1
        >> attackWithSword2 5
