import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-flat"
export default class extends Controller {
  static targets = [ "form", "list", "searchInput", "searchGuest" ]

  connect() {
    console.log("hello from search flat controller");
  }
  
  update(event) {
    event.preventDefault();
    let searchValue = this.searchInputTarget.value;
    const url = `${this.formTarget.action}?query=${searchValue}&guest=${this.searchGuestTarget.value}`
    // on va chercher les données de sur l'URL de l'action du formulaire avec les query params
    // les headers permettent de dire qu'on veut récupérer du text/plain 
    fetch(url, { headers: { 'Accept': 'text/plain' } })
      // on récupère la réponse en texte
      .then(response => response.text())
      // on affiche le texte dans la console
      // on remplace le contenu de la liste par le texte
      .then((data) => {
        this.listTarget.outerHTML = data;
        // remettre l'input à vide
        // this.searchGuestTarget.value = '';
        // this.searchInputTarget.value = '';
      }
    )
  }
}
