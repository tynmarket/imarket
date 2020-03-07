import axios from 'axios';
import Highcharts from 'highcharts/highstock';

const CandleStick = () => {
  const url = '/stock_prices/n225f/ohlc?period=ten&from=2018-01-01%2000:00:00&to=2018-01-31%2023:59:59';

  (async () => {
    const response = await axios.get(url);

    Highcharts.stockChart('candle-stick-chart', {
      rangeSelector: {
          buttons: [{
              type: 'hour',
              count: 1,
              text: '1h'
          }, {
              type: 'day',
              count: 1,
              text: '1D'
          }, {
              type: 'all',
              count: 1,
              text: 'All'
          }],
          selected: 1,
      },

      series: [{
          name: '日経平均先物',
          type: 'candlestick',
          data: response.data,
          pointPadding: -0.2,
          dataGrouping: {
            enabled: false,
          },
          color: "#648cd0",
          lineColor: "#3366cc",
          upLineColor: "#696969"
      }]
    });
  })();
}

export default CandleStick;
