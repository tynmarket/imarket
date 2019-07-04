import getYear from 'date-fns/get_year';
import merge from 'lodash/fp/merge';
import range from 'lodash/range';

export const currentConfigFn = (labels, points) => {
  const config = {
    data: {
      datasets: [
        {
          borderWidth: 2,
          pointHitRadius: 7,
        },
      ],
    },
    options: {
      scales: {
        xAxes: [
          {
            type: 'linear',
            ticks: {
              callback: value => labels[value],
              max: labels.length,
              stepSize: 60,
            },
          },
        ],
      },
      tooltips: {
        callbacks: {
          label: item => {
            const point = points[item.index];
            const value = point.y;
            return ` ${value} 倍（${labels[point.x]}）`;
          },
        },
      },
    },
  };

  return merge(defaultConfig(points), config);
};

export const currentPointFn = () => point => {
  return { x: point[0], y: point[1] };
};

export const entireConfigFn = (labels, points) => {
  const first = getYear(labels[0]);
  const last = getYear(labels[labels.length - 1]);
  const labelsRange = range(first, last + 1).map(v => v.toString());

  const config = {
    labels: labelsRange,
    data: {
      datasets: [
        {
          borderWidth: 1.5,
          pointHitRadius: 2,
        },
      ],
    },
    options: {
      scales: {
        xAxes: [
          {
            type: 'time',
            time: {
              unit: 'year',
              stepSize: 1,
            },
          },
        ],
      },
      tooltips: {
        callbacks: {
          label: item => {
            const point = points[item.index];
            const value = point.y;
            return ` ${value} 倍（${point.x}）`;
          },
        },
      },
    },
  };

  return merge(defaultConfig(points), config);
};

export const entirePointFn = labels => (point, i) => {
  return { name: labels[i], y: point[1] };
};

function defaultConfig(data) {
  return {
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
