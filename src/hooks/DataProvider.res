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

let loadCountries = (~dispatch, ~signal) => {
  let apiPath = "https://api.github.com/gists/659db3f4566df459bd59c8a53dc9f71f"

  let callback = result => {
    switch result {
    | Ok(json) => {
        let gist = Model.GistDecoder.decode(. ~json)
        switch gist {
        | Ok(g) =>
          try {
            let cjson = `{ "countries" : ${g.files.countryJsonFile.content} }`->Js.Json.parseExn
            let data = ViewModel.CountriesDecoder.decode(. ~json=cjson)
            switch data {
            | Ok(d) => dispatch(SuccessCountries(d.countries))

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

let useCountriesData = () => {
  let (state, dispatch) = React.useReducer(reducer, initialState)

  React.useEffect1(() => {
    let controller = Fetch.AbortController.make()
    loadCountries(~dispatch, ~signal=Fetch.AbortController.signal(controller))
    Some(() => Fetch.AbortController.abort(controller, "Cancel the request"))
  }, [dispatch])

  (state.loading, state.error, state.countries)
}
