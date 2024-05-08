import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fetch-activities"
export default class extends Controller {
  static targets =  ["address", "activities"]

  connect() {
    this.fetchActivities();
  }

  getCityFromAddress(address) {
    return address.split(',').slice(-1)[0].trim();
  };

  fetchActivities() {
    var city = this.getCityFromAddress(this.addressTarget.innerText);
    fetch(`http://localhost:3000/activities?city=${city}`)
      .then(response => response.json())
      .then((data) => {
        console.log(data);
        this.activitiesTarget.innerHTML = `
          <h2>Activities in ${city}</h2>
          <ul>
            ${data.map(item => `<li>${item.activity}</li>`).join('')}
          </ul>
        `;
      });
  }
}

// get city from address, input: "48 rue marguerite de rochechouart, Paris"
// output: "Paris"

