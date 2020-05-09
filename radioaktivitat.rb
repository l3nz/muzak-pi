#
# Radioaktivität
#

use_bpm 50

# transp( ring, :a2 - :a3) -> Transpose so that :a3 becomes :a2
def transp( myriff, note_offset)
  myriff.map { |n| [n[0] + note_offset, n[1]] }.ring
end

# turns a degree into a note on a scale
def degree_to_note( deg, offset, tonic, scale)
  puts( deg )
  if ((deg == nil) || (deg == :r)) then
    :r
  else
    degree(deg + offset, tonic, scale)
  end
end

# turns a riff into a set of degrees with the same structure
def in_degrees( driff, offset, tonic, scale )
  driff.map { |n| [degree_to_note(n[0], offset, tonic, scale), n[1]] }.ring
end

# returns the name of a note, or "-" for the rest
def noteName( n )
  if (n == :r) then
    "-"
  else
    note_info(n).midi_string
  end
end

# turns a riff into a set of notes (for debug)
def as_notes( riff )
  riff.map { |n| noteName(n[0]) }
end

# Converts a note to a degree of a scale
def as_degree_of( a_note, tonic, scale )
  if a_note == :r then
    return :r
  end
  
  v = scale( tonic, scale, num_octaves: 4).to_a.index note(a_note)
  if ( v == nil) then
    puts( "Note #{a_note} does not belong to #{tonic} #{scale}" )
    :r
  else
    v + 1
  end
end

# converts a riff to a set of grades on a scale
def as_degrees_of( riff, tonic, scale )
  riff.map { |n| [as_degree_of(n[0], tonic, scale), n[1]] }
end


# Lengths expressed in 16th
riffA = [
  [:r, 14],[:e3, 2],
  [:a3, 4],[:a3, 2], [:e3, 2],[:a3, 2], [:e3, 4],[:a3, 2],
  [:c4, 2],[:b3, 4], [:a3, 2],
[:r, 10]]

degA = as_degrees_of( riffA, :c2, :major)
riffF = in_degrees(degA, -2, :c2, :major )
riffG = in_degrees(degA, 2, :c2, :major )



puts("RiffA is #{as_notes(riffA)}")
puts("RiffF is #{as_notes(riffF)}")
puts("RiffG is #{as_notes(riffG)}")

riff = riffA

with_fx :reverb, room: 1 do
  live_loop :riff do
    #stop
    use_synth :piano
    
    notes = riff.tick
    n = notes[0]
    d = notes[1]  / 16.0
    
    play n
    sleep d
    
  end
end


#puts(scale( :C4, :major).to_a.index note(:Ds4))

live_loop :chords do
  play chord( :a3, :minor )
  sleep 2
end
