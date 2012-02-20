(in-package :strifebarge)

(defun make-player (&rest ship-types)
  (let ((p (make-instance 'player)))
    (setf (ships p)
	  (mapcar (lambda (s) (make-instance s :player p)) ship-types))
    p))

(defun make-game (&rest players)
  (let ((board (make-board (mapcan #'ships players))))
    (make-instance 'game :board board :players players :turn-stack players)))

(defmethod echo ((g game) (p player))
  (with-html-output-to-string (*standard-output* nil :prologue t :indent t)
    (:html (:body
	    (:div :class "game-status"
		  (:p "Current Turn: " (str (car (players g))))
		  (dolist (p (players g)) (htm (:p (str p)))))
	    (echo (board g) p)))))