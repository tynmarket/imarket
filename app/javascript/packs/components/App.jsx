import {
  currentConfigFn,
  currentPointFn,
  //entireConfigFn,
  //entirePointFn,
} from './ChartConfig';
import { useEffect, useState } from 'react';
import ChartContainer from './ChartContainer';
import Exporting from 'highcharts/modules/exporting';
import Highcharts from 'highcharts';
import React from 'react';
import axios from 'axios';
Exporting(Highcharts);

const App = ({ code, indices }) => {
  const [currentConfig, setCurrentConfig] = useState();
  //const [entireConfig, setEntireConfig] = useState();

  useEffect(() => {
    getData(code, indices).then(data => {
      const currentData = data.current_year;
      const currentConfig = getConfig(
        currentData,
        currentConfigFn,
        currentPointFn
      );
      setCurrentConfig(currentConfig);

      /*
      const entireData = data.entire_period;
      const entireConfig = getConfig(entireData, entireConfigFn, entirePointFn);
      setEntireConfig(entireConfig);
      */

      data = data.current_year.map(plot => plot[1]);
      Highcharts.chart('per-current', {
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
            data: currentData,
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
  }, []);

  return (
    <div>
      <ChartContainer indices={indices} config={currentConfig}>
        年初来
      </ChartContainer>
      <div className="clearfix" />
    </div>
  );
};

async function getData(code, indices) {
  const url = `/stock_prices/${code}/${indices}.json`;
  const response = await axios.get(url);
  return response.data;
}

function getConfig(data, configFn, pointFn) {
  const labels = data.x_label || [];
  const points = (data.data || []).map(pointFn(labels));
  return configFn(labels, points);
}

export default App;
