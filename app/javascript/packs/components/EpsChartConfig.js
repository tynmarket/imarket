import dayjs from 'dayjs';
import merge from 'lodash/fp/merge';

export const n225Config = (pointsN225, pointsN225R, prices, labels) => {
  const config = {
    xAxis: {
      tickInterval: 20,
      labels: {
        formatter: function() {
          return `${labels[this.value]}`;
        },
      },
    },
    series: [
      {
        type: 'line',
        data: pointsN225,
      },
      {
        type: 'line',
        data: pointsN225R,
      },
      {
        type: 'line',
        yAxis: 1,
        data: prices,
      },
    ],
  };

  return merge(defaultConfig(labels), config);
};

function defaultConfig(labels) {
  return {
    title: {
      text: '',
    },
    legend: {
      enabled: false,
    },
    chart: {
      zoomType: 'x',
    },
    xAxis: {
      type: 'datetime',
      dateTimeLabelFormats: {
        day: '%Y-%m-%d',
        week: '%Y-%m-%d',
        month: '%Y-%m-%d',
      },
      gridLineWidth: 1,
    },
    yAxis: [
      {
        title: {
          text: null,
        },
      },
      {
        title: {
          text: null,
        },
        opposite: true,
      },
    ],
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
