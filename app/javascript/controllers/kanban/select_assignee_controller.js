import { Controller } from '@hotwired/stimulus';
import { post } from '@rails/request.js';

// Connects to data-controller="kanban--select-assignee"
export default class extends Controller {
  static targets = ['input', 'list', 'item', 'itemButton', 'selection'];

  connect() {
    console.log('kanban--select-assignee connected');
  }

  querySearch() {
  }

  select(e) {
    let isAdded = Boolean(e.currentTarget.dataset.itemIsAdd !== 'false');
    const toggleButtonAdd = (e) => {
      e.currentTarget.dataset.itemIsAdd = String(!isAdded);
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
      assigneeInput.setAttribute('data-selection-id', value);
      this.selectionTarget.appendChild(assigneeInput);
    };

    const removeSelection = (e) => {
      this.selectionTarget.childNodes.forEach(item => {
        console.log(e.currentTarget);
        if (item.dataset.selectionId === e.currentTarget.dataset.itemButtonId) {
          item.remove();
        }
      });
    };

    if (!isAdded) {
      this.itemTargets.forEach((item, index) => {
        if (item.dataset.itemAccountId === e.currentTarget.dataset.itemButtonId) {
          if (index > -1) {
            addSelection(item.dataset.itemAccountId);
            toggleButtonAdd(e);
          }
        }
      });
    } else {
      removeSelection(e);
      toggleButtonAdd(e);
    }
  }

  save() {

  }
}
