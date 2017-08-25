var CHART;
var COLORS = [
  'rgba(255, 99, 132, 0.2)',
  'rgba(54, 162, 235, 0.2)',
  'rgba(255, 206, 86, 0.2)',
  'rgba(75, 192, 192, 0.2)',
  'rgba(153, 102, 255, 0.2)',
  'rgba(255, 159, 64, 0.2)',
]

function docQuerySelector(selector) {
  return document.querySelector(selector)
}

function parseJSON(data) {
  return JSON.parse(data)
}

function loopNTimes(n) {
  return function(f) {
    var iter = function(i) {
      if (i === n) return
      f(i)
      iter(i + 1)
    }
    return iter(0)
  }
}
