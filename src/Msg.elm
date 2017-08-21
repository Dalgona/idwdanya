module Msg exposing (..)


import Time exposing (Time)


type Msg
  = StartOrder Int
  | CompleteOrder Int
  | CancelOrder
  | SetUse (Int -> Int -> Int) Int Int
  | Finish Int
  | FinishNow Int
  | HideVideo
  | HideIDW
  | Tick Time
