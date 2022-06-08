import { Controller } from "stimulus"

export default class extends Controller {
  static targets = ["list"]

  connect() {
    console.log('Hello, Stimulus!');
  }

  update(event) {
    console.log(event.currentTarget);
    const category = event.currentTarget.dataset.shipment;

    const url = `/shipments?query=${category}`
    fetch(url, { headers: { "Accept": "text/plain" } })
    .then(response => response.text())
    .then((data) => {
      this.listTarget.innerHTML = data;
    })

  }
}
