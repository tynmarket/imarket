import React from "react";
import LineChart from './LineChart'
import axios from "axios";
import { useEffect, useState, useRef } from "react";
const merge = require('lodash/merge');

const Chart = ({ code }) => {
  const canvas = useRef(null);
  //const [data, setData] = useState({});

  useEffect(() => {
    getData(code).then(data => {
      const ctx = canvas.current.getContext('2d');

      const labels = data.x_label || []
      const points = (data.data || []).map((point) => { return {x: point[0], y: point[1]} });
      const config = merge(defaultConfig(points), currentConfig(labels, points));

      const chart = LineChart(ctx, config);
    });
  }, []);

  return (
    <canvas ref={canvas} id="per-current" className="per-chart" />
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

function currentConfig(labels, points) {
  return {
    data: {
      datasets: [{
        borderWidth: 2,
        pointHitRadius: 7,
      }],
    },
    options: {
      scales: {
        xAxes: [{
          type: 'linear',
          ticks: {
            callback: (value, i, values) => labels[value],
            max: labels.length,
            stepSize: 60
          }
        }],
      },
      tooltips: {
        callbacks: {
          label: (item, data) => {
            const point = points[item.index]
            const value = point.y
            return ` ${value} 倍（${labels[point.x]}）`
          },
        },
      },
    }
  };
}

function entireConfig(labels, points) {
  return {
    labels: ['2011', '2012', '2013', '2014', '2015', '2016', '2017', '2018', '2019', '2020'], // TODO
    data: {
      datasets: [{
        borderWidth: 1.5,
        pointHitRadius: 2,
      }],
    },
    options: {
      scales: {
        xAxes: [{
          type: 'time',
          time: {
            unit: 'year',
            stepSize: 1,
          },
        }],
      },
      tooltips: {
        callbacks: {
          label: (item, data) => {
            const point = points[item.index]
            const value = point.y
            return ` ${value} 倍（${point.x}）`
          },
        },
      },
    }
  };
}

export default Chart;
