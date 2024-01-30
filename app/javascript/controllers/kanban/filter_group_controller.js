import { Controller } from '@hotwired/stimulus';
import { useClickOutside } from 'stimulus-use';
// Connects to data-controller="kanban--filter-group"
export default class extends Controller {
  static targets = ['button', 'menu'];

  connect() {
    useClickOutside(this);
  }

  clickOutside(event) {
    event.preventDefault();
    this.hide();
  }

  hide() {
    this.menuTarget.classList.add('hidden');
  }

  toggleMenu() {
    this.menuTarget.classList.toggle('hidden');
  }
}
