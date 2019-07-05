import dayjs from 'dayjs';
import merge from 'lodash/fp/merge';

export const currentPointFn = () => point => {
  return [point[0], point[1]];
};

export const currentConfigFn = (points, labels) => {
  const config = {
    xAxis: {
      tickInterval: 60,
      labels: {
        formatter: function() {
          return `${labels[this.value]}`;
        },
      },
    },
  };

  return merge(defaultConfig(points, labels), config);
};

export const entirePointFn = labels => (point, i) => {
  return { x: dayjs(labels[i]).toDate(), y: point[1] };
};

export const entireConfigFn = (points, labels) => {
  const config = {
    xAxis: {
      tickInterval: 365 * 24 * 3600 * 1000,
      type: 'datetime',
    },
  };

  return merge(defaultConfig(points, labels), config);
};

function defaultConfig(data, labels) {
  return {
    title: '',
    legend: {
      enabled: false,
    },
    xAxis: {
      gridLineWidth: 1,
    },
    yAxis: {
      title: {
        text: null,
      },
    },
    plotOptions: {
      line: {
        animation: false,
        marker: {
          fillColor: 'transparent',
          lineColor: '#7cb5ec',
          lineWidth: 2.5,
          radius: 3.5,
        },
        lineWidth: 2,
        shadow: {
          offsetY: 1.5,
          width: 1.5,
        },
        states: {
          hover: {
            halo: {
              size: 0,
            },
            lineWidthPlus: 0,
          },
          normal: {
            animation: false,
          },
        },
      },
      series: {
        label: {
          connectorAllowed: false,
        },
        color: '#edc240',
        turboThreshold: 100000,
      },
    },
    series: [
      {
        data: data,
      },
    ],
    tooltip: {
      headerFormat: '',
      pointFormatter: function() {
        return `<span style="font-weight: bold; color: #595857;">${
          this.y
        } 倍 (${labels[this.index]})</span>`;
      },
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
  };
}
