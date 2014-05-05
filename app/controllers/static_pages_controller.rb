class StaticPagesController < ApplicationController
  def home
    @collapse = Collapse.new
  end

  def help
  end

  def about
  end

  def contact
  end
end
