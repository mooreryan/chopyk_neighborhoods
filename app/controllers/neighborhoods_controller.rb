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

    unless params[:down].nil? || params[:up].nil?
      @requested_contigs = 
        Interaction.filter_contigs(params[:down], params[:up])
    end

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
    @interaction_counts = 
      Interaction.collapsed_interactions(collapse: params[:collapse],
                                         min: params[:min])

    @families = Collapse.unique_families
  end

  def contigs
    @contigs = 
      params.select { |k,v| v == '1' }.map do |k,v|
      s = ''
      down, up = k.split(',')
      Interaction.filter_contigs(down, up).each do |st|
        s << st + "\n"
      end
      s
    end

    send_data @contigs.join, filename: 'reads.fasta'
  end
end
