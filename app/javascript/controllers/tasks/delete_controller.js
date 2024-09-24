import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static values = { url: String }

  delete(event) {
    event.preventDefault()

    if (confirm('Are you sure?')) {
      fetch(this.urlValue, {
        method: 'DELETE',
        headers: {
          'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content,
          'Accept': 'text/vnd.turbo-stream.html'
        }
      }).then(response => {
        if (response.ok) {
          Turbo.visit(window.location.href)
        } else {
          console.error('Failed to delete the task')
        }
      })
    }
  }
}