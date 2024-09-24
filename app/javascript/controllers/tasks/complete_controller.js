// app/javascript/controllers/tasks/complete_controller.js
import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  toggle(event) {
    const checkbox = event.target;
    const taskId = checkbox.value;

    fetch(`/tasks/${taskId}/complete`, {
      method: 'PATCH',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
        'Accept': 'text/vnd.turbo-stream.html'
      }
    }).then(response => {
      if (!response.ok) {
        throw new Error('Network response was not ok');
      }
      return response.text();
    }).then(html => {
      const parser = new DOMParser();
      const doc = parser.parseFromString(html, 'text/html');
      const turboStream = doc.querySelector('turbo-stream');
      if (turboStream) {
        const template = turboStream.querySelector('template');
        if (template) {
          document.getElementById('task_list').innerHTML = template.innerHTML;
        }
      }
    }).catch(error => {
      console.error('There was a problem with the fetch operation:', error);
    });
  }
}