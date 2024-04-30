import { Controller } from "@hotwired/stimulus"
import flatpickr from "flatpickr";

// Connects to data-controller="datepicker"
export default class extends Controller {
  connect() {
    console.log("coucou")
    flatpickr(this.element, {
      dateFormat: "d/m/Y"
    });
  }
}
