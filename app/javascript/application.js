// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"


Turbo.config.forms.confirm = (message, element) => {
  let dialog = document.getElementById("turbo-confirm")
  let title = element.dataset.confirmTitle || "Confirm Action"
  let confirmMessage = message || "Are you sure?"

  dialog.querySelector("#modal-title").textContent = title
  dialog.querySelector("#modal-message").textContent = confirmMessage

  dialog.showModal()

  return new Promise((resolve, reject) => {
    dialog.addEventListener("close", () => {
      resolve(dialog.returnValue === "confirm")
    }, { once: true })
  })
}