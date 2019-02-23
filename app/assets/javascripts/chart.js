$(function () {
  const elm = document.getElementById('per-current')
  if (!elm) { return };

  const code = document.getElementById('code').textContent;
  //renderPerChart(code);
  renderPerChart(4368);
  //renderPbrChart(code);
  renderPbrChart(4368);

  async function renderPerChart(code) {
    const url = `/stock_prices/${code}/per.json`;
    const response = await axios.get(url);

    renderCurrentChart('per-current', response.data.current_year);
    renderEntireChart('per-entire', response.data.entire_period);
  }

  async function renderPbrChart(code) {
    const url = `/stock_prices/${code}/pbr.json`;
    const response = await axios.get(url);

    renderCurrentChart('pbr-current', response.data.current_year);
    renderEntireChart('pbr-entire', response.data.entire_period);
  }

  function renderCurrentChart(selector, data) {
    const labels = data.x_label
    const points = data.data.map((point) => { return {x: point[0], y: point[1]} });
    const config = _.merge(defaultConfig(points), currentConfig(labels, points));

    renderChart(selector, config);
  }

  function renderEntireChart(selector, data) {
    const labels = data.x_label
    const points = data.data.map((point) => { return {x: labels[point[0]], y: point[1]} });
    const config = _.merge(defaultConfig(points), entireConfig(labels, points));

    renderChart(selector, config);
  }

  function renderChart(selector, config) {
    const ctx = document.getElementById(selector).getContext('2d');

    const shadowLineElement = Chart.elements.Line.extend({
      draw () {
        const { ctx } = this._chart

        const originalStroke = ctx.stroke

        ctx.stroke = function () {
          ctx.save()
          ctx.shadowColor = '#d3d3d3'
          ctx.shadowBlur = 2
          ctx.shadowOffsetX = 2
          ctx.shadowOffsetY = 4
          originalStroke.apply(this, arguments)
          ctx.restore()
        }

        Chart.elements.Line.prototype.draw.apply(this, arguments)

        ctx.stroke = originalStroke;
      }
    })

    Chart.defaults.shadowLine = Chart.defaults.line
    Chart.controllers.shadowLine = Chart.controllers.line.extend({
      datasetElementType: shadowLineElement
    })

    const chart = new Chart(ctx, config);
  }

  function defaultConfig(points) {
    return {
      type: 'shadowLine',
      data: {
        datasets: [
          {
            data: points,
            backgroundColor: '#edc240',
            borderColor: '#edc240',
            fill: false,
            pointHoverBackgroundColor: 'transparent',
            pointHoverBorderColor: '#afd8f8',
            pointHoverBorderWidth: 4,
            pointHoverRadius: 6,
            pointRadius: 0,
          }
        ]
      },
      options: {
        animation: {
            duration: 0,
        },
        elements: {
            line: {
                tension: 0.1,
            }
        },
        hover: {
            animationDuration: 0,
        },
        legend: {
          display: false
        },
        responsive: true,
        maintainAspectRatio: false,
        responsiveAnimationDuration: 0,
        scales: {
          xAxes: [{
            gridLines: {
              drawTicks: false,
            },
            ticks: {
              autoSkip: false,
              padding: 10,
              maxRotation: 45,
            }
          }],
          yAxes: [{
            gridLines: {
              drawTicks: false,
            },
            ticks: {
              padding: 10,
              maxTicksLimit: 6,
            }
          }]
        },
        tooltips: {
          callbacks: {
            title: (item, data) => {},
          },
          displayColors: false,
          caretPadding: 5,
        },
      }
    };
  }

  function currentConfig(labels, points) {
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
});
