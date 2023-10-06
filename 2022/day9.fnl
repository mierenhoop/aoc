(fn count-set [set]
  (accumulate [sum 0 (pairs set)] (+ sum 1)))

(fn apply-points [[x1 y1] [x2 y2] f]
  [(f x1 x2) (f y1 y2)])

(fn normalize [a]
  (math.min (math.max a -1) 1))

(fn enough-space? [[dx dy]]
  (or (> (math.abs dx) 1)
      (> (math.abs dy) 1)))

(fn update-knot [previous-knot knot]
  (let [diff (apply-points previous-knot knot #(- $1 $2))]
    (if (enough-space? diff)
      (apply-points knot diff #(+ (normalize $1) $2))
      knot)))

(fcollect [i 1 9] (update-knot (. knots (- i 1)) (. knots i)))

(local m1 {})
(local m2 {})

(fn get-direction-iterator []
  (let [f (io.open "day9.txt")
        input (f:read :*a)]
    (string.gsub ))

(each [dir n (string.gmatch input "([LRUD]) (%d+)")]
  (. {:L [-1 0] :R [1 0] :U [0 -1] :d [0 1]} dir)
  
  )
