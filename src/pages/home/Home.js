// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import * as CountrySelect from "../../components/country-select/CountrySelect.js";
import HomeModuleCss from "./Home.module.css";

var styles = HomeModuleCss;

function Home(Props) {
  return React.createElement("div", {
              className: styles.main
            }, React.createElement(CountrySelect.make, {
                  className: styles["country-select"]
                }));
}

var make = Home;

export {
  styles ,
  make ,
}
/* styles Not a pure module */
