import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    console.log('controller loaded');

    const titleField = this.element.querySelector("#task_title");
    if (titleField) {
      titleField.focus();
    }    
  }
}
