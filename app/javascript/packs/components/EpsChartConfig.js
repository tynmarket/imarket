import merge from 'lodash/fp/merge';

export const options = {
  lang: {
    numericSymbols: null, // 数字を省略しない
    thousandsSep: ',', // 桁区切り
  },
};

export const n225Config = (pointsN225, pointsN225R, prices, labels) => {
  const config = {
    series: [
      {
        name: '予想EPS（日経）',
        type: 'line',
        data: pointsN225,
      },
      {
        name: '予想EPS（iMarket）',
        type: 'line',
        data: pointsN225R,
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
      tickInterval: 20, // ラベル表示間隔
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
