type contextValue = {
  loading: bool,
  error: string,
  countries: array<ViewModel.country>,
  loadCountries: (~signal: Fetch_Abort.Signal.t) => unit,
}

module CountriesContext = {
  let initialContextValue: contextValue = {
    loading: false,
    error: "",
    countries: [],
    loadCountries: (~signal as _) => (),
  }

  let context = React.createContext(initialContextValue)
  module Provider = {
    let provider = React.Context.provider(context)
    @react.component
    let make = (~value, ~children) => {
      React.createElement(provider, {"value": value, "children": children})
    }
  }
}

type state = {
  loading: bool,
  error: string,
  countries: array<ViewModel.country>,
}

let initialState = {
  loading: false,
  error: "",
  countries: [],
}

type action =
  | Loading
  | Error(string)
  | SuccessCountries(array<ViewModel.country>)

let reducer = (state: state, action: action) => {
  switch action {
  | Loading => {
      loading: true,
      error: "",
      countries: state.countries,
    }
  | Error(msg) => {
      loading: false,
      error: msg,
      countries: state.countries,
    }
  | SuccessCountries(countries) => {
      loading: false,
      error: "",
      countries,
    }
  }
}

let loadCountriesInternal = (dispatch, ~signal) => {
  // let apiPath = "https://gist.githubusercontent.com/rusty-key/659db3f4566df459bd59c8a53dc9f71f/raw/4127f9550ef063121c564025f6d27dceeb279623/counties.json"
  let apiPath = "https://api.github.com/gists/659db3f4566df459bd59c8a53dc9f71f"

  let callback = result => {
    switch result {
    | Ok(json) => {
        let gist = Model.GistDecoder.decode(. ~json)
        switch gist {
        | Ok(g) => try {
            let cjson = `{ "countries" : ${g.files.countryJsonFile.content} }`->Js.Json.parseExn
            let data = ViewModel.CountriesDecoder.decode(. ~json=cjson)
            switch data {
            | Ok(d) => {
                dispatch(SuccessCountries(d.countries))
            }
            | Error(msg) => dispatch(Error(msg))
            }
          } catch {
          | Js.Exn.Error(obj) =>
            switch Js.Exn.message(obj) {
            | Some(m) => dispatch(Error(m))
            | None => ()
            }
          }

        | _ => ()
        }
      }

    | Error(_) => dispatch(Error("Unexpected error occured while reteriving countries data."))
    }
  }

  dispatch(Loading)
  WebAPI.getCountries(~apiPath, ~callback, ~signal, ())->ignore
}

@react.component
let make = (~children) => {
  let (state, dispatch) = React.useReducer(reducer, initialState)
  let loadCountries = React.useMemo1(() => loadCountriesInternal(dispatch), [dispatch])
  let value = {
    loading: state.loading,
    error: state.error,
    countries: state.countries,
    loadCountries,
  }
  <CountriesContext.Provider value> children </CountriesContext.Provider>
}

let useCountriesContext = () => React.useContext(CountriesContext.context)
