require 'securerandom'

class NeighborhoodsController < ApplicationController


  def upload
    @collapse = Collapse.new
  end

  # should move this to model
  def search
    

    # test the sql
    @requested_contigs = Interaction.filter_contigs(params[:down], 
                                                    params[:up])

    # test
    # @interactions = Interaction.select(:downstream, :upstream)
    #   .distinct.to_a

    # sort might make it slow with a lot of things
    @down_names = Interaction.dropdown_downstream

    @up_names = Interaction.dropdown_upstream

    # if @requested_contigs.to_a.count > 0
    #   @contigs_file = 'public/contigs_' + Time.now.strftime("%Y%m%d%H%M%S%L") + 
    #     SecureRandom.base64(40).gsub(/[=+$\/]/,'') + '.fasta'

    #   # should find a better way to ensure that two users don't blow up
    #   # each others file?
    #   File.open(@contigs_file, 'w') do |f|
    #     @requested_contigs.each do |info|
    #       f.puts(">downstream=#{info.downstream}_upstream=#{info.upstream}" +
    #              "_contig=#{info.contig}\n#{info.sequence}")
    #     end
    #   end
    # end
  end
end

