(local input (: (io.open "day3.txt") :read :*a))

(fn to-set [l]
  (collect [_ v (ipairs l)] (values v true)))

(fn prioritized-items [s]
  (to-set (fcollect [i 1 (length s)]
    (match (- (string.byte s i) (string.byte :a) -1)
      (where n (< n 1)) (+ n 58)
      n n))))

(fn filter-sum [s f]
  (accumulate [acc 0 k (pairs s)]
    (if (f k)
      (+ acc k)
      acc)))

(print (accumulate [acc 0 l (string.gmatch input "%g+")]
  (let [comp1 (prioritized-items (string.sub l    1 (/ (length l) 2)))
        comp2 (prioritized-items (string.sub l (+ 1 (/ (length l) 2))))]
    (+ acc (filter-sum comp1 #(. comp2 $))))))

(print (accumulate [acc 0 a b c (string.gmatch input "(%g+)\n(%g+)\n(%g+)")]
  (let [comp1 (prioritized-items a)
        comp2 (prioritized-items b)
        comp3 (prioritized-items c)]
    (+ acc (filter-sum comp1 #(and (. comp2 $) (. comp3 $)))))))

