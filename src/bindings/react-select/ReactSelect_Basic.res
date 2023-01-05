type optionProps = {data: ViewModel.country}
type menuListProps = {children: array<React.element>}

@deriving(abstract)
type components = {
  @as("DropdownIndicator")
  dropdownIndicatorComp: React.component<{.}>,
  @as("ValueContainer")
  valueContainerComp: React.component<{.}>,
  @as("Option")
  optionComp: React.component<optionProps>,
  @as("MenuList")
  menuListComp: React.component<menuListProps>,
}

@module("react-select")
external components: components = "components"

@deriving(abstract)
type injectedComponents = {
  @optional @as("DropdownIndicator")
  dropdownIndicator: Js.Nullable.t<React.componentLike<{.}, React.element>>,
  @optional @as("ValueContainer")
  valueContainer: React.componentLike<{.}, React.element>,
  @optional @as("Option")
  option: React.componentLike<optionProps, React.element>,
  @optional @as("MenuList")
  menuList: React.componentLike<menuListProps, React.element>,
}

type styler = ReactDOM.Style.t => ReactDOM.Style.t

@deriving(abstract)
type injectedStyles = {
  @optional
  menu: styler,
  @optional
  control: styler,
  @optional
  option: styler,
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
  ~options: array<ViewModel.country>=?,
  ~value: ViewModel.country=?,
  ~placeholder: string=?,
  ~components: injectedComponents=?,
  ~styles: injectedStyles=?,
  ~onChange: Js.Nullable.t<'a> => unit,
) => React.element = "default"
