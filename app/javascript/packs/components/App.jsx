import React from "react";
import ChartContainer from "./ChartContainer";

const App = ({ code }) => {
  return (
    <div>
      <ChartContainer code={code} config={currentConfig} >年初来</ChartContainer>
      <div className="clearfix" />
      <ChartContainer code={code} config={entireConfig} >全期間</ChartContainer>
    </div>
  );
};

const currentConfig = (labels, points) => {
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

export default App;
