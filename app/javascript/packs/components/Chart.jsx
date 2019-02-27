import React from "react";
import LineChart from './LineChart'
import axios from "axios";
import { useEffect, useState, useRef } from "react";
const merge = require('lodash/merge');

const Chart = ({ code, option, max }) => {
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

  useEffect(() => {
    getData(code).then(data => {
      const ctx = canvas.current.getContext('2d');

      const labels = data.x_label || []
      const points = (data.data || []).map((point) => { return {x: point[0], y: point[1]} });
      const config = merge(defaultConfig(points), option(labels, points));

      const chartRef = LineChart(ctx, config);
      setChart(chartRef);
    });
  }, []);

  return (
    <canvas ref={canvas} className="per-chart" />
  );
};

async function getData(code) {
  const url = `/stock_prices/${code}/per.json`;
  const response = await axios.get(url);
  return response.data.current_year;
}

function defaultConfig(points) {
  return {
    type: 'shadowLine',
    data: {
      datasets: [
        {
          data: points,
          backgroundColor: '#edc240',
          borderColor: '#edc240',
          fill: false,
          pointHoverBackgroundColor: 'transparent',
          pointHoverBorderColor: '#afd8f8',
          pointHoverBorderWidth: 4,
          pointHoverRadius: 6,
          pointRadius: 0,
        }
      ]
    },
    options: {
      animation: {
          duration: 0,
      },
      elements: {
          line: {
              tension: 0.1,
          }
      },
      hover: {
          animationDuration: 0,
      },
      legend: {
        display: false
      },
      responsive: true,
      maintainAspectRatio: false,
      responsiveAnimationDuration: 0,
      scales: {
        xAxes: [{
          gridLines: {
            drawTicks: false,
          },
          ticks: {
            autoSkip: false,
            padding: 10,
            maxRotation: 45,
          }
        }],
        yAxes: [{
          gridLines: {
            drawTicks: false,
          },
          ticks: {
            padding: 10,
            maxTicksLimit: 6,
          }
        }]
      },
      tooltips: {
        callbacks: {
          title: (item, data) => {},
        },
        displayColors: false,
        caretPadding: 5,
      },
    }
  };
}

export default Chart;
