# Zebra Zero
# My first attempt with Sonic PI
#
# comment/uncomment the 'stop's to enable

use_bpm 100

live_loop :amen_break do
  #stop
  with_fx :slicer, phase: 0.5, wave: 0, mix: rrand(0.7,1) do
    sample :loop_amen, beat_stretch: 4, rate: 1
  end
  sleep 4
end

live_loop :bass_drum do
  #stop
  sample :bd_haus
  sleep 1
end

live_loop :padding do
  bass_line = (knit :e3, 3, [:c3, :c2, :c2].choose, 1)
  s = synth :hoover, note: bass_line.tick, sustain: 3.5
  control s, cutoff_slide: 4, cutoff: 120
  sleep 4
end

live_loop :riff do
  #stop
  
  notes = (scale :e4, :minor_pentatonic, num_octaves: 3).take(8)
  
  8.times do
    synth :growl, note: notes.tick
    sleep 0.5
  end
  
  4.times do
    sleep 0.5
  end
  
  
end


