import App from './components/App';
import EpsChart from './components/EpsChart';
import Exporting from 'highcharts/modules/exporting';
import Highcharts from 'highcharts';

import React from 'react';
import ReactDOM from 'react-dom';
//import "../styles/application";

Exporting(Highcharts);

document.addEventListener('DOMContentLoaded', () => {
  let elm = document.querySelector('#code');

  if (elm) {
    const code = elm.textContent;

    // 予想PER, PBR, FCF倍率
    renderStockChart(code);
  }

  elm = document.querySelector('#eps_estimates-index');

  if (elm) {
    // 予想EPS
    renderEpsChart();
  }
});

function renderStockChart(code) {
  // PER
  ReactDOM.render(
    <App code={code} indices={'per'} />,
    document.querySelector('#per-chart')
  );

  // PBR
  ReactDOM.render(
    <App code={code} indices={'pbr'} />,
    document.querySelector('#pbr-chart')
  );

  const fcfElm = document.querySelector('#fcf-ratio-chart');

  // FCF倍率
  if (fcfElm) {
    ReactDOM.render(<App code={code} indices={'fcf-ratio'} />, fcfElm);
  }
}

function renderEpsChart() {
  // 日経
  ReactDOM.render(
    <EpsChart code={'998407'} />,
    document.querySelector('#n225-chart')
  );

}
