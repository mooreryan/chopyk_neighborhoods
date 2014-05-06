include ApplicationHelper

def file_name name
  this_path = File.expand_path(File.dirname(__FILE__))
  fname = File.join(this_path, '..', 'test_files', name)
end

# create the interaction entries
def create_interaction_entries
  File.open(file_name('interactions.txt'), 'r').each_line do |line|
    down, up, dist, cont = line.chomp.split("\t")
    
    Interaction.create(downstream: down, upstream: up, 
                       distance: dist, contig: cont)
  end
end

# create the sequence entries
def create_sequence_entries
  File.open(file_name('contigs.fasta'), 'r').each(sep="\n>") do |line|
    header, sequence = line.chomp.split( "\n", 2 )
      .map { |x| x.gsub( /\n|>/, '' ) }
    
    Sequence.create(header: header, sequence: sequence)
  end
end
