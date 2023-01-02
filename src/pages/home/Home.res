@module("./Home.module.css") external styles: {..} = "default"

@react.component
let make = () => {
  <div className={styles["main"]}>
    <p> {"Hello, World!"->React.string} </p>
    <Loader className="loading" />
  </div>
}
