import { Controller } from '@hotwired/stimulus';
import Sortable from 'sortablejs';
import { FetchRequest } from '@rails/request.js';

// Connects to data-controller="kanban"
export default class extends Controller {
  static targets = ['kanbanGroup', 'kanbanColumn', 'kanbanCard',
                    'formSortInput'];

  initSortable(els) {
    const updateCardsOrder = async (kanbanIds) => {
      const request = new FetchRequest(
        'patch',
        `http://localhost:3000/kanbans/${this.kanbanGroupTarget.dataset.kanbanId}/sort`,
        {
          body: {
            kanban: {
              kanbanIds: JSON.stringify(kanbanIds)
            }
          }
        }
      );
      const response = await request.perform();
    };

    const saveKanban = (colElements) => {
      const kanbanIds = { 'columns': [] };
      colElements.forEach(col => {
        const cardIds = [];
        col.querySelectorAll('a')
          .forEach(card => cardIds.push(
            Number.parseInt(card.dataset.kanbanCardId, 10)));
        kanbanIds.columns.push(
          {
            'id': Number.parseInt(col.dataset.kanbanColId, 10),
            'cardIds': cardIds
          }
        );
      });
      updateCardsOrder(kanbanIds);
    };

    els.forEach((col) => {
      const saveKanbanBinded = saveKanban.bind(null, els);
      new Sortable(col, {
        group: 'kanban-col',
        animation: 300,
        onEnd: saveKanbanBinded
      });
    });
  }

  connect() {
    this.initSortable(this.kanbanColumnTargets);
  }
}
