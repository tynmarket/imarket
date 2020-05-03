/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import { n225Config, options } from './EpsChartConfig';
import Highcharts from 'highcharts';
import axios from 'axios';
import { useEffect } from 'react';

const EpsChart = ({ code }) => {
  const idStr = `${code}-highcharts`;

  useEffect(() => {
    getData(code).then(data => {
      const labels = data.x_label;
      const pointsN225 = data.data_n225;
      const pointsN225R = data.data_n225_r;
      const prices = data.data_close;
      const config = n225Config(pointsN225, pointsN225R, prices, labels);

      Highcharts.setOptions(options);
      Highcharts.chart(idStr, config);
    });
  });

  return <div id={idStr} css={style} />;
};

async function getData(code) {
  const url = `/eps_estimates/${code}/chart`;
  const response = await axios.get(url);
  return response.data;
}

const style = css`
  width: 100%;
  height: 100%;
  font-size: 14px;
  line-height: 1.2em;
`;

export default EpsChart;
