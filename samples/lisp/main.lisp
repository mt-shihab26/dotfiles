(defpackage :sample
  (:use :cl)
  (:export #:greet #:sum #:main))

(in-package :sample)

(defstruct person
  name
  age)

(defun greet (person)
  "Build a greeting for PERSON."
  (format nil "Hello, ~a! You are ~d." (person-name person) (person-age person)))

(defun sum (numbers)
  "Add up a list of NUMBERS."
  (reduce #'+ numbers :initial-value 0))

(defun main ()
  (let ((people (list (make-person :name "world" :age 30)
          (make-person :name "Neovim" :age 10))))
    (dolist (person people)
      (format t "~a~%" (greet person)))
    (format t "sum: ~d~%" (sum '(1 2 3)))))
