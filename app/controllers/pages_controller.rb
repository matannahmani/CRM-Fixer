class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  before_action :checkadmin, only: [:adminpanel]

  def home
  end

  def adminpanel
  end

  def show
    respond_to do |format|
     format.html
     format.pdf do
       render pdf: "תעודת מתנדב",
       template: "pages/volcard.html.erb",
       layout: 'pdf.html',
       page_size: 'A4',
       margin:  {   top:               0,
                    bottom:            0,
                    left:              0,
                    right:             0 }
      end
    end
  end

  def volcard
  end
end
