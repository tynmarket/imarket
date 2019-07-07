import Highcharts from 'highcharts';
import { Options } from 'highcharts';
import React from 'react';
import { useState } from 'react';

interface Props {
  idStr: string;
  config: Options;
  max?: number;
}

const Chart: React.FC<Props> = ({ idStr, config, max }): JSX.Element => {
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
