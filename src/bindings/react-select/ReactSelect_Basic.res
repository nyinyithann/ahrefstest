type props<'a> = {data: 'a}

type menuListProps = {children: React.element}

@deriving(abstract)
type components = {
  @as("DropdownIndicator")
  dropdownIndicatorComp: React.component<{.}>,
  @as("ValueContainer")
  valueContainerComp: React.component<{.}>,
  @as("Option")
  optionComp: React.component<props<ViewModel.country>>,
  @as("MenuList")
  menuListComp: React.component<menuListProps>,
  @as("NoOptionsMessage")
  noOptionsMessageCom: React.component<{.}>,
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
  option: React.componentLike<props<ViewModel.country>, React.element>,
  @optional @as("MenuList")
  menuList: React.componentLike<menuListProps, React.element>,
  @optional @as("NoOptionsMessage")
  noOptionsMessage: React.componentLike<{.}, React.element>,
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
  ~isLoading: bool=?,
  ~options: array<ViewModel.country>=?,
  ~value: ViewModel.country=?,
  ~placeholder: string=?,
  ~components: injectedComponents=?,
  ~styles: injectedStyles=?,
  ~onChange: Js.Nullable.t<'a> => unit,
) => React.element = "default"
