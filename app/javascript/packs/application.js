import ReactDOM from "react-dom";
//import "../styles/application";
import App from "./components/App";
import React from 'react';

document.addEventListener("DOMContentLoaded", () => {
  ReactDOM.render(
    <App code={4368} />,
    document.querySelector("#per-chart")
  );
});
