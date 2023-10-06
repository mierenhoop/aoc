(local pieces [[0b0011110]
               [0b01000 0b11100 0b01000]
               [0b00100 0b00100 0b11100]
               [0b10000 0b10000 0b10000 0b10000]
               [0b11000 0b11000]]
(local field [])
(fn print-field [] 
  (local margin 2)
  (for [r (+ (length m) margin) 1 -1]
    (for [c 6 0 -1]
      (io.write
        (match (band (rshift (or (. field r) 0) c) 1)
          1 :#
          2 :.))))

(fn overlap? [a b] (> (band a b) 0))

(fn all [[item & rest] f]
  (match item
    nil true
    (where _ (f item)) (all rest)
    _ false)

(fn wind [piece dir]
  (match dir
    :> ()
    :< ())
