import Chart from 'chart.js/dist/Chart.bundle'

const LineChart = (ctx, config) => {
  const shadowLineElement = Chart.elements.Line.extend({
    draw () {
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

  return new Chart(ctx, config);
};

export default LineChart;
