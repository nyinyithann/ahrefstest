@module("./CountrySelect.module.css") external styles: {..} = "default"

open ReactSelect

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
        [
          <div style={ReactDOM.Style.make(~display="flex", ())}>
            <span
              className={`fi fi-${props.data.value}`}
              style={ReactDOM.Style.make(~marginRight="0.5rem", ~display="block", ())}
            />
            <span style={ReactDOM.Style.make(~display="block", ())}>
              {props.data.label->React.string}
            </span>
          </div>,
        ],
      )}
    </div>
  }

  let getComponents = Select.replacingComponents(
    ~dropdownIndicator=Js.Nullable.null,
    ~valueContainer={makeValueContainer},
    ~option={makeOption},
    (),
  )
}

module TargetButton = {
  @react.component
  let make = (~value: option<Model.country>=?, ~toggleOpen: unit => unit) => {
    <button type_="button" className={styles["target-button"]} onClick={_ => toggleOpen()}>
      {switch value {
      | Some(country) => country.label
      | None => "Country"
      }->React.string}
      <DownIcon />
    </button>
  }
}

let selectStyles = ReactSelect.Select.replacingStyles(
  ~menu=provided =>
    ReactDOM.Style.combine(
      provided,
      ReactDOM.Style.make(~marginTop="0", ~borderTopLeftRadius="0", ~borderTopRightRadius="0", ()),
    ),
  ~control=provided =>
    ReactDOM.Style.combine(
      provided,
      ReactDOM.Style.make(
        ~margin="0px 10px",
        ~borderColor="transparent",
        ~borderBottomLeftRadius="0",
        ~borderBottomRightRadius="0",
        ~borderStyle="none",
        ~borderWidth="0",
        ~boxShadow="none",
        (),
      ),
    ),
  (),
)

@react.component
let make = (~className: option<string>=?) => {
  let (isOpen, setIsOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => None)
  <Dropdown
    isOpen
    onClose={() => setIsOpen(_ => false)}
    target={<TargetButton ?value toggleOpen={() => setIsOpen(prev => !prev)} />}>
    <Select
      ?className
      multi={false}
      autoFocus={true}
      menuIsOpen={true}
      ignoreAccents={false}
      backspaceRemovesValue={false}
      controlShouldRenderValue={false}
      hideSelectedOptions={false}
      isClearable={false}
      ?value
      options={Model.countries}
      placeholder={"Search"}
      components={Components.getComponents}
      styles={selectStyles}
      onChange={country =>
        switch Js.Nullable.toOption(country) {
        | Some(c) => {
            setValue(_ => Some(c))
            setIsOpen(_ => false)
            Js.log(c)
          }

        | _ => ()
        }}
    />
  </Dropdown>
}
