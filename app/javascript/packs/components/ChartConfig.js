import merge from 'lodash/fp/merge';

export const pointFn = labels => (point, i) => {
  return { name: labels[i], y: point[1] };
};

export const currentConfigFn = (points, labels) => {
  const config = {
    xAxis: {
      tickInterval: 60,
    },
  };

  return merge(defaultConfig(points, labels), config);
};

export const entireConfigFn = (points, labels) => {
  const config = {
    xAxis: {
      tickInterval: 245,
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
      labels: {
        formatter: function() {
          return `${labels[this.value]}`;
        },
      },
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
        name: 'Installation',
        data: data,
      },
    ],
    tooltip: {
      headerFormat: '',
      pointFormatter: function() {
        return `<span style="font-weight: bold; color: #595857;">${
          this.y
        } 倍 (${this.name})</span>`;
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
