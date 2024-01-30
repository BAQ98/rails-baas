import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="kanban--select-assignee"
export default class extends Controller {
  connect() {
    console.log('kanban--select-assignee connected');
  }

}
