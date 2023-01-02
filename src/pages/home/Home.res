@module("./Home.module.css") external styles: {..} = "default"

let countries = [
  {"label": "Afghanistan", "value": "af"},
  {"label": "Aland Islands", "value": "ax"},
  {"label": "Albania", "value": "al"},
]

open ReactSelect
@react.component
let make = () => {
  <div className={styles["main"]}>
    <p> {"Hello, World!"->React.string} </p>
    <Select multi={false} options={countries} components={{"DropdownIndicator": None}} />
  </div>
}
