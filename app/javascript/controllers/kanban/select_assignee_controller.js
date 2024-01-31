import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="kanban--select-assignee"
export default class extends Controller {
  static targets = ['input', 'list', 'item', 'itemButton', 'selection'];

  connect() {
    console.log('kanban--select-assignee connected');
  }

  querySearch() {
  }

  select(e) {
    const toggleButtonAdd = (e) => {
      const isAdded = Boolean(e.currentTarget.dataset.isAdded);
      e.currentTarget.dataset.isAdded = String(!isAdded);
      e.currentTarget.firstElementChild.classList.toggle('hidden');
      e.currentTarget.lastElementChild.classList.toggle('hidden');
    };
    const addSelection = (value) => {
      const assigneeInput = document
        .getElementById('assigneeInput')
        .content
        .cloneNode(true)
        .querySelector('input');
      assigneeInput.setAttribute('value', value);
      this.selectionTarget.appendChild(assigneeInput);
      toggleButtonAdd(e);
    };

    this.itemTargets.forEach((item, index) => {
      if (item.dataset.itemAccountId === e.currentTarget.dataset.itemButtonId) {
        if (index > -1) {
          addSelection(item.dataset.itemAccountId);

        }
      }
    });
  }

  save() {
    console.log('send data to db');
  }
}
