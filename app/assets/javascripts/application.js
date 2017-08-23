// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

(function(){
  document.addEventListener('submit', function(e){
    e.preventDefault()
    var authenticity_token = e.target.elements.authenticity_token.value
    var url = e.target.elements.url.value
    submitXMLUrl(url, authenticity_token)
  })

  function progressSubmit(data, error) {
    console.log('progressSubmit: ', data, error)
  }

  function loadSubmit(data) {
    var parsedData;
    console.log('loadSubmit: ', data)
    if (data.target.status !== 200) {
      parsedData = formatError(data.target.statusText)
    }else{
      parsedData = parseDataForPage(data.target.response)
      chartData = formatDataForChart(parsedData)
      parsedData = convertToHTMLForPage(parsedData)
    }
    document.querySelector('.play_lines_output').innerHTML = parsedData
    resetSubmit()
  }

  function errorSubmit(data, error) {
    console.log('errorSubmit: ', data, error)
  }

  function abortSubmit(data, error) {
    console.log('abortSubmit: ', data, error)
  }

  function submitXMLUrl(url, token){
    var xhrRequest = new XMLHttpRequest()
    xhrRequest.addEventListener('progress', progressSubmit)
    xhrRequest.addEventListener('load', loadSubmit)
    xhrRequest.addEventListener('error', errorSubmit)
    xhrRequest.addEventListener('abort', abortSubmit)
    xhrRequest.open('POST', '/home', true)
    xhrRequest.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded')
    xhrRequest.setRequestHeader('X-CSRF-TOKEN', token)
    xhrRequest.setRequestHeader('Accept', 'application/json')
    xhrRequest.send('url=' + url)
  }
})()

function parseDataForPage(data) {
  var play = JSON.parse(data)
  play.characters = parseCharactersAndLines(play.characters)
  return play
}

function parseCharactersAndLines(characters) {
  return characters.map(function(character){
    return JSON.parse(character)
  })
}

function formatDataForChart(data) {
  var ctx = document.getElementById('chart').getContext('2d')
  var chart = new Chart(ctx, {
    type: 'bar',
    data: {
      labels: data.characters.map(function(character){ return character.name }),
      datasets: [{
        label: '# of Lines',
        data: data.characters.map(function(character){ return character.lines }),
        backgroundColor: [
          'rgba(255, 99, 132, 0.2)',
          'rgba(54, 162, 235, 0.2)',
          'rgba(255, 206, 86, 0.2)',
          'rgba(75, 192, 192, 0.2)',
          'rgba(153, 102, 255, 0.2)',
          'rgba(255, 159, 64, 0.2)'
        ],
        borderColor: [
          'rgba(255,99,132,1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      scales: {
        yAxes: [{
          ticks: {
            beginAtZero: true
          }
        }]
      }
    }
  })
}

function formatError(error) {
  return (
    `
      <h1>Content ${error}</h1>
      <h2>Please try again</h2>
    `
  )
}

function convertToHTMLForPage(data) {
  return (
    `
      <h1>Play Title</h1>
      <h2>${data.title}</h2>
      <ul>${createLiElements(data.characters)}</ul>
    `
  )
}

function createLiElements(characters) {
  return characters.map(function(character){
    return (
      `
        <li>
          <strong>Character: </strong>${character.name}
          <br>
          <strong>Number of Lines: </strong>${character.lines}
        </li>
      `
    )
  }).join(" ")
}

function resetSubmit() {
  var submitButton = document.querySelector('input[type=submit]')
  submitButton.disabled = false
}
