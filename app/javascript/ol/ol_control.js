import {Control} from 'ol/control';
import hotspring_status from './hotspring_status.js'

class VisibilityControl extends Control {
  constructor(opt_options) {
    const options = opt_options || {};

    let checkbox_wrappers = []
    let checkboxes = []
    let checkbox_names = []

    Object.keys(hotspring_status).forEach((status, index) =>{
      let color = '#3399CC'
      switch(status){
        case 'unexplored':
          break
        case 'not_exist':
          color = 'black'
          break
        case 'prohibit':
          color = 'red'
          break
        case 'open':
          color = 'green'
          break
        case 'others':
          color = 'grey'
          break
      }
      checkbox_wrappers.push(document.createElement('div'));
      checkbox_wrappers[index].className = 'form-check';

      checkboxes.push(document.createElement('input'));
      checkboxes[index].type = 'checkbox'
      checkboxes[index].className = status + ' form-check-input'
      checkboxes[index].id = status
      if(status !== 'not_exist') checkboxes[index].checked = 'checked'
      
      checkbox_names.push(document.createElement('label'));
      checkbox_names[index].className = 'form-check-label'
      checkbox_names[index].for = status
      checkbox_names[index].innerHTML = hotspring_status[status]
      checkbox_names[index].style = 'color:'+color+';'
      
      checkbox_wrappers[index].appendChild(checkbox_names[index]);
      checkbox_wrappers[index].appendChild(checkboxes[index]);
    });

    const element = document.createElement('div');
    element.className = 'ol-selectable ol-control visibility';
    element.id = 'v-control';
    element.setAttribute('data-bs-toggle', 'tooltip')
    element.setAttribute('data-bs-placement', 'left')
    element.setAttribute('title', '地図上に表示する温泉の状態を選択できます。')

    Object.keys(hotspring_status).forEach((status, index) =>{
      element.appendChild(checkbox_wrappers[index])
    });

    super({
      element: element,
      target: options.target,
    });

    Object.keys(hotspring_status).forEach((status, index) =>{
      checkboxes[index].addEventListener('click', this.handleVisibility.bind(this), false);
    });
  }

  handleVisibility(e) {
    this.getMap().getLayers().forEach(layer => {
      if(layer.get('name') + ' form-check-input'==e.path[0].className){layer.setVisible(!layer.getVisible())}
    })
  }
}

export default VisibilityControl