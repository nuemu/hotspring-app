import {Control} from 'ol/control';

class RotateNorthControl extends Control {
  constructor(opt_options) {
    const options = opt_options || {};

    const unexplored = document.createElement('input');
    unexplored.type = 'checkbox'

    const unexplored_text = document.createElement('div');
    unexplored_text.innerHTML = 'Unexplored';

    const element = document.createElement('div');
    element.className = 'rotate-north ol-unselectable ol-control';
    element.appendChild(unexplored_text);
    element.appendChild(unexplored);

    super({
      element: element,
      target: options.target,
    });

    unexplored.addEventListener('click', this.handleRotateNorth.bind(this), false);
  }

  handleRotateNorth() {
    this.getMap().getLayers().forEach(layer => {if(layer.get('name')=='cluster'){layer.setVisible(!layer.getVisible())}})
    //this.getMap().getView().setRotation(90);
  }
}

export default RotateNorthControl