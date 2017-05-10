module Main exposing (..)

import Navigation exposing (Location)

import Msgs exposing (Msg)
import Models exposing (Model, initialModel)
import Update exposing (update)
import View exposing (view)
import Commands exposing (fetchTests)
import Routing
import Auth


init : Location -> (Model, Cmd Msg)
init location =
  let route = Routing.parseLocation location
  in initialModel route location.href ! [ fetchTests, Auth.init location Msgs.AuthToken ]


subscriptions : Model -> Sub Msg
subscriptions model = Sub.none


main : Program Never Model Msg
main = Navigation.program Msgs.OnLocationChange
  { init = init
  , view = view
  , update = update
  , subscriptions = subscriptions
  }
