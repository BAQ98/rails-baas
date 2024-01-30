import { Controller } from '@hotwired/stimulus';
import { FetchRequest } from '@rails/request.js';
import Sortable from 'sortablejs';

// Connects to data-controller="kanban--card-dragndrop"
export default class extends Controller {
  static targets = ['kanbanGroup', 'kanbanColumn', 'kanbanCard',
                    'formSortInput'];

  connect() {
    console.log('things');
  }

  initSortable(els) {
    const kanbanPathId = this.kanbanGroupTarget.dataset.kanbanId;
    const updateCardsOrder = async (kanbanIds) => {
      await new FetchRequest('patch',
        `http://127.0.0.1:3000/kanbans/${kanbanPathId}/sort`,
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

}
