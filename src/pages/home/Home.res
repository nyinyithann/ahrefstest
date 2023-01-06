@module("./Home.module.css") external styles: {..} = "default"

@react.component
let make = () => {
  <div className={styles["main"]}>
    <CountrySelect className={styles["country-select"]} />
    /* <ReactWindow.List */
    /*   width={Util.NumberOrString.string("20rem")} */
    /*   height={Util.NumberOrString.int(300)} */
    /*   itemCount={10000} */
    /*   itemSize={20}> */
    /*   {({index, style}) => <div style> {`Row ${index->string_of_int}`->React.string} </div>} */
    /* </ReactWindow.List> */
  </div>
}
