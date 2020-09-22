const apiHost = `http://localhost:3000/operations`

function fetchRequest(method, body = {}) {
  const settings = fetchOptions(method, body)
  return fetch(apiHost, settings);
}

function fetchOptions(method, body) {
  const settings = {
    method: method,
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    }
  }

  if (body) {
    body = { body: JSON.stringify(body) }
    Object.assign(settings, body);
  }

  return settings;
}

function toBool(val) {
  return val == "true"
}

export { fetchRequest, toBool }
