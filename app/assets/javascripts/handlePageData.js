function handleError(data) {
  formattedError = formatError(data.target.statusText)
  docQuerySelector('.play_lines_output').innerHTML = formattedError
}

function formatError(error) {
  return (
    `
      <p class="mb-0">Content ${error}</p>
      <p class="mb-0">Please try again</p>
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

function resetSubmit() {
  var submitButton = docQuerySelector('input[type=submit]')
  submitButton.disabled = false
}

function resetInput() {
  var inputBox = docQuerySelector('input[type=text]')
  inputBox.value = ''
}
