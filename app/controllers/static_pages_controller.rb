class StaticPagesController < ApplicationController
  def home
    @collapse = Collapse.new
  end

  def help
  end

  def about
    gon.posns = 150, 150, 100
  end

  def contact
  end
end
