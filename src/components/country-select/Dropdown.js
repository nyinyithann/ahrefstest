// Generated by ReScript, PLEASE EDIT WITH CARE

import * as Curry from "rescript/lib/es6/curry.js";
import * as React from "react";
import DropdownModuleCss from "./Dropdown.module.css";

var styles = DropdownModuleCss;

function Dropdown(Props) {
  var isOpen = Props.isOpen;
  var target = Props.target;
  var children = Props.children;
  var onClose = Props.onClose;
  var handleKeyDown = function (e) {
    if (e.key === "Escape") {
      return Curry._1(onClose, undefined);
    }
    
  };
  return React.createElement("div", {
              className: styles["dropdown-container"],
              onKeyDown: handleKeyDown
            }, target, isOpen ? React.createElement("div", {
                    className: styles["dropdown-menu"]
                  }, children) : null, isOpen ? React.createElement("div", {
                    className: styles["overlay-blanket"],
                    onClick: (function (param) {
                        Curry._1(onClose, undefined);
                      })
                  }) : null);
}

var make = Dropdown;

export {
  styles ,
  make ,
}
/* styles Not a pure module */
