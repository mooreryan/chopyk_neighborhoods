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

    @requested_contigs = 
      Interaction.filter_contigs(params[:down], params[:up])

    respond_to do |format|
      format.html
      
      # okay so it's doing this query tice if it calls a fasta and
      # using class variables...ugly! but at least it works
      format.fasta do
        s = ''
        Interaction.filter_contigs(@@last_down, @@last_up).each { |st| s << st + "\n" }
        send_data s
      end
    end    

    @@last_down = params[:down]
    @@last_up   = params[:up]

  end
end

