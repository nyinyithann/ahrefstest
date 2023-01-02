// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from "react";
import ReactSelect from "react-select";
import HomeModuleCss from "./Home.module.css";

var styles = HomeModuleCss;

var countries = [
  {
    label: "Afghanistan",
    value: "af"
  },
  {
    label: "Aland Islands",
    value: "ax"
  },
  {
    label: "Albania",
    value: "al"
  }
];

function Home$Placeholder(Props) {
  return React.createElement("p", undefined, "Search...");
}

var Placeholder = {
  make: Home$Placeholder
};

function Home(Props) {
  return React.createElement("div", {
              className: styles.main
            }, React.createElement("p", undefined, "Hello, World!"), React.createElement(ReactSelect, {
                  multi: false,
                  options: countries,
                  components: {
                    DropdownIndicator: null,
                    Placeholder: Home$Placeholder
                  }
                }));
}

var make = Home;

export {
  styles ,
  countries ,
  Placeholder ,
  make ,
}
/* styles Not a pure module */
