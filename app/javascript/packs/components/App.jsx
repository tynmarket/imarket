import React from "react";
import ChartContainer from "./ChartContainer";
import axios from "axios";
import { useEffect, useState } from "react";
import { currentConfigFn, entireConfigFn } from "./ChartConfig";

const App = ({ code, indices }) => {
  const [currentConfig, setCurrentConfig] = useState();
  const [entireConfig, setEntireConfig] = useState();

  useEffect(() => {
    getData(code, indices).then(data => {
      const currentData = data.current_year;
      const currentConfig = getConfig(currentData, currentConfigFn);
      setCurrentConfig(currentConfig);

      const entireData = data.entire_period;
      const entireConfig = getConfig(entireData, entireConfigFn);
      setEntireConfig(entireConfig);
    });
  }, []);

  return (
    <div>
      <ChartContainer indices={indices} config={currentConfig} >年初来</ChartContainer>
      <div className="clearfix" />
      <ChartContainer indices={indices} config={entireConfig} >全期間</ChartContainer>
    </div>
  );
};

async function getData(code, indices) {
  const url = `/stock_prices/${code}/${indices.toLowerCase()}.json`;
  const response = await axios.get(url);
  return response.data;
}

function getConfig(data, configFn) {
  const labels = data.x_label || []
  const points = (data.data || []).map((point) => { return {x: point[0], y: point[1]} });
  return configFn(labels, points);
}

export default App;
