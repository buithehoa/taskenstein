// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import { Turbo } from "@hotwired/turbo-rails";
import flatpickr from "flatpickr";
import "controllers"

document.addEventListener("turbo:load", () => {
    console.log('turbo loaded');

    flatpickr(".datetimepicker", {
        enableTime: true,
        dateFormat: "Y-m-d H:i",
    });
});
