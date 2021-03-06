; PASTE YOUR ASSIGNMENT CODE IN HERE
; MAKE SURE THE FUNCTIONS ARE DEFINED AS THEY SHOULD BE
; AND THE ARGS ARE CORRECTLY EXPECTED
;
; GOOD LUCK!


(defun test-case (ID Test Result)
  (if (equal Test Result)
    (format t "Test ~S OK~%" ID)
    (format t "FAIL: Test ~S expected ~S got ~S~%" ID Result Test)
    )
  )

(defun main ()
  ; selectnumbers
  (princ (test-case 1.1 (selectnumbers '()) nil))
  (princ (test-case 1.2 (selectnumbers '(5)) '(5)))
  (princ (test-case 1.3 (selectnumbers '(5 9 12)) '(5 9 12)))
  (princ (test-case 1.4 (selectnumbers '(5 a b)) '(5)))
  (princ (test-case 1.5 (selectnumbers '(a b c d e)) nil))
  (princ (test-case 1.6 (selectnumbers '(a 1 (2 3) b 4 c c 5 nil nil 6)) '(1 4 5 6)))
  (princ (test-case 1.7 (selectnumbers (selectnumbers '(5 a 6))) '(5 6)))
  (princ (test-case 1.8 (selectnumbers '(a b 1 2 (c d 3 4))) '(1 2)))
  (princ (test-case 1.9 (selectnumbers '((5))) nil))

  ;; rselect
  (princ (test-case 2.1 (rselect '()) nil))
  (princ (test-case 2.2 (rselect '(5 a b 6 c)) '(5 6)))
  (princ (test-case 2.3 (rselect '(a b 1 2 (c d 3 4))) '(1 2 (3 4))))
  (princ (test-case 2.4 (rselect '((5))) '((5))))
  (princ (test-case 2.5 (rselect '(a b (c d))) nil))
  (princ (test-case 2.6 (rselect '(a b (c (d e) f))) nil))
  (princ (test-case 2.7 (rselect '((()((()()))))) nil))
  (princ (test-case 2.8 (rselect '((()((()(2)))))) '(((((2)))))))

  ;; absolutes
  (princ (test-case 3.1 (absolutes '(1 -2 3 -4 5 -6)) '(1 2 3 4 5 6)))
  (princ (test-case 3.2 (absolutes '(1 0 -1)) '(1 0 1)))
  (princ (test-case 3.3 (absolutes nil) nil))

  ;; courses
  (princ (test-case 4.1 (courses 1 '((cmput325 (a b c)) (cmput366 (b a e)))) '(c e)))
  (princ (test-case 4.2 (courses 2 '((cmput325 (a b c)) (cmput366 (b a e)))) '(a b)))
  (princ (test-case 4.3 (courses 3 '((cmput325 (a b c)) (cmput366 (b a e)))) nil))

  ;; more test cases for courses
  (princ (test-case 4.4 (courses 2 '((cmput325 (a b c d)) (cmput391 (a)) (cmput366 (b d)))) 
                    '(a b d)))

  ;; tictactoe
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
  (princ (test-case 5.11 (tictactoe '((x ? o)(x o ?)(x o ?))) 'illegal))
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
  
  ;; my test cases for tictactoe
  (princ (test-case 5.24 (tictactoe '((o o o)(o o ?)(x x o))) 'illegal))
  (princ (test-case 5.25 (tictactoe '((? ? ?)(? ? ?))) 'illegal))
  (princ (test-case 5.26 (tictactoe '((? ? ?)(? ? ?)(? ? ?)(? ? ?))) 'illegal))
  (princ (test-case 5.27 (tictactoe '((? ? ? ?)(? ? ? ?)(? ? ? ?))) 'illegal))
  (princ (test-case 5.28 (tictactoe '((x o x)(o x o)(? ? ?))) 'ongoing))
  (princ (test-case 5.29 (tictactoe '((x o x)(o x o)(x ? ?))) 'x-win))
  (princ (test-case 5.30 (tictactoe '((x o x)(o x o)(? x ?))) 'ongoing))
  (princ (test-case 5.31 (tictactoe '((x o x)(o x o)(? o ?))) 'illegal))
  (princ (test-case 5.32 (tictactoe '((x o x)(o x o)(o o ?))) 'illegal))
  (princ (test-case 5.33 (tictactoe '((x o x)(o x ?)(? ? ?))) 'ongoing))
  (princ (test-case 5.34 (tictactoe '((x o ?)(x ? ?)(x ? ?))) 'illegal))
  (princ (test-case 5.35 (tictactoe '((x o ?)(x ? ?)(x ? ?))) 'illegal)) 
  (princ (test-case 5.36 (tictactoe '((x o ?)(x o ?)(x o ?))) 'illegal))
  (princ (test-case 5.37 (tictactoe '((x ? o)(x o ?)(x ? o))) 'illegal))
  (princ (test-case 5.38 (tictactoe '((x o o)(? x ?)(? ? x))) 'x-win))
  (princ (test-case 5.39 (tictactoe '((x o o)(o x ?)(? ? x))) 'illegal))
  (princ (test-case 5.40 (tictactoe '((x x x)
                                      (o o o)
                                      (? ? ?))) 'illegal))
  (princ (test-case 5.41 (tictactoe '((x x x)
                                      (o o ?)
                                      (? ? ?))) 'x-win))
  
  ;;; trivial
  (princ (test-case 5.42 (tictactoe '((? ? ?)
                                      (o ? ?)
                                      (? ? ?))) 'illegal))
  (princ (test-case 5.43 (tictactoe '((? ? ?)
                                      (x ? ?)
                                      (? ? ?))) 'ongoing))
  (princ (test-case 5.44 (tictactoe '((? ? ?)
                                      (? ? ?)
                                      (? ? ?))) 'ongoing))
  
  ;;; most cells are filled
  (princ (test-case 5.45 (tictactoe '((x o x)
                                      (o x o)
                                      (x o x))) 'illegal))
  (princ (test-case 5.46 (tictactoe '((x o x)
                                      (o x o)
                                      (x o ?))) 'illegal))
  (princ (test-case 5.47 (tictactoe '((x o x)
                                      (o x o)
                                      (x ? ?))) 'x-win))
  (princ (test-case 5.48 (tictactoe '((x o x)
                                      (o x o)
                                      (o x ?))) 'ongoing))
  (princ (test-case 5.49 (tictactoe '((x o x)
                                      (o x o)
                                      (o x o))) 'illegal))
  (princ (test-case 5.50 (tictactoe '((x o x)
                                      (o x o)
                                      (o x x))) 'x-win))
  (princ (test-case 5.51 (tictactoe '((x o x)
                                      (o x x)
                                      (o o x))) 'x-win))
)
