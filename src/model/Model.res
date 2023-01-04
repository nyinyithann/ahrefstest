type countryJsonFile = {
    content : string
}

type files = {
    countryJsonFile : countryJsonFile 
}

type gist = {
    files : files
}

module GistDecoder = {
  open JsonCombinators
  open! JsonCombinators.Json.Decode

  let countryJsonFile : Json.Decode.t<countryJsonFile> = object(fields => {
      content : fields.required(. "content", string)
  })

  let files : Json.Decode.t<files> = object(fields => {
      countryJsonFile: fields.required(. "counties.json", countryJsonFile)
  })
  
  let gist : Json.Decode.t<gist> = object(fields => {
      files: fields.required(. "files", files)
  })
  
  let decode = (. ~json: Js.Json.t): result<gist, string> => {
    Json.decode(json, gist)
  }
}
