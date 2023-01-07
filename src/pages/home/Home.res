@module("./Home.module.css") external styles: {..} = "default"

@react.component
let make = () => {
  <div className={styles["main"]}>
    <CountrySelect
      className={styles["country-select"]} country=?Some("zw") onChange={country => Js.log(country)}
    />
  </div>
}
