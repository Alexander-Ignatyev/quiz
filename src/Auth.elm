module Auth exposing (Token, googleAuthUrl, init)

import OAuth
import OAuth.Config
import Navigation
import Http
import String


type alias Token = OAuth.Token


googleAuthUrl : String -> String
googleAuthUrl href = OAuth.buildAuthUrl <| googleAuthClient href


googleAuthClient : String -> OAuth.Client
googleAuthClient href =
    OAuth.newClient
        OAuth.Config.google
        { clientId = "204042862259-qq8k6l1p65p6qrjlg9friq57difh06sb.apps.googleusercontent.com"
        , scopes = [ "https://www.googleapis.com/auth/userinfo.profile" ]
        , redirectUrl = removeUrlFragments href
        , authFlow = OAuth.Implicit
        }


init : Navigation.Location -> (Result Http.Error OAuth.Token -> msg) -> Cmd msg
init location m = OAuth.init (googleAuthClient location.href) location |> Cmd.map m


removeUrlFragments : String -> String
removeUrlFragments url =
  case String.split "#" url of
    s :: _ -> s
    _ -> ""
