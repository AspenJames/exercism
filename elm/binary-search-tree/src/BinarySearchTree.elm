module BinarySearchTree exposing (BinaryTree(..), makeTree, sort)


type BinaryTree
    = Empty
    | Tree BinaryTree Int BinaryTree


insert : Int -> BinaryTree -> BinaryTree
insert i tree =
    case tree of
        Empty ->
            Tree Empty i Empty

        Tree left n right ->
            if i > n then
                Tree left n (insert i right)

            else
                Tree (insert i left) n right


toList : BinaryTree -> List Int
toList tree =
    case tree of
        Empty ->
            []

        Tree left n right ->
            toList left ++ [ n ] ++ toList right


makeTree : List Int -> BinaryTree
makeTree =
    List.foldl insert Empty


sort : List Int -> List Int
sort =
    makeTree >> toList
