@module("./CountrySelect.module.css") external styles: {..} = "default"

open ReactSelect

module FlagItem = {
  @react.component
  let make = (~data: ViewModel.country) => {
    <div className={styles["item"]}>
      <span className={`fi fi-${data.value} ${styles["flag"]}`} />
      <span className={styles["label"]}> {data.label->React.string} </span>
    </div>
  }
  let make = React.memo(make)
}

module ValueItem = {
  @react.component
  let make = (~props) => {
    <div className={styles["value-container"]}>
      <GlassIcon />
      {React.createElement(
        ReactSelect.Select.components->ReactSelect.Select.valueContainerCompGet,
        props,
      )}
    </div>
  }
  let make = React.memo(make)
}

module Components = {
  let makeValueContainer = props => <ValueItem props />

  let makeOption = props => {
    <div className={styles["option"]}>
      {React.createElementVariadic(
        ReactSelect.Select.components->ReactSelect.Select.optionCompGet,
        props,
        [<FlagItem data={props.data} />],
      )}
    </div>
  }

  let makeNoOptionsMessage = props => {
    <div className={styles["no-options-message"]}>
      {React.createElementVariadic(
        ReactSelect.Select.components->ReactSelect.Select.noOptionsMessageComGet,
        props,
        [
          <div className={styles["item"]}>
            <span className={styles["label"]}> {"No items found"->React.string} </span>
          </div>,
        ],
      )}
    </div>
  }

  let getComponents = Select.customComponents(
    ~dropdownIndicator=Js.Nullable.null,
    ~valueContainer={makeValueContainer},
    ~option={makeOption},
    ~noOptionsMessage={makeNoOptionsMessage},
    ~menuList={MenuList.makeMenuList},
    (),
  )
}

module TargetButton = {
  @react.component
  let make = (
    ~className: option<string>=?,
    ~value: option<ViewModel.country>=?,
    ~toggleOpen: unit => unit,
  ) => {
    let defaultStyle = styles["target-button"]
    let cn = switch className {
    | Some(c) => `${c} ${defaultStyle}`
    | None => defaultStyle
    }
    <button type_="button" className={cn} onClick={_ => toggleOpen()}>
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
      ReactDOM.Style.make(
        ~marginTop="0",
        ~borderTopLeftRadius="0",
        ~borderTopRightRadius="0",
        ~width="250px",
        (),
      ),
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
        ~width="230px",
        (),
      ),
    ),
  ~option=provided =>
    ReactDOM.Style.combine(provided, ReactDOM.Style.make(~padding="4px 4px 4px 8px", ())),
  ~menuList=provided =>
    ReactDOM.Style.combine(provided, ReactDOM.Style.make(~width="250px", ())),
  (),
)

@react.component
let make = (
  ~country: option<string>,
  ~className: option<string>=?,
  ~onChange: option<ViewModel.country => unit>=?,
) => {
  let (isOpen, setIsOpen) = React.useState(() => false)
  let (value, setValue) = React.useState(() => None)

  // loading and error handling are ignored for this test
  let (_loading, _error, countries) = DataProvider.useCountriesData()

  React.useEffect1(() => {
    open Js.String2
    let value = switch country {
    | Some(v) => countries->Belt.Array.getByU((. c) => toLowerCase(c.value) == toLowerCase(v))
    | None => None
    }
    setValue(_ => value)
    None
  }, [countries])

    <Dropdown
      isOpen
      onClose={() => setIsOpen(_ => false)}
      target={<TargetButton ?className ?value toggleOpen={() => setIsOpen(prev => !prev)} />}>
      <Select
        ?value
        classNamePrefix="country-select"
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
        filterOption={ReactSelect.Select.createFilter({ReactSelect.Select.ignoreAccents: true})}
        components={Components.getComponents}
        styles={selectStyles}
        onChange={country =>
          switch Js.Nullable.toOption(country) {
          | Some(c) => {
              setValue(_ => Some(c))
              setIsOpen(_ => false)
              switch onChange {
              | Some(change) => change(c)
              | None => ()
              }
            }

          | _ => ()
          }}
      />
    </Dropdown>
}
