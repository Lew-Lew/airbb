import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-flat"
export default class extends Controller {
  static targets = [ "form", "list", "searchInput", "searchGuest", "sorter", "minPrice", "maxPrice" ]

  connect() {
    console.log("hello from search flat controller");
  }


  
  update(event) {
    event.preventDefault();
    this.searchValue = this.searchInputTarget.value;
    this.searchGuest = this.searchGuestTarget.value;
    this.minPrice = this.minPriceTarget.value;
    this.maxPrice = this.maxPriceTarget.value;
    const url = `${this.formTarget.action}?query=${this.searchValue}&guest=${this.searchGuest}&min_price=${this.minPrice}&max_price=${this.maxPrice}`
    // on va chercher les données de sur l'URL de l'action du formulaire avec les query params
    // les headers permettent de dire qu'on veut récupérer du text/plain 
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      // on récupère la réponse en texte
      .then(response => response.text())
      // on affiche le texte dans la console
      // on remplace le contenu de la liste par le texte
      .then((data) => {
        this.listTarget.outerHTML = data;
      }
    )
  }

  filter(event) {
    console.log(event.currentTarget.value);
    console.log(this.searchValue)
    const url = `${this.formTarget.action}?query=${this.searchValue}&guest=${this.searchGuest}&min_price=${this.minPrice}&max_price=${this.maxPrice}&sort=${event.currentTarget.value}`
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      .then(response => response.text())
      .then((data) => {
        this.listTarget.outerHTML = data;
      }
    )
  }
}
