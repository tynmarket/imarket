import merge from 'lodash/fp/merge';

export const options = {
  lang: {
    numericSymbols: null, // 数字を省略しない
    thousandsSep: ',', // 桁区切り
  },
};

export const n225Config = (points, prices, labels, name, interval) => {
  const config = {
    xAxis: {
      tickInterval: interval, // ラベル表示間隔
    },
    series: [
      {
        name: name,
        type: 'line',
        data: points,
        color: '#edc240',
      },
      {
        name: '日経平均',
        type: 'line',
        yAxis: 1, // 右縦軸
        data: prices,
      },
    ],
  };

  return merge(defaultConfig(labels), config);
};

export const dowConfig = (pointsCurrent, pointsNext, prices, labels) => {
  const config = {
    xAxis: {
      tickInterval: 10, // ラベル表示間隔
    },
    series: [
      {
        name: 'Earnings Estimate (Current Year)',
        type: 'line',
        data: pointsCurrent,
        color: '#edc240',
      },
      {
        name: 'Earnings Estimate (Next Year)',
        type: 'line',
        data: pointsNext,
        color: '#edc240',
      },
      {
        name: 'ダウ平均',
        type: 'line',
        yAxis: 1, // 右縦軸
        data: prices,
        color: '#7cb5ec',
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
      zoomType: 'x', // Zoomする
    },
    xAxis: {
      crosshair: true, // 十字線を表示する
      gridLineWidth: 1,
      labels: {
        formatter: function() {
          return `${labels[this.value]}`; // x軸のラベル
        },
      },
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
        opposite: true, // 第2縦軸は右に表示
      },
    ],
    plotOptions: {
      line: {
        animation: false, // グラフ表示時のアニメーションを表示しない
        lineWidth: 2,
        shadow: {
          offsetY: 1.5,
          width: 1.5,
        },
      },
      series: {
        marker: {
          enabled: false, // マーカーを表示しない
        },
        states: {
          hover: {
            enabled: false, // hover時のマーカーを表示しない
          },
          inactive: {
            opacity: 1, // inactive時に半透明にしない
          },
        },
        turboThreshold: 100000,
      },
    },
    tooltip: {
      headerFormat: '',
      shared: true, // 系列のツールチップをまとめて表示する
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
