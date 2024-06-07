import { Application } from "@hotwired/stimulus"

// import GroceryItemsController from './grocery_items_controller.js'

const application = Application.start()

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

// Stimulus.register('grocery-items', GroceryItemsController)

export { application }
