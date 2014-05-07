class CollapsesController < ApplicationController
  def new
  end

  def index
  end
  
  def create
    # TODO this is an ugly hack, should pass the collapse_params
    # function below but not working right now
    @collapse = Collapse.new({ old_name: params['collapse']['old_name'], 
                               new_name: params['collapse']['new_name'] })
    puts "pipi #{params.inspect}"
    puts "hihi #{@collapse.inspect}"
    if @collapse.save
      puts 'yaya'
      redirect_to root_path
    else
      # if it doesn't save redirect here app/views/collapses/new.html.erb
      render 'new'
    end
  end

  private
  
  # def collapse_params
  #   puts "before HAPPY: #{params}"
  #   params.require(:new_name).permit(:old_name)
  # end
end
