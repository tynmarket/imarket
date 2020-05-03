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
      const config = getConfig(code, data);

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

function getConfig(code, data) {
  const labels = data.x_label;
  const points = data.data_eps;
  const prices = data.data_price;

  switch (code) {
    case '998407':
      return n225Config(points, prices, labels, '予想EPS（日経）', 20);
      break;
    case '998407-r':
      return n225Config(points, prices, labels, '予想EPS（iMarket）', 10);
      break;
    case 'dow':
      break;
  }
}

const style = css`
  width: 100%;
  height: 100%;
  font-size: 14px;
  line-height: 1.2em;
`;

export default EpsChart;
