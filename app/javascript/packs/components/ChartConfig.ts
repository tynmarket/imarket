import {
  AxisLabelsFormatterContextObject,
  Options,
  SeriesLineDataOptions,
} from 'highcharts';
import dayjs from 'dayjs';
import merge from 'lodash/fp/merge';

export interface ConfigFn {
  (points: Point[], labels: string[]): Options;
}

export const currentConfigFn = (points: Point[], labels: string[]): Options => {
  const config = {
    xAxis: {
      tickInterval: 60,
      labels: {
        formatter: function(this: AxisLabelsFormatterContextObject): string {
          return `${labels[this.value]}`;
        },
      },
    },
  };

  return merge(defaultConfig(points, labels), config);
};

export type Point = number | SeriesLineDataOptions;

export interface PointFun {
  (point: number, i: number): Point;
}

/* eslint-disable @typescript-eslint/explicit-function-return-type */
export const entirePointFn: (labels: string[]) => PointFun = (
  labels: string[]
) => (point: number, i: number): Point => {
  return {
    x: dayjs(`${labels[i]}T00:00Z`)
      .toDate()
      .getTime(),
    y: point,
    key: i,
  };
};
/* eslint-enable @typescript-eslint/explicit-function-return-type */

export const entireConfigFn = (points: Point[], labels: string[]): Options => {
  const config = {
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
    },
  };

  return merge(defaultConfig(points, labels), config);
};

function defaultConfig(points: Point[], labels: string[]): Options {
  return {
    title: {
      text: '',
    },
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
        type: 'line',
        data: points,
      },
    ],
    tooltip: {
      headerFormat: '',
      pointFormatter: function(): string {
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
