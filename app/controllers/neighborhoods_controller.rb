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

    # test the sql
    @requested_contigs = Interaction.select(select_string)
      .joins(join_string)
      .where(interactions: { downstream: params[:down], 
                             upstream: params[:up] })

    # test
    # @interactions = Interaction.select(:downstream, :upstream)
    #   .distinct.to_a

    # sort might make it slow with a lot of things
    @down_names = Interaction.select(:downstream).distinct.to_a.map { |r| [r.downstream, r.downstream] }.sort

    @up_names = Interaction.select(:upstream).distinct.to_a.map { |r| [r.upstream, r.upstream] }.sort

    @apple = params


  end

end
