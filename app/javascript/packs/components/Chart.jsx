import Highcharts from 'highcharts';
import React from 'react';
import { useState } from 'react';

const Chart = ({ idStr, config, max }) => {
  const [chart, setChart] = useState();

  if (chart) {
    const prevMax = chart.options.yAxis[0].max;

    if (max || prevMax) {
      const options = { yAxis: { max: max } };
      chart.update(options);
    }
  }

  if (!chart && config) {
    const chartRef = Highcharts.chart(idStr, config);
    setChart(chartRef);
  }

  return <div id={idStr} className="per-chart" />;
};

export default Chart;
