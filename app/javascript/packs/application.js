import App from './components/App';
import CandleStick from './components/CandleStick';

import React from 'react';
import ReactDOM from 'react-dom';
//import "../styles/application";

document.addEventListener('DOMContentLoaded', () => {
  const elm = document.querySelector('#code');

  if (!elm) {
    return;
  }

  const code = elm.textContent;

  const ohlcElm = document.querySelector('#candle-stick-chart');

  // ローソク足
  if (ohlcElm) {
    CandleStick();
    return;
  }

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
});
