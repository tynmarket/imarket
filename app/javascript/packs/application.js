import ReactDOM from "react-dom";
//import "../styles/application";
import App from "./components/App";
import React from 'react';

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <App code={4368} indices={"PER"} />,
    document.querySelector("#per-chart")
  );

  ReactDOM.render(
    <App code={4368} indices={"PBR"} />,
    document.querySelector("#pbr-chart")
  );
});
