import { Controller } from '@hotwired/stimulus';
import { get, patch } from '@rails/request.js';
import Sortable from 'sortablejs';

// Connects to data-controller="kanban--card-dragndrop"
export default class extends Controller {
  static targets = ['kanbanGroup', 'kanbanColumn', 'kanbanCard',
                    'formSortInput'];
  static values = { isAuthorized: { type: Boolean } };

  metaContent() {

  };

  connect() {
    this.isAssignees().then(() => {
      this.initSortable(this.kanbanColumnTargets);
    });
  }

  url() {
    return document.head.querySelector('meta[name=rails_env]').content === 'development'
           ? 'http://127.0.0.1:3000' : '';
  }

  async initSortable(els) {
    const kanbanPathId = this.kanbanGroupTarget.dataset.kanbanId;
    const updateCardsOrder = async (kanbanIds) => {
      return await patch(
        `${this.url()}/kanbans/${kanbanPathId}/sort`,
        {
          headers: {
            'ACCEPT': 'application/json'
          },
          body: {
            kanban: {
              kanbanIds: JSON.stringify(kanbanIds)
            }
          }
        });
    };

    const saveKanban = (colElements) => {
      const kanbanIds = { 'columns': [] };
      colElements.forEach(col => {
        const cardIds = [];
        col.querySelectorAll('a')
          .forEach(card => cardIds.push(Number.parseInt(card.dataset.kanbanCardId, 10)));
        kanbanIds.columns.push({
          'id': Number.parseInt(col.dataset.kanbanColId, 10), 'cardIds': cardIds
        });
      });

      updateCardsOrder(kanbanIds);
    };

    els.forEach((col) => {
      const saveKanbanBinded = saveKanban.bind(null, els);
      new Sortable(col, {
        group: 'kanban-col',
        animation: 300,
        onEnd: saveKanbanBinded,
        disabled: !this.isAuthorizedValue // Disables the sortable if set to true.
      });
    });
  }

  async isAssignees() {
    const response = await get(`${this.url()}/api/kanban_assignees`, {
      headers: {
        Accept: 'application/json'
      },
      query: {
        'kanban_assignees[kanban_id]': this.kanbanGroupTarget.dataset.kanbanId
      }
    });

    const assignees = await response.json;
    const currentUserId = Number(this.kanbanGroupTarget.dataset.currentUserId);
    const isAuthorized = assignees.some(item => item.profile_id === currentUserId);
    this.isAuthorizedValue = isAuthorized;
  };
}
