// Load all the channels within this directory and all subdirectories.
// Channel files must be named *_channel.js.
import * as ActionCable from '@rails/actioncable'
window.App || (window.App = {})
window.App.cable = ActionCable.createConsumer();

const channels = require.context('.', true, /_channel\.js$/)
channels.keys().forEach(channels)
