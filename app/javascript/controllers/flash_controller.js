import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["message"]

  connect() {
    setTimeout(() => {
      this.dismiss()
    }, 4000)
  }

  dismiss() {
    this.element.classList.add('opacity-0')
    setTimeout(() => {
      this.element.remove()
    }, 500)
  }
}