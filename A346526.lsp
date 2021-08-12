(setf candidates (list 25))
(setf result nil)

(defun factor (num small-num)
  (equalp 0 (mod num small-num)))

(defun same-end-digit (num1 num2 num3)
  (and (equalp (mod num1 10) (mod num2 10))
       (equalp (mod num2 10) (mod num3 10))))

(defun good-factor-p (num)
  (loop for i from 5 to (sqrt num)
    do (
      if (factor num i) ( 
        if (same-end-digit num i (/ num i) ) 
            (return T) ))))


(loop for i from 26 to 9000
    do (
        if (or (equalp 0 (mod i 10))
               (equalp 1 (mod i 10)) 
               (equalp 5 (mod i 10)) 
               (equalp 6 (mod i 10))) 
          (push i candidates)))

(dolist (element candidates)
  (if (good-factor-p element) 
    (push element result)))

(format t (write-to-string result))

