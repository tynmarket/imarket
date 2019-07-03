import App from './components/App';
import Exporting from 'highcharts/modules/exporting';
import Highcharts from 'highcharts';
import axios from 'axios';

import React from 'react';
import ReactDOM from 'react-dom';
//import "../styles/application";

Exporting(Highcharts);

document.addEventListener('DOMContentLoaded', () => {
  const elm = document.querySelector('#code');

  if (!elm) {
    return;
  }

  const code = elm.textContent;

  ReactDOM.render(
    <App code={code} indices={'per'} />,
    document.querySelector('#per-chart')
  );

  ReactDOM.render(
    <App code={code} indices={'pbr'} />,
    document.querySelector('#pbr-chart')
  );
});
