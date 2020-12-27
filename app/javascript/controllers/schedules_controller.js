import { Controller } from 'stimulus'
import { Calendar } from '@fullcalendar/core'
import dayGridPlugin from '@fullcalendar/daygrid'
import interactionPlugin from '@fullcalendar/interaction'

export default class extends Controller {
  static targets = ['calendar']

  connect() {
    this.loadCalendar()
  }

  loadCalendar() {
    return new Calendar(this.calendarTarget, {
      plugins: [ interactionPlugin, dayGridPlugin ],
      initialView: 'dayGridMonth',
      selectable: true,
      dateClick: (info) => this.addEvent(info),
    }).render()
  }

  addEvent(info) {
    alert('Clicked on: ' + info.dateStr);
    alert('Coordinates: ' + info.jsEvent.pageX + ',' + info.jsEvent.pageY);
    alert('Current view: ' + info.view.type);
    // change the day's background color just for fun
    info.dayEl.style.backgroundColor = 'red';
  }
}
