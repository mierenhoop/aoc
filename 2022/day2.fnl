(let [f (io.open :day2.txt)
      input (f:read :*a)
      [p1 p2] (accumulate [[p1 p2] [0 0]
                           a b (string.gmatch input "(.) (.)")]
        (let [opp   (- (string.byte a) (string.byte :A))
              guess (- (string.byte b) (string.byte :X))
              win   (% (+ opp 1) 3)
              lose  (% (- opp 1) 3)
              equal opp
              score #(+ $ (. {win 6 lose 0 equal 3} $))]
          [(+ p1 (score guess) 1)
           (+ p2 (score (. {0 lose 1 equal 2 win} guess)) 1)]))]
  (print p1)
  (print p2))
