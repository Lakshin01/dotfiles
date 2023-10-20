(deftheme ChallengerDark
  "Created 2023-09-28.")

(custom-theme-set-variables
 'ChallengerDark
 '(org-agenda-files '("/home/laksh/repos/github.com/Lakshin01/org/today.org" "/home/laksh/org/journal.org"))
 '(package-selected-packages '(ibrowse evil-mu4e ranger python))
 '(magit-todos-insert-after '(bottom))
 '(custom-safe-themes '("aec7b55f2a13307a55517fdf08438863d694550565dee23181d2ebd973ebd6b8" "512ce140ea9c1521ccaceaa0e73e2487e2d3826cc9d287275550b47c04072bc4" default)))

(custom-theme-set-faces
 'ChallengerDark
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight regular :height 143 :width normal))))
 '(fixed-pitch ((t (:family "Noto Sans Mono" :foundry "GOOG" :slant normal :weight regular :height 143 :width normal)))))

(provide-theme 'ChallengerDark)
