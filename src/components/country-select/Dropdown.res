@module("./Dropdown.module.css") external styles: {..} = "default"

@react.component
let make = (
  ~isOpen: bool,
  ~target: React.element,
  ~children: React.element,
  ~onClose: unit => unit,
) => {
  <div className={styles["dropdown-container"]}>
    {target}
    {isOpen ? <div className={styles["dropdown-menu"]}> children </div> : React.null}
    {isOpen ? <div className={styles["overlay-blanket"]} onClick={_ => onClose()} /> : React.null}
  </div>
}
