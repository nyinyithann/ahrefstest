@module("./Dropdown.module.css") external styles: {..} = "default"

@react.component
let make = (
  ~isOpen: bool,
  ~target: React.element,
  ~children: React.element,
  ~onClose: unit => unit,
) => {
  let handleKeyDown = e => {
    if ReactEvent.Keyboard.key(e) == "Escape" {
      onClose()
    }
  }

  <div className={styles["dropdown-container"]} onKeyDown={handleKeyDown}>
    {target}
    {isOpen ? <div className={styles["dropdown-menu"]}> children </div> : React.null}
    {isOpen ? <div className={styles["overlay-blanket"]} onClick={_ => onClose()} /> : React.null}
  </div>
}
