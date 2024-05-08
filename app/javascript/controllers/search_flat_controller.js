import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-flat"
export default class extends Controller {
  static targets = [ "form", "list", "searchInput" ]

  connect() {
    console.log(this.element);
    console.log(this.formTarget);
    console.log(this.listTarget);
    console.log(this.searchInputTarget);
  }

  update() {
    const url = `${this.formTarget.action}?query=${this.searchInputTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        console.log(data);
        this.listTarget.outerHTML = data;
      })
  }

  // submit(event) {
  //   // prevent default form submission
  //   event.preventDefault()
  //   console.log("Submit")
  //   var input_value = this.inputTarget.value;

  //   // fetch the search results
  //   fetch(`/flats?query=${input_value}`)
  //     .then(response => {
  //       response.text();
  //     })
  //     .then(html => {
  //       console.log(html)
  //       // replace the search results
  //       // document.getElementById("search-results").innerHTML = html
  //     })
  //     .catch(error => {
  //       console.error(error)
  //     })
  //   // display the search results
  // }
}
