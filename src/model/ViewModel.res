type country = {
  label: string,
  value: string,
}

type countries = {countries: array<country>}

module CountriesDecoder = {
  open JsonCombinators
  open! JsonCombinators.Json.Decode

  let country: Json.Decode.t<country> = object(fields => {
    label: fields.required(. "label", string),
    value: fields.required(. "value", string),
  })

  let countries: Json.Decode.t<countries> = object(fields => {
    countries: fields.required(. "countries", array(country)),
  })

  let decode = (. ~json: Js.Json.t): result<countries, string> => {
    Json.decode(json, countries)
  }
}
