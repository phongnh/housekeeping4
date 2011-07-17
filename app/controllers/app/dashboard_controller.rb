class App::DashboardController < ApplicationController
  def index
    @overviews = {
      1 => {
        :incoming => 1001346,
        :outgoing => 5623232
      },
      2 => {
        :incoming => 10012000,
        :outgoing => 110220
      },
      3 => {
        :incoming => 1001500,
        :outgoing => 536536
      },
      4 => {
        :incoming => 54364536,
        :outgoing => 3635654
      },
      5 => {
        :incoming => 10012000,
        :outgoing => 0110220
      },
      6 => {
        :incoming => 10012000,
        :outgoing => 123333
      },
      7 => {
        :incoming => 10012000,
        :outgoing => 456466654
      },
      8 => {
        :incoming => 10012000,
        :outgoing => 1223155
      },
      9 => {
        :incoming => 121212,
        :outgoing => 4566555
      },
      10 => {
        :incoming => 12222,
        :outgoing => 110220
      },
      11 => {
        :incoming => 10012000,
        :outgoing => 111111
      },
      12 => {
        :incoming => 101200,
        :outgoing => 110220
      }
    }
  end

end

