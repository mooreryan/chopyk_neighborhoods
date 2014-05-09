require 'set'

def filter_count interaction_counts, *count
  if count.nil? || count.empty?
    interaction_counts
  else
    interaction_counts.select do |i|
      i.last >= count.first.to_i
    end
  end    
end    

def filter_names interactions, name
  interactions.select do |i|
    i.downstream == name || i.upstream == name
  end
end

def map_me old_name, new_name, collapse_these
  if collapse_these.nil?
    old_name
  elsif collapse_these.include? old_name
    new_name
  else
    old_name
  end
end

# Usage
#
# with matching name
# unmap_me('happy_fam') :=> ['a', 'b']
# 
# with unmatching name
# unmap_me('apples') :=> ['apples']
#
def unmap_me name, name_map
  if name_map.has_key? name.to_sym
    name_map[name.to_sym]
  else
    [name]
  end  
end

def count_interactions interactions
  counts = {}    
  # consider having it always accept an array
  if interactions.class == Array
    interactions.each do |i|
      the_key = [i.downstream, i.upstream]
      
      if counts[the_key].nil?
        counts[the_key] = 1
      else
        counts[the_key] += 1
      end
    end
  else
    # is there a more ruby-ish way to do this?
    interactions = interactions.select(:downstream, :upstream)
    interactions.distinct.each do |i| 
      counts[[i.downstream, i.upstream]] = 0 # seed starting counts
    end
    
    interactions.each do |i|
      counts[[i.downstream, i.upstream]] += 1
    end
  end
  
  return counts.sort_by { |k,v| v }.reverse
end

def collapse_names interactions, collapse, name_map
  collapse_these = name_map[collapse.to_sym]

  interactions.each do |i|
    new_downstream = map_me(i.downstream, collapse, collapse_these)
    new_upstream = map_me(i.upstream, collapse, collapse_these)

    i.downstream = new_downstream
    i.upstream = new_upstream      
  end
  
  return interactions
end

class Interaction < ActiveRecord::Base
  validates :downstream, presence: true
  validates :upstream, presence: true
  validates :distance, presence: true
  validates :contig, presence: true


  # not tested
  def Interaction.filter_contigs down, up
    select_string = 'interactions.downstream, interactions.upstream, ' +
      'interactions.distance, interactions.contig, sequences.sequence'
    join_string = 'inner join sequences on interactions.contig = ' + 
      'sequences.header'

    name_map = Collapse.family_map
    down = unmap_me down, name_map
    up = unmap_me up, name_map
    
    contigs = []

    down.product(up).each do |d, u|
      interactions = Interaction.select(select_string)
        .joins(join_string)
        .where(interactions: { downstream: d,
                 upstream: u })

      contigs << interactions.map do |r| 
        ">downstream=#{r.downstream}_upstream=#{r.upstream}" +
          "_contig=#{r.contig}\n#{r.sequence}" 
      end
    end

    contigs.flatten
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

  # opts takes :collapse, and :min as options
  def Interaction.collapsed_interactions opts
    name_map = Collapse.family_map
    all_interactions = Interaction.all
    
    if opts[:collapse].nil? || opts[:collapse].empty?
      filter_count(count_interactions(all_interactions), 
                   opts[:min])
    else 
      interactions = collapse_names(all_interactions, opts[:collapse],
                                    name_map)
      interactions = filter_names(interactions, 
                                  opts[:collapse])
      interaction_counts = count_interactions(interactions)
      interaction_counts = filter_count(interaction_counts,
                                        opts[:min])
    end
  end
end
