; Cmput 326 Winter 2020 Assignment 1
; Student ID 1523205 Student name Anshil Gandhi

;QUESTION 1 selectnumbers ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; input: a list L
; output: a list containing all numbers in L

(defun selectnumbers (L)
	(if (null L)
		nil
		(if (numberp (car L))
			(append (list (car L)) (selectnumbers (cdr L)))
			(selectnumbers (cdr L))
			)
		)
	)

;QUESTION 2 rselect ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; recursively select numbers and create a new list

(defun rselect (N)
  (if (null N)
    nil
    (if (atom (car N))
      ; if N[0] is an atom
      (if (numberp (car N))
        (append (list (car N)) (rselect (cdr N)))
        (rselect (cdr N))
        )

      ; if N[0] is a list
      (if (null (rselect (car N)))
        nil
        (list (append (rselect (car N)) (rselect (cdr N))))
        )

      )
    )
  )


;QUESTION 3 absolute ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; return a list of absolute values of each value in the input list

(defun absolutes (L)
  (if (null L)
    nil
    (if (>= (car L) 0)
      (append (list (car L)) (absolutes (cdr L)))
      (append (list (- 0 (car L))) (absolutes (cdr L)))
      )
    )
  )

;QUESTION 4 courses ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; param:  n, an integer
;         L, a list of courses in the form of 
;      ((course-name-1 (s11 s12 ...)) (course-name-2 (s21 s22 ...)))

(defun crs_cnt (std i)
  (if (null std)
    0
    (if (eq i (car std))
      (+ 1 (crs_cnt (cdr std) i))
      (crs_cnt (cdr std) i)
      )
    )
  )

(defun stds (crs)
  (if (null crs)
    nil
    (append (cadar crs) (stds (cdr crs)) )
    )
  )

(defun bruh (n L AC all)
  (if (null L)
    AC
    (if (member (car L) AC)
      (bruh n (cdr L) AC all)
      (if (eq n (crs_cnt all (car L)))
        (bruh n (cdr L) (append AC (list (car L))) all)
        (bruh n (cdr L) AC all)
        )
      )
    )
  )

(defun courses (n L)
  (bruh n (stds L) nil (stds L))
  )

;QUESTION 5 tictactoe ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
; check the number of 3 x's in a row, column or diagonal
; check the number of 3 o's in a row, column or diagonal
; determine winner or illegal position depending on the number of wins
; check if there is a blank cell
; if so, the game is ongoing else the game has ended in a draw

; return r-th row
(defun get_row (board r)
  (cond ((= r 0) (car board))
        ((= r 1) (cadr board))
        ((= r 2) (caddr board))
    )
  )

; return c-th column
(defun get_col (board c)
  (cond 
        ((= c 0) (list (caar board) (caadr board) (caaddr board)))
        ((= c 1) (list (cadar board) (cadadr board) (car (cdaddr board))))
        ((= c 2) (list (caddar board) (car (cddadr board)) (caddr (caddr board))) )
        )
  )

; return diagonal in a list
(defun get_diag (board c)
  (cond 
        ((= c 0) (list (caar board) (cadadr board) (caddr (caddr board))))
        ((= c 1) (list (caaddr board) (cadadr board) (caddar board)))
        )
  )

; check winner
(defun check_win (L)
  (if (and (eq (first L) (second L)) (eq (first L) (third L)) )
    (first L)
    "?"
    )
  )

; count number of wins by a player on rows
(defun cnt_row_wins (board row c)
  (if (> row 2)
    0
    (if (eq c (check_win (get_row board row)))
      (+ 1 (cnt_row_wins board (+ row 1) c))
      (cnt_row_wins board (+ row 1) c)
      )
    )
  )

; count number of wins by a player on cols
(defun cnt_col_wins (board col c)
  (if (> col 2)
    0
    (if (eq c (check_win (get_col board col)))
      (+ 1 (cnt_col_wins board (+ col 1) c))
      (cnt_col_wins board (+ col 1) c)
      )
    )
  )

; count number of wins by a player on cols
(defun cnt_diag_wins (board diag c)
  (if (> diag 1)
    0
    (if (eq c (check_win (get_diag board diag)))
      (+ 1 (cnt_diag_wins board (+ diag 1) c))
      (cnt_diag_wins board (+ diag 1) c)
      )
    )
  )

; count the number of triplets containing c
(defun cnt_wins (board c)
  (+ (cnt_row_wins board 0 c) (cnt_col_wins board 0 c) (cnt_diag_wins board 0 c))
  )

