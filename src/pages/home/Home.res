@module("./Home.module.css") external styles: {..} = "default"

let countries = [
  {"label": "Afghanistan", "value": "af"},
  {"label": "Aland Islands", "value": "ax"},
  {"label": "Albania", "value": "al"},
]

module Placeholder = {
  @react.component
  let make = (~innerProps: ReactSelect.Select.common_props) => {
    <p> {"Search..."->React.string} </p>
  }
}

open ReactSelect
@react.component
let make = () => {
  <div className={styles["main"]}>
    <p> {"Hello, World!"->React.string} </p>
    <Select
      multi={false}
      options={countries}
      components={ReactSelect.Select.comps(
        ~dropdownIndicator=Js.Nullable.null,
        ~placeholder={Js.Nullable.return(Placeholder.make)},
        (),
      )}
    />
  </div>
}
