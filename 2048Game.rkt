;; LICENSE: See License file LICENSE (MIT license)
;;
;; Repository: https://github.com/weaver20/2048Racket

;; Copyright 2019: Noam Chen
;;                 noamchn75@gmail.com
;;
;; This is a functional implementation in Racket 
;; of the game 2048.
;;
;;
;; HOW TO PLAY:
;;   * Run the function (2048Game) in order to run the game.
;;   * Insert D in order to slide the tiles down, U in order to slide it up, L in order to slide it left and D in order to slide it down.
;;   * When two tiles with the same number touch, they merge into one!
;;

(define (2048Game) ;Starts the game's procedure
   (printf "Welcome to 2048!")
   (newline)
   (playGame (put2or4InEmptyCell (buildBoard 4))))
    
         

(define (buildBoard n);Build the initial board which is represented by two-dimensional list  
   (cond ((= n 0) '())
         (else (cons '(0 0 0 0) (buildBoard (sub1 n))))))

(define (printBoard board) ;Prints the board
  (cond ((empty? board) (void) ) 
         (else (writeln(first board))
         (printBoard (rest board)))))


(define (playGame board) ;Runs the main procedure, each time a player makes a move it checks if it wins or loses the game
  (cond ((loseGame? board) 'Lose)
         ((winGame? board) 'Win )
         (else (playGame (handleMove (put2or4InEmptyCell board))))))



(define (win? list);Sub function of "winGame?", Searches for 2048 value occurence in a row
  (cond ((empty? list) #f)
        ((= (first list) 2048 ) #t)
        (else (win? (rest list)))))

(define (winGame? board);Returns true if there is an occurence of 2048 in the board, otherwise returns false
  (cond ((empty? board) #f)
        ((win? (first board)) #t)
        (else (winGame? (rest board)))))
                        

  (define (loseGame? board );Returns true in case the player loses, false otherwise
    (cond ((empty? (getIndexesOfCellsWithValueZero board)) (checkOptions board))
          (else #f)))

(define (checkOptions board);Returns true in case there are no more available moves to make on the board, otherwise returns false
  (and (equal? (first board) (sum-list (first board)))
        (equal? (second board) (sum-list (second board)))
        (equal? (third board) (sum-list (third board)))
        (equal? (fourth board) (sum-list (fourth board)))
        (equal? (firstcol board) (sum-list (firstcol board)))
        (equal? (secondcol board) (sum-list (secondcol board)))
        (equal? (thirdcol board) (sum-list (thirdcol board)))
        (equal? (fourthcol board) (sum-list (fourthcol board)))))

  


(define (get board i j) ;Returns a value on a tile with the indexes of i and j (i - Row index, j - Column index)
 (list-ref (list-ref board i) j)
)

(define (replace list i value);Returns a new list with a new value (value parameter) in the index i (assuming list's length is greater than i)
  (cond
    ((zero? i) (cons value (rest list)))
    (else (cons (first list) (replace (rest list) (sub1 i) value)))
    )
)


(define (set board i j value);Substitute a new value on a tile in a board with the indexes of i and j (i - Row index, j - Column index)
 (replace board i (replace (list-ref board i) j value))
)

(define (rand2or4) ;Randoms the values 2 or 4: 2 in a 0.9 propability , 4 in a 0.1 propability
  (cond
    ((<= (random 10) 8)   2)
    (else 4)
    )
 )

(define (getZeroIndexesForRowI board i j);Returns a list of ordered pairs that contain the coordinates of 0's in the i-row tiles
  (cond
    ((equal? j 4) '())
    ( (zero? (get board i j)) (cons (cons i (cons j '())) (getZeroIndexesForRowI board i (add1 j))))
    (else (getZeroIndexesForRowI board i (add1 j)))
  )
)


(define (getIndexesOfCellsWithValueZeroStartAtRowI board i);Overloading function. Returns a list of ordered pairs that contain the coordinates of 0's in the boards's tiles
  (cond
    ((equal? i 4) '())
    ((append (getZeroIndexesForRowI board i 0) (getIndexesOfCellsWithValueZeroStartAtRowI board (add1 i)) ))
  )
)


(define (getIndexesOfCellsWithValueZero board);Returns a list of ordered pairs that contain the coordinates of 0's in the boards's tiles
  (getIndexesOfCellsWithValueZeroStartAtRowI board 0)
)


(define (handleMove board);Reads a direction input from the player
   (printf "Enter the direction you would like to move")
   (newline)
  (printBoard board)
  (direction (read) board))


(define (direction a board);Moves the tiles on the board according to the player's input
   (cond ((equal? a 'U) (sum_up board))
   ((equal? a 'D) (sum_down board))
   ((equal? a 'R) (sum_right board))
   ((equal? a 'L) (sum_left board))
   (else (writeln "Invalid input") (direction (read) board) )))



(define (transpose board);Transposes the board, Returns a 2D-list which every sub-list of that list will represent a column and not a row
 (cons (firstcol board) (cons (secondcol board) (cons (thirdcol board) (cons (fourthcol board) '())))))


 (define (firstcol board);Returns the board's first column
     (cond ((empty? board) '()) 
     (else (cons (first (first board)) (firstcol (rest board))))))

   (define (secondcol board);Returns the board's second column
     (cond ((empty? board) '()) 
     (else (cons (second (first board)) (secondcol (rest board))))))

   (define (thirdcol board);Returns the board's third column
     (cond ((empty? board) '()) 
     (else (cons (third (first board)) (thirdcol (rest board))))))

   (define (fourthcol board);Returns the board's fourth coulmn
     (cond ((empty? board) '()) 
     (else (cons (first (reverse (first board))) (fourthcol (rest board))))))



(define (sum-list list);Sums and moves a list (which can be a row or a column in the board)
  (move-list (sumCol list 0 1)))

(define (sumCol boardCol num1 num2);Sums a 1D list
  (cond ((or (>= num2 (length boardCol)) (>= num1 (length boardCol))) boardCol)
        (( = (list-ref boardCol num1) (list-ref boardCol num2)) (sumCol (merge boardCol num1 num2) (+ 2 num1) (+ 2 num2)))
        ((= (list-ref boardCol num1) 0) (sumCol boardCol (add1 num1) (add1 num2)))
         ((= (list-ref boardCol num2) 0) (sumCol boardCol num1 (add1 num2)))
         ((and (not (= (list-ref boardCol num1)  (list-ref boardCol num2)))  (> (- num2 num1) 1)) (sumCol boardCol (+ 2 num1) (add1 num2)))
         ((and (not (= (list-ref boardCol num1)  (list-ref boardCol num2)))  (= (- num2 num1) 1)) (sumCol boardCol (add1 num1) (add1 num2)))))


(define (merge list num1 num2);Returns a new list after merging 2 identical elements in it
  (replace  (replace list num2 0) num1 (+ (list-ref list num1) (list-ref list num2))))


(define (move-list list);Moving the values in the list to thet left after summing it, in the worst case it would require 4 times of moving the values since the list contain 4 elements
  (move (move (move (move list 3) 3) 3) 3))


(define (move list num1);Searches for an elemnt to be moved to its right place so that there will be no gap between the elemnts after a player makes his move
  (cond ((= num1 0) list)
        ((not (= (list-ref list num1) 0)) (cond ((= (list-ref list (sub1 num1)) 0) (move (move2 list num1) (sub1 num1)))
                                                (else (move list (sub1 num1)))))
        (else (move list (sub1 num1)))))


(define (move2 list num1);Narrows the gap between the elemnt that is closest to the list's left side
  (cond ((= num1 0) list)
        ((not (= (list-ref list (sub1 num1)) 0)) list)
        (else (move2 (change list num1 (sub1 num1)) (sub1 num1)))))

(define (change list num1 num2); repalcing elements between 2 indexes in the list
  (replace (replace list num1 (list-ref list num2)) num2 (list-ref list num1)))

;--- Summing down ---

(define (sum_down board)
  (reverse (sum_up (reverse board))))

;--- Summing left ---

(define (sum_left board)
  (reverse (sum-a-row board '() 4)))

;--- Summing right ---

(define (sum_right board)
  (reverse (transpose (reverse (transpose (sum-a-row (transpose (reverse (transpose board))) '() 4))))))

;--- Summing up ---

(define (sum_up board)
  (transpose (sum-up board)))

(define (sum-up board)
  (reverse (sum-a-row (transpose board) '() 4)))

(define (sum-a-row board list num);Overloading function
  (cond ((zero? num) list)
        (else (sum-a-row (rest board) (cons (sum-list (first board)) list) (sub1 num)))))


(define (randomRowAndCol board);Returns an ordered pair with random indexes of a 0 element in the board
  (getRandFromList (getIndexesOfCellsWithValueZero board)))


(define (put2or4InEmptyCell board);Substitute a value of 2 or 4 in an empty tile in the board
 (set board (first (randomRowAndCol board)) (second (randomRowAndCol board)) (rand2or4)))

(define (getRandFromList L);Returns a random elemnt from the list L
  (list-ref L (random (length L))))






                                                                                                                                                                                                                                                       
        






























