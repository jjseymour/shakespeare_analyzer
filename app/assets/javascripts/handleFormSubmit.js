function handleSubmit(e){
  e.preventDefault()
  var authenticity_token = e.target.elements.authenticity_token.value
  var url = e.target.elements.url.value
  resetChartAndError()
  submitXMLUrl(url, authenticity_token)
}

function resetChartAndError() {
  docQuerySelector('.play_lines_output').innerHTML = ""
  if (CHART) CHART.destroy()
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

function progressSubmit(data, error) {
  console.log('progressSubmit: ', data, error)
}

function errorSubmit(data, error) {
  console.log('errorSubmit: ', data, error)
}

function abortSubmit(data, error) {
  console.log('abortSubmit: ', data, error)
}

function loadSubmit(data) {
  if (data.target.status !== 200) {
    handleError(data)
  }else{
    handleData(data)
  }
  resetSubmit()
  resetInput()
}
