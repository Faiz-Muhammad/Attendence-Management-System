class HomesController < ApplicationController

  def index
    att = Attendence.select(:date, :hours, :check_in, :check_out).where(user_id: current_user.id).order(:created_at).limit(30)
    attendences_of_a_user = []

    att.each do |obj|
      attendences_of_a_user.push({
        label: obj.date.strftime("%d %b %Y"),
        value: obj.hours
        })
    end

    @chart = Fusioncharts::Chart.new({
      height: "400",
      width: "1000",
      type: "spline",
      renderAt: "chartContainer",
      # Chart data is passed to the `dataSource`
      # key - value pairs.
      dataSource: {
          "chart": {
              # caption: "Your Attendance",
              # subCaption: "Checked-In Hours",
              yAxisName: "Hours",
              anchorradius: "5",
              plottooltext: "Total working hours at <b>$label</b> are <b>$dataValue</b>",
              showhovereffect: "1",
              theme: "fint",
              anchorbgcolor: "#72D7B2",
              palettecolors: "#72D7B2",
              exportEnabled: "1"
        },

        data: attendences_of_a_user
      }
    })

  end
end
