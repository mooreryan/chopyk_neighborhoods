require 'securerandom'

# returns [start, length]
def get_info name
  coords = name.match(/_\d+_\d+_\d+$/).to_s.split('_')[1..2]
    .map { |s| s.to_i }.sort.reverse

  [ coords.last, coords.reduce(:-) + 1 ]
end


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

  def superfamilies
    @interaction_counts = 
      SuperfamilyInteraction
      .collapsed_interactions(collapse: params[:collapse],
                              min: params[:min])

    @families = SuperfamilyInteraction.unique_families
  end

  def sfcontigs

    # @contigs = 
    #   params.select { |k,v| v == '1' }.map do |k,v|
    #   s = ''
    #   down, up = k.split(',')
    #   SuperfamilyInteraction.filter_contigs(down, up).each do |st|
    #     s << st + "\n"
    #   end
    #   s
    # end

    # [[contig, another, ...], [contig, another, ...]]
    @contigs = 
      contigs = []
      params.select { |k,v| v == '1' }.map do |k,v|
      down, up = k.split(',')
      contigs <<  SuperfamilyInteraction.filter_contigs(down, up)
      contigs.flatten!
    end

    @orfs = @contigs.map do |contig|
      { contig: contig.header, length: contig.contig.length, 
        orfs: OrfInfo.where(contig: contig.header).to_a
          .map { |orf| [orf.superfam, get_info(orf.name), orf.name].flatten }
          .sort }
    end

    @orfs.flatten!

    gon.contigs = @orfs.map { |o| o[:contig] }
    gon.lengths = @orfs.map { |o| o[:length] }
    # [[superfam, start, length], ...]
    gon.orfs = @orfs.map { |o| o[:orfs] }
    
  end

  def download_sfcontigs
    @apples = 
      params.select { |k,v| v == '1' }.map do |k,v|
      s = ''
      get_me = k.split(',')
      get_me.each_with_index do |item, idx|
        if idx == 0
          seq = Sequence.where(header: item).first
          s << ">#{seq.header}\n#{seq.contig}\n"
        else
          orf = OrfInfo.where(name: item)
          s << orf.map { |o| ">#{o.name}__#{o.superfam}" }.zip(orf.map { |o| o.orf_sequence }).flatten.join("\n") + "\n"
        end
      end
      s
    end
    send_data @apples.join, filename: 'stuff.txt'
  end
end
