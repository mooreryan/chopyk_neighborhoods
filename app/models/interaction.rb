class Interaction < ActiveRecord::Base
  validates :downstream, presence: true
  validates :upstream, presence: true
  validates :distance, presence: true
  validates :contig, presence: true

  def Interaction.filter_contigs down, up
    select_string = 'interactions.downstream, interactions.upstream, ' +
      'interactions.distance, interactions.contig, sequences.sequence'
    join_string = 'inner join sequences on interactions.contig = ' + 
      'sequences.header'

    interactions = Interaction.select(select_string)
      .joins(join_string)
      .where(interactions: { downstream: down,
                             upstream: up })

    interactions.map do |r| 
      ">downstream=#{r.downstream}_upstream=#{r.upstream}" +
      "_contig=#{r.contig}\n#{r.sequence}" 
    end
  end

  # TODO consider macro for this
  def Interaction.dropdown_downstream
    Interaction.select(:downstream).distinct.map { |r|
      [r.downstream, r.downstream] }.sort
  end

  def Interaction.dropdown_upstream
    Interaction.select(:upstream).distinct.map { |r|
      [r.upstream, r.upstream] }.sort
  end

  # def self.to_fasta
  #   puts ">#{self.header}\n#{self.sequence}"
  # end
end
