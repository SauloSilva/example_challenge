import { fetchRequest } from '../settings'

async function addTransaction(merchant, time, amount) {
  const body = { "transaction": { "merchant": merchant, "time": time, "amount": amount }}
  const response = await fetchRequest('POST', body);
  return response.json();
}

export { addTransaction }
