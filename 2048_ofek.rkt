
(define (build n) ; Helper function: build row of ziros                       
  (cond ((= n 0) '())
        (else (cons 0 (build (- n 1))))))


(define (buildBoard n)       ;build the started board  
   (cond ((= n 0) '())
         (else (cons (buildBoard 4) (buildBoard (- n 1)))))) 


(define (2048Game) ;starting the game
(playGame (buildBoard)))

(define (playGame board) ;check if the player win or lose
(cond ((loseGame? board) 'Lose)
 ((winGame? board) 'Win )
(else (playGame (move (put2or4InEmptyCell board))))))

(define (winGame? board) ;check if the player is win 
(cond ((equal?(checkTwo board) #t ))))
  

  (define (checkOne list) ; Helper function: check if the number 2048 is in the board
   (cond ((empty? board) 
     ((equal?  (first board ) 2048 ) #t)
    (else (check2048 (rest board))))))


  ; (define (checkTwo)) ; check if the number 2048 is in the board



  (define (loseGame? board ) ;check if the player lost in the game
    (empty? (getIndexesOfCellsWithValueZero board)))


(define (get board i j) ; get value at position i,j from given 2D board
 (list-ref (list-ref board i) j)
)

(define (replace list i value) ; replace value at position i
  (cond
    ((zero? i) (cons value (rest list)))
    (else (cons (first list) (replace (rest list) (sub1 i) value)))
    )
)


(define (set board i j value) ; replace value in position i,j with a new value
 (replace board i (replace (list-ref board i) j value))
)

(define (rand2or4) ; random number: 2 in 0.9 propability , 4 in 0.1 propability
  (cond
    ((<= (random 10) 8)   2)
    (else 4)
    )
 )

(define (getZeroIndexesForRowI board i j) ;Helper function: i is the row to work with,  j is the coloumn to start from till the last col (coloumn 4)
  (cond
    ((equal? j 4) '())
    ( (zero? (get board i j)) (cons (cons i (cons j '())) (getZeroIndexesForRowI board i (add1 j))))
    (else (getZeroIndexesForRowI board i (add1 j)))
  )
)


(define (getIndexesOfCellsWithValueZeroStartAtRowI board i) ;Helper function: get indexes of all cells with value zero for the given board, starting with row i till row 4
  (cond
    ((equal? i 4) '())
    ((append (getZeroIndexesForRowI board i 0) (getIndexesOfCellsWithValueZeroStartAtRowI board (add1 i)) ))
  )
)


(define (getIndexesOfCellsWithValueZero board) ; get indexes of all cells with value zero , in given 2D board 
  (getIndexesOfCellsWithValueZeroStartAtRowI board 0)
)

;(define (board '((0 0 3 0) (0 0 0 0) (0 0 8 0) (0 0 0 0))))
;    '((0 0 3 0) (0 0 0 0) (0 0 8 0) (0 0 0 0))


(define (test a)
  (cond ((equal? a 'U) (print "up"))
        ((equal? a 'D) (print "dowm"))
        (else ((print "else")))))

(define (move board)
  (print "Enter the direction you would like to move")
  (handleMove (read) board))



(define (handleMove a board)     ;the player choose the direction
  (cond ((equal? a 'U) (sum_up board))
   ((equal? a 'D) (sum_down board))
   ((equal? a 'R) (sum_right board))
   ((equal? a 'L) (sum_left board))
   (else "Invalid input")))


(define (transpose board)
 (cons (firstcol board) (cons (secondcol board) (cons (thirdcol board) (cons (fourthcol board) '())))))

;     '((0 0 3 0) (0 0 0 0) (0 0 8 0) (0 0 0 0))



(define (numOfZiroInCol board col ) ;Helper function: get the kind of the col and searching zero
  (cond ((empty? board) 0 )
    (( = (col (first board)) 0) ( + 1 (numOfZiroInCol (rest board) col )))
        (else (numOfZiroInCol (rest board) col ))))

(define (locationOfMax list num ) ;return the location of the num that not zero
  (cond ((empty? list) '())
    (( > (list-ref list num) 0 ) num )
        (else (locationOfMax list (+ num 1)) )))        


 (define (checkBeforeSwitchDown board)
 (cond ( (and (= (numOfZiroInCol board first ) 3) ( = (first (fourth board)) 0 ))
         ( and (set board 3 0 (get board (locationOfMax list num ) 0))))))
       



(define (switchDown board)
  (cond (( = (first (fourth board)) 0 ) ((and (set board 3 0 (first (third board))) (set board 2 0 0))))))

(define (num1Location list num1)
  (cond ((empty? list) '())
    ( ( = (first (reverse list)) num1) ( sub1 (length list)))
        (else (num1Location (rest ( reverse list)) num1))))
                                         
  


 



   (define (firstcol board)
     (cond ((empty? board) '()) 
     (else (cons (first (first board)) (firstcol (rest board))))))

   (define (secondcol board)
     (cond ((empty? board) '()) 
     (else (cons (second (first board)) (secondcol (rest board))))))

   (define (thirdcol board)
     (cond ((empty? board) '()) 
     (else (cons (third (first board)) (thirdcol (rest board))))))

   (define (fourthcol board)
     (cond ((empty? board) '()) 
     (else (cons (first (reverse (first board))) (fourthcol (rest board))))))



(define (sum-list list);summing a list (include moving it)
  (move-list (sumCol list 0 1)))

(define (sumCol boardCol num1 num2)
  (cond ((or (>= num2 (length boardCol)) (>= num1 (length boardCol))) boardCol)
        (( = (list-ref boardCol num1) (list-ref boardCol num2)) (sumCol (merge boardCol num1 num2) (+ 2 num1) (+ 2 num2)))
        ((= (list-ref boardCol num1) 0) (sumCol boardCol (add1 num1) (add1 num2)))
         ((= (list-ref boardCol num2) 0) (sumCol boardCol num1 (add1 num2)))
         ((and (not (= (list-ref boardCol num1)  (list-ref boardCol num2)))  (> (- num2 num1) 1)) (sumCol boardCol (+ 2 num1) (add1 num2)))
         ((and (not (= (list-ref boardCol num1)  (list-ref boardCol num2)))  (= (- num2 num1) 1)) (sumCol boardCol (add1 num1) (add1 num2)))))


(define (merge list num1 num2) 
  (replace  (replace list num2 0) num1 (+ (list-ref list num1) (list-ref list num2))))


(define (move-list list);moving the list left after summing it
  (move (move (move (move list 3) 3) 3) 3))


(define (move list num1)
  (cond ((= num1 0) list)
        ((not (= (list-ref list num1) 0)) (cond ((= (list-ref list (sub1 num1)) 0) (move (move2 list num1) (sub1 num1)))
                                               (else (move list (sub1 num1)))))
        (else (move list (sub1 num1)))))


(define (move2 list num1)
  (cond ((= num1 0) list)
        ((not (= (list-ref list (sub1 num1)) 0)) list)
        (else (move2 (change list num1 (sub1 num1)) (sub1 num1)))))

(define (change list num1 num2); repalcing elements between 2 indexes in the list
  (replace (replace list num1 (list-ref list num2)) num2 (list-ref list num1)))




 ;(define (right list)   ;the direction is right
;(cond ((and (equal? (first list) 0) (< (second list) 0))  (changeThePlace list (first list) y)


;summing down

(define (sum_down board)
  (reverse (sum_up (reverse board))))

;summing left

(define (sum_left board)
  (reverse (up board '() 4)))

;summing right

(define (sum_right board)
  (reverse (transpose (reverse (transpose (up (transpose (reverse (transpose board))) '() 4))))))

;summing up

(define (sum_up board)
  (transpose (sum-up board)))

(define (sum-up board)
  (reverse (up (transpose board) '() 4)))

(define (up board list num)
  (cond ((zero? num) list)
        (else (up (rest board) (cons (sum-list (first board)) list) (sub1 num)))))




  
;(define (board '((0 0 3 0) (0 0 0 0) (0 0 8 0) (0 0 0 0))))
;     '((0 0 3 0) (0 0 0 0) (0 0 8 0) (0 0 0 0))


(define (randomRowAndCol board) ;random cell from the list of the empty cells
  (getRandFromList (getIndexesOfCellsWithValueZero board)))


; random index from the empty list


(define (getRandFromList L) 
  (list-ref L (random (length L))))


(define (put2or4InEmptyCell board) ;put 2 or 4 in empty cell
 (set board (first (randomRowAndCol board)) (second (randomRowAndCol board)) (rand2or4)))


(define (is2048 list)
 (cond (( equal?  (first list) 2048) #t)
       ((is2048 (rest list)))
       (else #f)))

(define (check2048 board)
  (cond ((equal? ((is2048 (first board))) #t) #t)
        (else (check2048 (rest board)))))


                                                                                                                                                                                                                                                       
        






























