import ReactDOM from "react-dom";
//import "../styles/application";
import App from "./components/App";
import React from 'react';

document.addEventListener("DOMContentLoaded", () => {
  const code = document.querySelector("#code").textContent;

  ReactDOM.render(
    <App code={code} indices={"PER"} />,
    document.querySelector("#per-chart")
  );

  ReactDOM.render(
    <App code={code} indices={"PBR"} />,
    document.querySelector("#pbr-chart")
  );
});
