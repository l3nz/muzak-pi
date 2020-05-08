#
# Radioaktivität
#

use_bpm 50

# transp( ring, :a2 - :a3) -> Transpose so that :a3 becomes :a2
def transp( myriff, note_offset)
  myriff.map { |n| [n[0] + note_offset, n[1]] }.ring
end

def in_degrees( riff, tonic, scale )
  riff.map { |n| [degree(n[0], tonic, scale), n[1]] }.ring
  
end

def as_notes( riff )
  riff.map { |n| note_info(n[0]).midi_string }
  
end

# https://gist.github.com/Enkerli/0687533338c5e40516fc

puts( as_notes(in_degrees( [[1, 1], [2, 1]], :c1, :major)))

puts( scale( :c3, :major))



# Lengths expressed in 16th
riffA = (ring
         [:r, 14],[:e3, 2],
         [:a3, 4],[:a3, 2], [:e3, 2],[:a3, 2], [:e3, 4],[:a3, 2],
         [:c4, 2],[:b3, 4], [:a3, 2],
         [:r, 10])

riffF = transp(riffA, :c3 - :e3 )
riffG = transp(riffA, :g2 - :e3 )


#puts("Riff is #{riff1}")
#puts("Tra is #{riff2}")

riff = riffG

with_fx :reverb, room: 1 do
  live_loop :lands, auto_cue: false do
    stop
    use_synth :piano
    
    notes = riff.tick
    n = notes[0]
    d = notes[1]  / 16.0
    
    play n
    sleep d
    
  end
end


