import {Control} from 'ol/control';
import hotspring_status from './hotspring_status.js'

class VisibilityControl extends Control {
  constructor(opt_options) {
    const options = opt_options || {};

    let checkboxes = []
    let checkbox_names = []

    hotspring_status.forEach((status, index) =>{
      checkboxes.push(document.createElement('input'));
      checkboxes[index].type = 'checkbox'
      checkboxes[index].class= status

      checkbox_names.push(document.createElement('div'));
      checkbox_names[index].innerHTML = status
    });

    const element = document.createElement('div');
    element.className = 'ol-selectable ol-control';


    hotspring_status.forEach((status, index) =>{
      element.appendChild(checkbox_names[index]);
      element.appendChild(checkboxes[index]);
    });

    super({
      element: element,
      target: options.target,
    });

    hotspring_status.forEach((status, index) =>{
      checkboxes[index].addEventListener('click', this.handleVisibility.bind(this), false);
    });
  }

  handleVisibility(e) {
    this.getMap().getLayers().forEach(layer => {
      if(layer.get('name')==e.path[0].class){layer.setVisible(!layer.getVisible())}
    })
  }
}

export default VisibilityControl