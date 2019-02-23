$(function () {
  const elm = document.getElementById('per-current')
  if (!elm) { return };

  const code = document.getElementById('code').textContent;
  //renderPerChart(code);
  renderPerChart(4368);

  async function renderPerChart(code) {
    const url = `/stock_prices/${code}/per.json`;
    const response = await axios.get(url);
    renderChart('per-current', response.data.current_year);
    renderChart('per-entire', response.data.entire_period);
  }

  function renderChart(selector, data) {
    const ctx = document.getElementById(selector).getContext('2d');
    const labels = data.x_label;
    const points = data.data.map((point) => { return {x: point[0], y: point[1]} });

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

    const chart = new Chart(ctx, {
        type: 'shadowLine',
        data: {
          datasets: [
            {
              data: points,
              backgroundColor: '#edc240',
              borderColor: '#edc240',
              borderWidth: 2,
              fill: false,
              pointHitRadius: 5,
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
              type: 'linear',
              gridLines: {
                drawTicks: false,
              },
              ticks: {
                callback: (value, i, values) => labels[value],
                autoSkip: false,
                padding: 10,
                max: labels.length,
                maxRotation: 45,
                stepSize: 60
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
              label: (item, data) => {
                const point = points[item.index]
                const value = point.y
                return ` ${value} 倍（${labels[point.x]}）`
              },
              title: (item, data) => {},
            },
            displayColors: false,
          },
        }
    });
  }
});
