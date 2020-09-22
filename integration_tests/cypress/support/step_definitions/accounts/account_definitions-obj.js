import { fetchRequest, toBool } from '../settings'

async function deleteOperations() {
  const response = await fetchRequest('DELETE');
  return response.json();
}

async function addAccount(availableLimit, activeCard) {
  const body = { "account": { "activeCard": toBool(activeCard), "availableLimit": availableLimit }}
  const response = await fetchRequest('POST', body);
  return response.json();
}

export {
    deleteOperations,
    addAccount
}
