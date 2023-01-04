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
          <div className={styles["item"]}>
            <span className={`fi fi-${props.data.value} ${styles["flag"]}`} />
            <span className={styles["label"]}> {props.data.label->React.string} </span>
          </div>,
        ],
      )}
    </div>
  }

  let getComponents = Select.injectedComponents(
    ~dropdownIndicator=Js.Nullable.null,
    ~valueContainer={makeValueContainer},
    ~option={makeOption},
    (),
  )
}

module TargetButton = {
  @react.component
  let make = (~value: option<ViewModel.country>=?, ~toggleOpen: unit => unit) => {
    <button type_="button" className={styles["target-button"]} onClick={_ => toggleOpen()}>
      {switch value {
      | Some(country) => country.label
      | None => "Country"
      }->React.string}
      <DownIcon />
    </button>
  }
}

let selectStyles = ReactSelect.Select.injectedStyles(
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
  ~option=provided =>
    ReactDOM.Style.combine(provided, ReactDOM.Style.make(~padding="4px 4px 4px 8px", ())),
  (),
)

@react.component
let make = (~className: option<string>=?) => {
  let (isOpen, setIsOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => None)
  let {loading, error, countries, loadCountries} = CountriesProvider.useCountriesContext()

  React.useEffect0(() => {
    %debugger
    let controller = Fetch.AbortController.make()
    loadCountries(~signal=Fetch.AbortController.signal(controller))

    Some(() => Fetch.AbortController.abort(controller, "Cancel the request"))
  })
    <Dropdown
      isOpen
      onClose={() => setIsOpen(_ => false)}
      target={<TargetButton ?value toggleOpen={() => setIsOpen(prev => !prev)} />}>
      <Select
        ?className
        ?value
        multi={false}
        autoFocus={true}
        menuIsOpen={true}
        ignoreAccents={false}
        backspaceRemovesValue={false}
        controlShouldRenderValue={false}
        hideSelectedOptions={false}
        isClearable={false}
        options={countries}
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