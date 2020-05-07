# Twinkle twinkle fatta con le patatine fritte

use_bpm 60

live_loop :bass_drum do
  #stop
  sample :bd_haus
  sleep 1
  sample :drum_snare_soft
  sleep 0.5
  sample :drum_snare_soft
  sleep 0.5
end

live_loop :twinkle do
  use_synth :blade
  use_synth_defaults attack: 0.05, sustain: 0.15, release: 0.125
  
  phases = [
    :D4, :A4, :B4, :A4,
    :G4, :Fs4, :E4, :D4
  ]
  
  phases.each do |n|
    3.times do
      play n
      play n-24
      sleep 0.25
    end
    1.times do
      play n-12
      play n+5
      sleep 0.25
    end
  end
  
end
