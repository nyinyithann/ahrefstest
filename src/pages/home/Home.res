@module("./Home.module.css") external styles: {..} = "default"

@react.component
let make = () => {
  <div className={styles["main"]}>
    <CountriesProvider>
      <CountrySelect className={styles["country-select"]} />
    </CountriesProvider>
  </div>
}
