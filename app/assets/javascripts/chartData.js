var chartType = 'bar'

function formatChartData(characterNames, characterLinesCount, colors, data) {
  return {
    type: chartType,
    data: chartDataObj(characterNames, characterLinesCount, colors),
    options: chartOptionsObj(data),
  }
}

function chartDataObj(characterNames, characterLinesCount, colors) {
  return {
    labels: characterNames,
    datasets: chartDataSetsArr(characterLinesCount, colors),
  }
}

function chartDataSetsArr(characterLinesCount, colors) {
  return [{
    label: '# of Lines',
    data: characterLinesCount,
    backgroundColor: colors,
    borderColor: colors,
    borderWidth: 2,
  }]
}

function chartOptionsObj(data) {
  return {
    scales: {
      yAxes: [{
        ticks: {
          beginAtZero: true,
        },
      }]
    },
    title: {
      display: true,
      text: data.title,
    },
  }
}
