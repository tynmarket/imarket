import Highcharts from 'highcharts';
import React from 'react';
import { useState } from 'react';

const Chart = ({ idStr, config, max }) => {
  const [chart, setChart] = useState();

  /*
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
  */

  if (!chart && config) {
    const chartRef = Highcharts.chart(idStr, config);
    setChart(chartRef);
  }

  return <div id={idStr} className="per-chart" />;
};

export default Chart;