; check if there is an empty cell
(defun has_empty (board row)
  (if (> row 2)
    nil
    (if (member '? (get_row board row))
      T
      (has_empty board (+ 1 row))
      )
    )
  )

; convert board into 1d
(defun cvt (board)
  (append (car board) (cadr board) (caddr board) )
  )

; count the number of c's
(defun cnt_sym (board c)
  (crs_cnt (cvt board) c)
  )

; check if all symbols are valid
(defun ok_symb (L)
  (if (null L)
    T
    (if (member (car L) '(x o ?))
      (ok_symb (cdr L))
      nil
      )
    )
  )

; compute length of a list
(defun len (L)
  (if (null L)
    0
    (+ 1 (len (cdr L)))
    )
  )

; check if board dimensions are valid
(defun ok_dim (board)
  (if (atom board)
    nil
    ;
    (if (= 3 (len board))
      ; check each row
      (if (or (atom (car board))
               (atom (cadr board))
               (atom (caddr board)))
        nil 
        
        (if  (and (= 3 (len (get_row board 0))) 
                  (= 3 (len (get_row board 1))) 
                  (= 3 (len (get_row board 2)))
                )
            T
            nil
          )
        )
        nil
      )
    )
  )

; checks if the board admits a legal position
(defun legal_board (board)
  (if (and  (ok_dim board) 
            (ok_symb (cvt board)) 
            (<= (- (cnt_sym board 'x) (cnt_sym board 'o)) 1)
            (<= (cnt_row_wins board 0 'x) 1)
            (<= (cnt_row_wins board 0 'o) 1)
            (<= (cnt_col_wins board 0 'x) 1)
            (<= (cnt_col_wins board 0 'o) 1)
            (<= (cnt_diag_wins board 0 'x) 1)
            (<= (cnt_diag_wins board 0 'o) 1)
            )
    T
    nil
    )
  )

; main tictactoe driver program
(defun tictactoe (board)
  (if (legal_board board)
    (if (= 0 (cnt_wins board 'x))
      ; if x does not have a triple
      (if (= 0 (cnt_wins board 'o))
        (if (has_empty board 0)                         'ongoing  'draw         )
        (if (= (cnt_sym board 'x) (cnt_sym board 'o) ) 'o-win    'illegal      )
        )
      
      ; if x has at least 1 triple TODO : can x have 2 or more than 2 triples here?
      (if (= 0 (cnt_wins board 'o))

        ; x must occupy exactly one more than the number of o's
        (if (= (cnt_sym board 'x) (+ 1 (cnt_sym board 'o)) ) 'x-win    'illegal      )
        
        ; o cannot win if x has already won
        'illegal
        )
      )
    'illegal
    )
  )

(defun test-case (ID Test Result)
  (if (equal Test Result)
    (format t "Test ~S OK~%" ID)
    (format t "FAIL: Test ~S expected ~S got ~S~%" ID Result Test)
    )
  )

(defun main ()

  (princ (test-case 5.1 (tictactoe nil) 'illegal))
  (princ (test-case 5.2 (tictactoe '(tic tac toe)) 'illegal))
  (princ (test-case 5.3 (tictactoe 'tictactoe) 'illegal))
  (princ (test-case 5.4 (tictactoe '((? ? ?)(? ? ?)(? ? ? ?))) 'illegal))
  (princ (test-case 5.5 (tictactoe '((? ? ?)(? ? ?)(? ? ?)(? ? ?))) 'illegal))
  (princ (test-case 5.6 (tictactoe '((? ? ?)(? ? ?))) 'illegal))
  (princ (test-case 5.7 (tictactoe '((x ? ?)(x ? ?)(x ? ?))) 'illegal))
  (princ (test-case 5.8 (tictactoe '((x x x)(o o ?)(? ? ?))) 'x-win))
  (princ (test-case 5.9 (tictactoe '((x ? o)(x ? ?)(x o ?))) 'x-win))
  (princ (test-case 5.10 (tictactoe '((x o x)(o x ?)(x ? o))) 'x-win))
  (princ (test-case 5.11 (tictactoe '((x ? o)
                                      (x o ?)
                                      (x o ?))) 'illegal))
  (princ (test-case 5.12 (tictactoe '((x o ?)(x o ?)(x o ?))) 'illegal))
  (princ (test-case 5.13 (tictactoe '((x x ?)(o o o)(x ? ?))) 'o-win))
  (princ (test-case 5.14 (tictactoe '((o x ?)(? o x)(? x o))) 'o-win))
  (princ (test-case 5.15 (tictactoe '((o x ?)(? o x)(? ? o))) 'illegal))
  (princ (test-case 5.16 (tictactoe '((x x x)(o o o)(? ? ?))) 'illegal))
  (princ (test-case 5.17 (tictactoe '((x x x)(x o o)(? ? ?))) 'illegal))
  (princ (test-case 5.18 (tictactoe '((? ? ?)(? ? ?)(? ? ?))) 'ongoing))
  (princ (test-case 5.19 (tictactoe '((? ? ?)(? x ?)(? ? ?))) 'ongoing))
  (princ (test-case 5.20 (tictactoe '((? ? o)(? x ?)(? ? ?))) 'ongoing))
  (princ (test-case 5.21 (tictactoe '((? x o)(? x ?)(? ? ?))) 'ongoing))
  (princ (test-case 5.22 (tictactoe '((x x o)(o o x)(x x o))) 'draw))
  (princ (test-case 5.23 (tictactoe '((x o o)(o x x)(x x o))) 'draw))
)





