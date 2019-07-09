/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import Highcharts from 'highcharts';
import { Options } from 'highcharts';
import React from 'react';
import { media } from '../styles/variables';
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

  return <div id={idStr} css={style} />;
};

const style = css`
  width: 100%;
  height: 100%;
  font-size: 14px;
  line-height: 1.2em;
`;

export default Chart;
