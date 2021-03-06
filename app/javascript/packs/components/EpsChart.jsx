/** @jsx jsx */
import { css, jsx } from '@emotion/core';
import { dowConfig, n225Config, options } from './EpsChartConfig';
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
    case '998407-r':
      return n225Config(points, prices, labels, '予想EPS（iMarket算出）', 10);
    case '^DJI':
      return dowConfig(points.current, points.next, prices, labels);
  }
}

const style = css`
  width: 100%;
  height: 100%;
  padding-right: 15px;
  padding-left: 15px;
  font-size: 14px;
  line-height: 1.2em;
`;

export default EpsChart;
