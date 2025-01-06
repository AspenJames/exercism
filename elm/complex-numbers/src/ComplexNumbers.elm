module ComplexNumbers exposing
    ( Complex
    , abs
    , add
    , conjugate
    , div
    , exp
    , fromPair
    , fromReal
    , imaginary
    , mul
    , real
    , sub
    )


type Complex
    = Complex ( Float, Float )


fromPair : ( Float, Float ) -> Complex
fromPair pair =
    Complex pair


fromReal : Float -> Complex
fromReal float =
    fromPair ( float, 0 )


real : Complex -> Float
real (Complex ( a, _ )) =
    a


imaginary : Complex -> Float
imaginary (Complex ( _, b )) =
    b


conjugate : Complex -> Complex
conjugate (Complex ( a, b )) =
    Complex ( a, negate b )


abs : Complex -> Float
abs (Complex ( a, b )) =
    sqrt (a ^ 2 + b ^ 2)


add : Complex -> Complex -> Complex
add (Complex ( a, b )) (Complex ( c, d )) =
    Complex ( a + c, b + d )


sub : Complex -> Complex -> Complex
sub (Complex ( a, b )) (Complex ( c, d )) =
    Complex ( a - c, b - d )


mul : Complex -> Complex -> Complex
mul (Complex ( a, b )) (Complex ( c, d )) =
    Complex ( a * c - b * d, b * c + a * d )


div : Complex -> Complex -> Complex
div (Complex ( a, b )) (Complex ( c, d )) =
    Complex ( (a * c + b * d) / (c ^ 2 + d ^ 2), (b * c - a * d) / (c ^ 2 + d ^ 2) )


exp : Complex -> Complex
exp (Complex ( a, b )) =
    Complex ( e ^ a * cos b, e ^ a * sin b )
