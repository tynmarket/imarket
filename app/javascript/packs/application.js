import App from './components/App';
import React from 'react';
import ReactDOM from 'react-dom';
//import "../styles/application";

document.addEventListener('DOMContentLoaded', () => {
  const code = document.querySelector('#code').textContent;

  ReactDOM.render(
    <App code={code} indices={'per'} />,
    document.querySelector('#per-chart')
  );

  ReactDOM.render(
    <App code={code} indices={'pbr'} />,
    document.querySelector('#pbr-chart')
  );
});
