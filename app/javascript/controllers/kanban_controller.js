import { Controller } from '@hotwired/stimulus';
import { patch } from '@rails/request.js';
import Sortable from 'sortablejs';
import { Turbo } from '@hotwired/turbo-rails';

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = ['kanbanGroup', 'kanbanColumn', 'kanbanCard',
                    'formSortInput', 'columnMenuPop', 'columnMenuButton'];

  initSortable(els) {
    const kanbanPathId = this.kanbanGroupTarget.dataset.kanbanId;
    const updateCardsOrder = async (kanbanIds) => {
      const request = await new FetchRequest('patch',
        `http://localhost:3000/kanbans/${kanbanPathId}/sort`,
        {
          body: {
            kanban: {
              kanbanIds: JSON.stringify(kanbanIds)
            }
          }
        }).perform();
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
        group: 'kanban-col', animation: 300, onEnd: saveKanbanBinded
      });
    });
  }

  connect() {
    this.initSortable(this.kanbanColumnTargets);
  }

  toggleColumnMenu(event) {
    event.preventDefault();
    const menu = this.columnMenuPopTarget;
    const button = this.columnMenuButtonTarget;
  }
}
