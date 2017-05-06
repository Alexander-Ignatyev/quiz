module Routing exposing (parseLocation)

import Navigation exposing (Location)
import Models exposing (Route(..))
import UrlParser exposing (..)


matchers : Parser (Route -> a) a
matchers = oneOf
  [ map TestSuitesRoute top
  , map TestSuiteRoute (s "suite" </> string)
  , map TestRoute (s "test" </> string </> int)
  ]


parseLocation : Location -> Route
parseLocation location = case (parseHash matchers location) of
  Just route -> route
  Nothing -> NotFoundRoute
