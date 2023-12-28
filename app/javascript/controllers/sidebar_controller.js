import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["sidebar"];

  openUsers() {
    document.getElementById("dropdown-users").classList.toggle("hidden");
  }
}
