import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    const titleField = this.element.querySelector("#task_title");
    
    if (titleField) {
      titleField.focus();
    }    
  }
}
