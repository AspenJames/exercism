module LuciansLusciousLasagna exposing (elapsedTimeInMinutes, expectedMinutesInOven, preparationTimeInMinutes)


expectedMinutesInOven =
    40


preparationTimeInMinutes layers =
    2 * layers


elapsedTimeInMinutes layers elapsed =
    preparationTimeInMinutes layers + elapsed
