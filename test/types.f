
datatype nat =
    | Zero
    | Succ nat

datatype bool =
    | True
    | False

datatype natlist =
    | Nil
    | Cons nat natlist

datatype nattree =
    | Leaf nat
    | Branch nattree nattree

datatype order =
    | Smaller
    | Equal
    | Greater

