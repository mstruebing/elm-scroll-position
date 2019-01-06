module ScrollPosition exposing (view)

import Browser.Dom exposing (getViewport)
import Debug
import Html exposing (Attribute, Html, div)
import Html.Attributes exposing (class, style)


type alias Percent =
    Int


type Msg
    = UpdatePercent Percent


type alias Model =
    { percent : Int
    }


initialModel : Model
initialModel =
    { percent = 0 }


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        UpdatePercent percent ->
            ( { model | percent = percent }, Cmd.none )


view : Percent -> Maybe String -> Maybe String -> Html msg
view percent maybeWrapperStyles maybeInnerStyles =
    div outStyles
        [ loadingIndicator percent maybeWrapperStyles maybeInnerStyles
        ]


loadingIndicator : Percent -> Maybe String -> Maybe String -> Html msg
loadingIndicator percent maybeWrapperStyles maybeInnerStyles =
    case maybeWrapperStyles of
        Just wrapperStyles ->
            div [ class wrapperStyles ] [ loadingIndicatorInner percent maybeInnerStyles ]

        Nothing ->
            div (loadingIndicatorWrapperStyles ++ []) [ loadingIndicatorInner percent maybeInnerStyles ]


loadingIndicatorInner : Percent -> Maybe String -> Html msg
loadingIndicatorInner percent maybeInnerStyles =
    case maybeInnerStyles of
        Just innerStyles ->
            div [ class innerStyles, loadingIndicatorWidth percent ] []

        Nothing ->
            div (loadingIndicatorInnerStyles ++ [ loadingIndicatorWidth percent ] ++ []) []


outStyles : List (Attribute msg)
outStyles =
    [ style "position" "fixed"
    , style "top" "0"
    , style "width" "100%"
    ]


loadingIndicatorWrapperStyles : List (Attribute msg)
loadingIndicatorWrapperStyles =
    [ style "display" "flex"
    , style "justify-content" "flex-start"
    ]


loadingIndicatorInnerStyles : List (Attribute msg)
loadingIndicatorInnerStyles =
    [ style "display" "flex"
    , style "background-color" "red"
    , style "height" "0.5em"
    ]


loadingIndicatorWidth : Percent -> Attribute msg
loadingIndicatorWidth percent =
    style "width" <| String.fromInt percent ++ "%"
