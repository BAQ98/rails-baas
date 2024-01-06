import { Controller } from '@hotwired/stimulus';
import Sortable from 'sortablejs';
// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = ['kanbanGroup', 'kanbanColumn', 'kanbanCard'];

  initSortable(el) {}

  connect() {
    this.kanbanColumnTargets.forEach((col) => {
      new Sortable(col, {
        group: 'kanban-col', animation: 300
      });
    });

  }
}
