import {Control} from 'ol/control';
import hotspring_status from './hotspring_status.js'

class VisibilityControl extends Control {
  constructor(opt_options) {
    const options = opt_options || {};

    let checkbox_wrappers = []
    let checkboxes = []
    let checkbox_names = []

    hotspring_status.forEach((status, index) =>{
      checkbox_wrappers.push(document.createElement('div'));
      checkbox_wrappers[index].className = 'checkbox_wrapper';

      checkboxes.push(document.createElement('input'));
      checkboxes[index].type = 'checkbox'
      checkboxes[index].className= status
      checkboxes[index].checked = 'checked'

      checkbox_names.push(document.createElement('div'));
      checkbox_names[index].innerHTML = status

      
      checkbox_wrappers[index].appendChild(checkbox_names[index]);
      checkbox_wrappers[index].appendChild(checkboxes[index]);
    });

    const element = document.createElement('div');
    element.className = 'ol-selectable ol-control visibility';


    hotspring_status.forEach((status, index) =>{
      element.appendChild(checkbox_wrappers[index])
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
      if(layer.get('name')==e.path[0].className){layer.setVisible(!layer.getVisible())}
    })
  }
}

export default VisibilityControl