import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-flat"
export default class extends Controller {
  static targets = [ "form", "list", "searchInput", "searchGuest", "sorter", "minPrice", "maxPrice" ]

  connect() {
    console.log("hello from search flat controller");
  }

  fetch_flat(url) {
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

  url_constructor(sort) {
    const url = new URL(this.formTarget.action);
    const params = new URLSearchParams({
      query: this.searchInputTarget.value,
      guest: this.searchGuestTarget.value,
      min_price: this.minPriceTarget.value,
      max_price: this.maxPriceTarget.value,
    });
    if (sort !== "") {
      params.append("sort", sort);
    }
    url.search = params;
    return url.toString();
    
  }
  
  update(event) {
    event.preventDefault();
    this.fetch_flat(this.url_constructor(""));
  }

  filter(event) {
    event.preventDefault();
    this.fetch_flat(this.url_constructor(event.currentTarget.value));
    }
}
