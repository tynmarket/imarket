import React from "react";
import LineChart from './LineChart'
import { useState, useRef } from "react";

const Chart = ({ config, max }) => {
  const canvas = useRef();
  const [chart, setChart] = useState();

  if (chart) {
    const prevMax = chart.options.scales.yAxes[0].ticks.max;

    if (max || prevMax) {
      if (max) {
        chart.options.scales.yAxes[0].ticks.max = max;
      } else {
        delete chart.options.scales.yAxes[0].ticks.max;
      }
      chart.update();
    }
  }

  if (!chart && config) {
    const ctx = canvas.current.getContext('2d');
    const chartRef = LineChart(ctx, config);
    setChart(chartRef);
 }

  return (
    <canvas ref={canvas} className="per-chart" />
  );
};

export default Chart;
