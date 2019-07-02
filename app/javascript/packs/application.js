import App from './components/App';
import Exporting from 'highcharts/modules/exporting';
import Highcharts from 'highcharts';
import axios from 'axios';

import React from 'react';
import ReactDOM from 'react-dom';
//import "../styles/application";

Exporting(Highcharts);

document.addEventListener('DOMContentLoaded', () => {
  const elm = document.querySelector('#code');

  if (!elm) {
    return;
  }

  const code = elm.textContent;
  const indices = 'per';

  getData(code, indices).then(data => {
    data = data.entire_period.data.map(plot => plot[1]);
    Highcharts.chart('highcharts', {
      title: '',
      legend: {
        enabled: false,
      },
      xAxis: {
        tickInterval: 60,
        gridLineWidth: 1,
        labels: {
          formatter: function() {
            return `${this.value} km`;
          },
        },
      },
      yAxis: {
        title: {
          text: null,
        },
        labels: {
          format: '{value} m',
        },
      },
      plotOptions: {
        line: {
          animation: false,
          marker: {
            enabled: false,
            fillColor: 'transparent',
            lineColor: '#7cb5ec',
            lineWidth: 2.5,
            radius: 3.5,
          },
          lineWidth: 1.5,
          states: {
            hover: {
              enabled: false,
            },
          },
        },
        series: {
          label: {
            connectorAllowed: false,
          },
          color: '#edc240',
          states: {
            hover: {
              enabled: true,
              halo: {
                size: 0,
              },
            },
          },
        },
      },
      series: [
        {
          name: 'Installation',
          data: data,
        },
      ],
      tooltip: {
        headerFormat: '',
        pointFormat:
          '<span style="font-weight: bold; color: #595857;">{point.y} 倍 ({point.x})</span>',
      },
      responsive: {
        rules: [
          {
            condition: {
              maxWidth: 500,
            },
            chartOptions: {
              legend: {
                layout: 'horizontal',
                align: 'center',
                verticalAlign: 'bottom',
              },
            },
          },
        ],
      },
    });
  });

  /*
  ReactDOM.render(
    <App code={code} indices={'per'} />,
    document.querySelector('#per-chart')
  );

  ReactDOM.render(
    <App code={code} indices={'pbr'} />,
    document.querySelector('#pbr-chart')
  );
  */
});

async function getData(code, indices) {
  const url = `/stock_prices/${code}/${indices}.json`;
  const response = await axios.get(url);
  return response.data;
}
