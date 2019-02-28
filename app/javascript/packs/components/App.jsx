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
      let labels = currentData.x_label || []
      let points = (currentData.data || []).map((point) => { return {x: point[0], y: point[1]} });
      setCurrentConfig(currentConfigFn(labels, points));

      const entireData = data.entire_period;
      labels = entireData.x_label || []
      points = (entireData.data || []).map((point) => { return {x: point[0], y: point[1]} });
      setEntireConfig(entireConfigFn(labels, points));
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

export default App;
