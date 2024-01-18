import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="column-menu"
export default class extends Controller {

  static targets = ['columnMenuPop', 'columnMenuButton'];

  connect() {

  }

  getMenuTarget(event) {
    return this.columnMenuPopTargets.find(el => {
        return (el.dataset['kanban-ColumnMenuId'] === event.currentTarget.dataset['kanban-ColumnButtonId']);
      }
    );
  }

  toggleColumnMenu(event) {
    event.preventDefault();
    const menu = this.getMenuTarget(event);
    if (menu.classList.contains('hidden')) {
      this.showColumnMenu(menu);
    } else {
      this.hideColumnMenu(null, menu);
    }
  }

  showColumnMenu(menu) {
    menu.classList.remove('hidden');
  }

  hideColumnMenu(event, menu) {
    if (event && (menu.contains(event.target) || this.columnMenuButtonTarget.contains(event.target))) {
      return;
    }
    this.columnMenuPopTarget.classList.add('hidden');
  }
}
