@module("./CountrySelect.module.css") external styles: {..} = "default"

open ReactSelect

let countries = [
  {"label": "Afghanistan", "value": "af"},
  {"label": "Aland Islands", "value": "ax"},
  {"label": "Albania", "value": "al"},
]

module Components = {
  let makeValueContainer = props => {
    <div className={styles["value-container"]}>
      <GlassIcon />
      {React.createElement(
        ReactSelect.Select.components->ReactSelect.Select.valueContainerCompGet,
        props,
      )}
    </div>
  }

  let makeOption = props => {
    <div className={styles["option"]}>
      {React.createElementVariadic(
        ReactSelect.Select.components->ReactSelect.Select.optionCompGet,
        props,
        [<span> {"flag"->React.string} </span>, React.cloneElement(<span />, props)],
      )}
    </div>
  }

  let getComponents = Select.comps(
    ~dropdownIndicator=Js.Nullable.null,
    ~valueContainer={makeValueContainer},
    ~option={makeOption},
    (),
  )
}

@react.component
let make = () => {
  <Select
    multi={false}
    options={countries}
    placeholder={"Select Country"}
    components={Components.getComponents}
  />
}
