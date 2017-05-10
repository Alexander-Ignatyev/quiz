module Update exposing (..)

import Msgs exposing (Msg(..))
import Models exposing (Model, setAnswer)
import Routing exposing (parseLocation)
import Navigation


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
  case msg of
    Msgs.OnFetchTests response ->
      ( { model | testSuites = response }, Cmd.none )
    Msgs.OnLocationChange location ->
      let newRoute = parseLocation location
      in ( { model | route = newRoute }, Cmd.none )
    Msgs.OnOptionSelect testSuiteId testId optionId ->
      let answers = setAnswer testSuiteId testId optionId model.answers
      in ( { model | answers = answers }, Cmd.none )
    Msgs.AuthToken (Ok token) ->
      { model | authToken = Just token } ! [ Navigation.modifyUrl "#" ]
    Msgs.AuthToken (Err _) -> model ! [ ]
