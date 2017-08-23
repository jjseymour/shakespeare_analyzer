function handleError(data) {
  formattedError = formatError(data.target.statusText)
  docQuerySelector('.play_lines_output').innerHTML = formattedError
}

function formatError(error) {
  return (
    `
      <h1>Content ${error}</h1>
      <h2>Please try again</h2>
    `
  )
}

function handleData(data) {
  parsedData = parseDataForPage(data.target.response)
  formatDataForChart(parsedData)
}

function parseDataForPage(data) {
  var play = parseJSON(data)
  play.characters = parseCharactersAndLines(play.characters)
  return play
}

function parseCharactersAndLines(characters) {
  return characters.map(function(character) {
    return parseJSON(character)
  })
}

function formatDataForChart(data) {
  var ctx = docQuerySelector('#chart').getContext('2d')
  var characterNames = parseCharacterNamesForChart(data.characters)
  var characterLinesCount = parseCharacterLinesForChart(data.characters)
  var colors = createColorsForChart(characterNames.length)
  var chartData = formatChartData(characterNames, characterLinesCount, colors, data)
  createChart(ctx, chartData)
}

function parseCharacterNamesForChart(characters) {
  return characters.map(function(character) { return character.name })
}

function parseCharacterLinesForChart(characters) {
  return characters.map(function(character) { return character.lines })
}

function createColorsForChart(colorsNum) {
  var arr = []
  loopNTimes(colorsNum)(function(i) { return arr.push(COLORS[i%4]) })
  return arr
}

function createChart(ctx, chartData) {
  CHART = new Chart(ctx, chartData)
}
