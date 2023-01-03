type optionProps = {data: Model.country}

@deriving(abstract)
type selectComponents = {
  @as("DropdownIndicator")
  dropdownIndicatorComp: React.component<{.}>,
  @as("ValueContainer")
  valueContainerComp: React.component<{.}>,
  @as("Option")
  optionComp: React.component<optionProps>,
}

@module("react-select")
external components: selectComponents = "components"

@deriving(abstract)
type replacingComponents = {
  @optional @as("DropdownIndicator")
  dropdownIndicator: Js.Nullable.t<React.componentLike<{.}, React.element>>,
  @optional @as("ValueContainer")
  valueContainer: React.componentLike<{.}, React.element>,
  @optional @as("Option")
  option: React.componentLike<optionProps, React.element>,
}

type styler = ReactDOM.Style.t => ReactDOM.Style.t

@deriving(abstract)
type replacingStyles = {
  @optional
  menu: styler,
  @optional
  control: styler,
}

@module("react-select") @react.component
external make: (
  ~multi: bool,
  ~autoFocus: bool=?,
  ~backspaceRemovesValue: bool=?,
  ~controlShouldRenderValue: bool=?,
  ~hideSelectedOptions: bool=?,
  ~isClearable: bool=?,
  ~menuIsOpen: bool=?,
  ~ignoreAccents: bool=?,
  ~tabSelectsValue: bool=?,
  ~className: string=?,
  ~options: array<Model.country>=?,
  ~value: Model.country=?,
  ~placeholder: string=?,
  ~components: replacingComponents=?,
  ~styles: replacingStyles=?,
  ~onChange: Js.Nullable.t<'a> => unit,
) => React.element = "default"
