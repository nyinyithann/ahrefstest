// Generated by ReScript, PLEASE EDIT WITH CARE

import * as React from 'react';
import LoaderModuleCss from './Loader.module.css';

var styles = LoaderModuleCss;

function Loader(Props) {
  var className = Props.className;
  return React.createElement(
    'div',
    {
      className: styles.main,
    },
    React.createElement(
      'svg',
      {
        className: className,
        fill: 'none',
        viewBox: '0 0 131 55',
      },
      React.createElement(
        'defs',
        undefined,
        React.createElement('path', {
          id: 'spinners-react-infinity-path',
          d: 'M46.57 45.5138C36.346 55.4954 19.8919 55.4954 9.66794 45.5138C-0.55598 35.5321 -0.55598 19.4678 9.66794 9.48624C19.8919 -0.495412 36.346 -0.495412 46.57 9.48624L84.4303 45.5138C94.6543 55.4954 111.108 55.4954 121.332 45.5138C131.556 35.5321 131.556 19.4678 121.332 9.48624C111.108 -0.495412 94.6543 -0.495412 84.4303 9.48624L46.57 45.5138Z',
        })
      ),
      React.createElement('use', {
        xlinkHref: '#spinners-react-infinity-path',
      }),
      React.createElement('use', {
        className: styles['spin-infinity'],
        fill: 'none',
        stroke: 'currentColor',
        strokeDasharray: '1, 347',
        strokeDashoffset: '75',
        strokeLinecap: 'round',
        xlinkHref: '#spinners-react-infinity-path',
      })
    )
  );
}

var make = Loader;

export { styles, make };
/* styles Not a pure module */
