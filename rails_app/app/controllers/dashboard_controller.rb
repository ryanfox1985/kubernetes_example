class DashboardController < ApplicationController
  def index
    @visits_count = Visit.count
    @last_visits = Visit.last(10)
  end
end
