module Siren exposing (main)

import Browser
import Html exposing (Html)
import Html.Attributes
import Html.Events



-- MODEL


type State
    = Initial
    | BadLength
    | Invalid
    | Valid


type alias Model =
    { sirenNumber : String
    , state : State
    }


initialModel : Model
initialModel =
    Model "" Initial



-- UPDATE


type Message
    = SirenUpdated String
    | ResetSirenNumber
    | SetSirenNumber


multiplyDigitAtOddIndex : Int -> Int -> Int
multiplyDigitAtOddIndex index digit =
    if modBy 2 index /= 0 then
        digit * 2

    else
        digit


addDigits : Int -> Int
addDigits digits =
    if digits > 9 then
        digits - 9

    else
        digits


sirenNumberToState : String -> State
sirenNumberToState sirenNumber =
    let
        filteredSirenNumbers : List Int
        filteredSirenNumbers =
            sirenNumber
                |> String.split ""
                |> List.filterMap String.toInt

        filteredSirenNumbersLength : Int
        filteredSirenNumbersLength =
            List.length filteredSirenNumbers
    in
    case filteredSirenNumbersLength of
        0 ->
            Initial

        9 ->
            let
                isValidSirenNumber : Bool
                isValidSirenNumber =
                    filteredSirenNumbers
                        |> List.indexedMap multiplyDigitAtOddIndex
                        |> List.map addDigits
                        |> List.foldl (+) 0
                        |> modBy 10
                        |> (==) 0
            in
            if isValidSirenNumber then
                Valid

            else
                Invalid

        _ ->
            BadLength


update : Message -> Model -> Model
update message model =
    case message of
        SirenUpdated newSirenNumber ->
            let
                filteredSirenNumber : String
                filteredSirenNumber =
                    newSirenNumber
                        |> String.filter (Char.isAlpha >> not)
            in
            { model
                | sirenNumber = filteredSirenNumber
                , state = sirenNumberToState filteredSirenNumber
            }

        ResetSirenNumber ->
            { model
                | sirenNumber = ""
                , state = Initial
            }

        SetSirenNumber ->
            { model
                | sirenNumber = "732 829 320"
                , state = sirenNumberToState "732 829 320"
            }



-- VIEW


viewHint : State -> Html Message
viewHint state =
    case state of
        Initial ->
            Html.p
                []
                [ Html.a
                    [ Html.Attributes.href "https://fr.wikipedia.org/wiki/Syst%C3%A8me_d%27identification_du_r%C3%A9pertoire_des_entreprises"
                    , Html.Attributes.target "blank"
                    ]
                    [ Html.text "Le numéro SIREN" ]
                , Html.text " - également appelé numéro unique d'identification - est un numéro à 9 chiffres qui permet d'identifier une entreprise."
                ]

        BadLength ->
            Html.p [] [ Html.text "Indice : la taille d'un numéro SIREN est de 9 caractères." ]

        Invalid ->
            Html.p [] [ Html.text "Le numéro SIREN tapé est invalide. Merci de vérifier votre saisie." ]

        Valid ->
            Html.p [] [ Html.text "Le numéro SIREN tapé est mathématiquement valide. Cela ne garantie pas que la société est enregistré au répertoire SIRENE de l'Insee." ]


view : Model -> Html Message
view model =
    Html.div
        [ Html.Attributes.class "wrapper" ]
        [ Html.main_
            [ Html.Attributes.class "container" ]
            [ Html.div
                [ Html.Attributes.class "input-field" ]
                [ Html.input
                    [ Html.Attributes.autofocus True
                    , Html.Attributes.placeholder "Ex: 732829320, 732 829 320, 732-829-320, 732.829.320, ..."
                    , Html.Events.onInput SirenUpdated
                    , Html.Attributes.value model.sirenNumber
                    , Html.Attributes.id "siren"
                    , Html.Attributes.class "input"
                    ]
                    []
                , Html.label
                    [ Html.Attributes.for "siren"
                    , Html.Attributes.class "input-label"
                    ]
                    [ Html.text "Valider mon SIREN " ]
                ]
            , Html.div
                [ Html.Attributes.class "buttons-wrapper" ]
                [ Html.button
                    [ Html.Events.onClick ResetSirenNumber
                    , Html.Attributes.class "button"
                    ]
                    [ Html.text "réinitialiser" ]
                , Html.button
                    [ Html.Attributes.class "button"
                    , Html.Events.onClick SetSirenNumber
                    ]
                    [ Html.text "exemple" ]
                ]
            , viewHint model.state
            ]
        , Html.footer
            []
            [ Html.a
                [ Html.Attributes.class "button"
                , Html.Attributes.target "blank"
                , Html.Attributes.href "https://github.com/aminnairi/siren/"
                ]
                [ Html.text "github" ]
            ]
        ]



-- MAIN


main : Program () Model Message
main =
    Browser.sandbox
        { init = initialModel
        , update = update
        , view = view
        }
