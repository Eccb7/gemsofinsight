import { Controller } from "@hotwired/stimulus"
import { Chart, registerables } from 'chart.js'

Chart.register(...registerables)

// Connects to data-controller="dashboard"
export default class extends Controller {
  static values = { revenue: Array }

  initialize() {
    const data = this.revenueValue.map((item) => item[1])
    const labels = this.revenueValue.map((item) => item[0])

    const ctx = document.getElementById('revenueChart')

    new Chart(ctx, {
      type: 'bar',
      data: {
        labels: labels,
        datasets: [{
          type: 'bar',
          label: 'Revenue Ksh (Bar)',
          data: data,
          backgroundColor: 'rgba(54, 162, 235, 0.5)',
          borderColor: 'rgba(54, 162, 235, 1)',
          borderWidth: 1,
          fill: true
        },
        {
          type: 'line',
          label: 'Revenue Ksh (Line)',
          data: data,
          borderColor: 'rgba(255, 99, 132, 1)',
          borderWidth: 3,
          fill: false
        }]
      },
      options: {
        plugins: {
          legend: {
            display: true
          }
        },
        scales: {
          x: {
            stacked: true,
            grid: {
              display: false
            }
          },
          y: {
            stacked: true,
            grid: {
              color: "#d4f3ef"
            },
            beginAtZero: true
          }
        }
      }
    })
  }
}
