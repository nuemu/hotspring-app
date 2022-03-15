import {Control} from 'ol/control';

import { Interaction } from './interaction.js'

import { register } from './register_event.js'

import Draw from 'ol/interaction/Draw.js'
import Snap from 'ol/interaction/Snap.js';

class InteractionControl extends Control {
  constructor(opt_options) {
    const options = opt_options || {};

    const register_button = document.createElement('button');
    register_button.innerHTML = '+';

    const draw_circle_button = document.createElement('button');
    draw_circle_button.innerHTML = 'O';

    const element = document.createElement('div');
    element.className = 'rotate-north ol-unselectable ol-control';
    element.appendChild(register_button);
    element.appendChild(draw_circle_button);

    super({
      element: element,
      target: options.target,
    });

    register_button.addEventListener('click', this.handleRegisterInteraction.bind(this), false);
    draw_circle_button.addEventListener('click', this.handleDrawCircleInteraction.bind(this), false);
  }
  handleRegisterInteraction() {
    const map = this.getMap()
    map.on('singleclick', register)

    Interaction(this.getMap(), false)
  }

  handleDrawCircleInteraction(){
    const map = this.getMap()
    map.un('singleclick', register)

    Interaction(this.getMap(), true)
  }
}

export default InteractionControl
