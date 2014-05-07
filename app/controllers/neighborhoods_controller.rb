require 'securerandom'

class NeighborhoodsController < ApplicationController
  # here is a hack to keep track of the last search which is needed
  # for download
  @@last_down = ''
  @@last_up = ''
  
  def upload
    @collapse = Collapse.new
  end

  # should move this to model
  def search

    @down_names = Interaction.dropdown_downstream

    @up_names = Interaction.dropdown_upstream

    @requested_contigs = 
      Interaction.filter_contigs(params[:down], params[:up])

    respond_to do |format|
      format.html
      
      # okay so it's doing this query tice if it calls a fasta and
      # using class variables...ugly! but at least it works
      format.fasta do
        s = ''
        Interaction.filter_contigs(@@last_down, @@last_up).each do |st| 
          s << st + "\n"
        end
        send_data s
      end
    end    

    @@last_down = params[:down]
    @@last_up   = params[:up]
  end

  def neighbors

  end
end

