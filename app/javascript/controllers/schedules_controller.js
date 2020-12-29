import { Controller } from 'stimulus'
import { Calendar } from '@fullcalendar/core'
import interactionPlugin from '@fullcalendar/interaction'
import resourceTimelinePlugin from '@fullcalendar/resource-timeline'
import resourceTimeGridPlugin from '@fullcalendar/resource-timegrid'
import resourceDayGridPlugin from '@fullcalendar/resource-daygrid'
import bootstrapPlugin from '@fullcalendar/bootstrap'
import allLocales from '@fullcalendar/core/locales-all'
import '@fortawesome/fontawesome-free/css/all.css'

export default class extends Controller {
  static targets = ['calendar']

  connect() {
    this.loadCalendar()
  }

  loadCalendar() {
    const calendar =  new Calendar(this.calendarTarget, {
      schedulerLicenseKey: 'CC-Attribution-NonCommercial-NoDerivatives',
      locales: allLocales,
      locale: 'pt-br',
      plugins: [ bootstrapPlugin, interactionPlugin, resourceTimelinePlugin, resourceTimeGridPlugin, resourceDayGridPlugin ],
      timeZone: 'Brasilia',
      headerToolbar: {
        left: 'promptResource today prev,next',
        center: 'title',
        right: 'resourceDayGridDay,resourceTimelineWeek'
      },
      themeSystem: 'bootstrap',
      initialView: 'resourceTimeGridDay',
      height: 600,
      selectable: true,
      resources: '/rooms.json',
      slotDuration: '1:00',
      businessHours: [
        {
          daysOfWeek: [ 1, 2, 3, 4, 5 ],
          startTime: '08:00',
          endTime: '19:00'
        }
      ],
      events: '/schedules.json',
      customButtons: {
        promptResource: {
          text: '+ room',
          click: function() {
            var title = prompt('Room name');
            if (title) {
              fetch('/rooms', {
                method: 'POST',
                body: JSON.stringify({
                  room: {
                    name: title
                  }
                }),
                headers: {"Content-type": "application/json; charset=UTF-8"}
              })
              calendar.addResource({
                title: title
              })
              calendar.refetchResources()
            }
          }
        }
      },
      select: (info) => {
        if (info.resource.getEvents().filter( e => e.startStr == info.startStr ).length > 0) {
          this.alertBox('Horário reservado', 'danger')
        } else {
          if (new Date(info.startStr).getHours() < 8 || new Date(info.startStr).getHours() > 18) {
            this.alertBox('Só é possível reservar no horário comercial: (08:00 as 18:00)', 'danger')
          } else {
            fetch(`/rooms/${info.resource.id}/schedule`, {
              method: 'POST',
              body: JSON.stringify({
                room_id: info.resource.id,
                starts_at: info.startStr,
                ends_at: info.endStr
              }),
              headers: {"Content-type": "application/json; charset=UTF-8"}
            })
            .then(response => response.json())
            .then(res => {
              if (res.errors) {
                this.alertBox(res.errors, 'danger')
              } else {
                this.alertBox('Adicionado com sucesso', 'success')
                calendar.refetchEvents()
              }
            })
          }
        }
      },
    })

    return calendar.render()
  }

  alertBox(message, type) {
    const content = document.querySelector('main')
    const box = `
      <div class="alert alert-${type} alert-dismissible fade show" role="alert">
        <strong>${message}</strong>
        <button type="button" class="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
    `
    content.insertAdjacentHTML('beforebegin', box)
  }
}
