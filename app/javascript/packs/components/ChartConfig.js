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
  return { x: labels[i], y: point[1] };
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
        turboThreshold: 100000,
      },
    },
    series: [
      {
        name: 'Installation',
        data: data.map(plot => plot[1]),
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
  };
}
