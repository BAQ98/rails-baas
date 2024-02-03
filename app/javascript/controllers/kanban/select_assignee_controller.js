import { Controller } from '@hotwired/stimulus';
import { get, FetchRequest } from '@rails/request.js';
import { Turbo } from '@hotwired/turbo-rails';

// Connects to data-controller="kanban--select-assignee"
export default class extends Controller {
  static targets = ['input', 'list', 'item',
                    'itemButton', 'selection',
                    'selectionInput'];

  static values = { assigneesList: { type: Array, default: [] } };

  connect() {
    console.log('kanban--select-assignee connected');
    this.setAssignees();
  }

  async setAssignees() {
    const response = await get(`http://127.0.0.1:3000/api/kanban_assignees`, {
      headers: {
        Accept: 'application/json'
      },
      query: {
        'kanban_assignees[kanban_id]': this.selectionTarget.dataset.kanbanId
      }
    });

    this.assigneesListValue = await response.json;

    this.assigneesListValue.forEach(item => {
      // add to list input
      this.addSelection(null, item.profile_id);
      // toggle button add if input exist

      this.itemButtonTargets.forEach(ib => {
        if (Number(ib.dataset.itemButtonId) === item.profile_id) {
          ib.dataset.itemIsAdd = String(true);
          ib.firstElementChild.classList.toggle('hidden');
          ib.lastElementChild.classList.toggle('hidden');
        }
      });
    });

  }

  querySearch() {
  }

  addSelection(_, value) {
    const assigneeInput = document
      .getElementById('assigneeInput')
      .content
      .cloneNode(true)
      .querySelector('input');
    assigneeInput.setAttribute('value', value);
    assigneeInput.setAttribute('data-selection-id', value);
    this.selectionTarget.appendChild(assigneeInput);
  };

  select(e) {
    let isAdded = Boolean(e.currentTarget.dataset.itemIsAdd !== 'false');
    const toggleButtonAdd = (e) => {
      e.currentTarget.dataset.itemIsAdd = String(!isAdded);
      e.currentTarget.firstElementChild.classList.toggle('hidden');
      e.currentTarget.lastElementChild.classList.toggle('hidden');
    };

    const removeSelection = (e) => {
      this.selectionTarget.childNodes.forEach(item => {
        if (item.dataset.selectionId === e.currentTarget.dataset.itemButtonId) {
          item.remove();
        }
      });
    };

    if (!isAdded) {
      this.itemTargets.forEach((item, index) => {
        if (item.dataset.itemAccountId === e.currentTarget.dataset.itemButtonId) {
          if (index > -1) {
            this.addSelection(e, item.dataset.itemAccountId);
            toggleButtonAdd(e);
          }
        }
      });
    } else {
      removeSelection(e);
      toggleButtonAdd(e);
    }
  }

  async save() {
    const assignees_list_in_kanban = [];
    this.selectionInputTargets.forEach(item => {
      assignees_list_in_kanban.push({
        kanban_id: Number(this.selectionTarget.dataset.kanbanId),
        profile_id: Number(item.value)
      });
    });

    const request = new FetchRequest('post',
      `http://127.0.0.1:3000/api/kanban_assignees`,
      {
        body: {
          kanban_assignees: {
            assignees_list_in_kanban: JSON.stringify(assignees_list_in_kanban),
            kanban_id: Number(this.selectionTarget.dataset.kanbanId)
          }
        },
        responseKind: 'turbo-stream'
      });
    const { response } = await request.perform();
    console.log(response);
    if (response.ok) {
      Turbo.visit(`/kanbans/${this.selectionTarget.dataset.kanbanId}`);
    }
  }

}
