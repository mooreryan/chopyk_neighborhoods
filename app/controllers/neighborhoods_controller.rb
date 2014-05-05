class NeighborhoodsController < ApplicationController
  def upload
    @collapse = Collapse.new
  end

  # should move this to model
  def search
    select_string = 'interactions.downstream, interactions.upstream, ' +
      'interactions.distance, interactions.contig, sequences.sequence'
    join_string = 'inner join sequences on interactions.contig = ' + 
      'sequences.header'

    @requested_contigs = Interaction.select(select_string)
      .joins(join_string)
      .where(interactions: { downstream: params[:down], 
                             upstream: params[:up] })

    @apple = params


  end

end
