import { Controller } from '@hotwired/stimulus';

// Connects to data-controller="kanban--card-comment"
export default class extends Controller {
  static targets = ['comment'];

  connect() {
  }

  toggleComment(e) {
    this.commentTargets.forEach(item => {
      if (item.dataset.targetId === e.currentTarget.dataset.commentButtonId) {
        item.querySelector('span').classList.toggle('hidden');
        item.querySelector('form').classList.toggle('hidden');
      }
    });
  }
}
