module LocalSettings where

hare_version="HaRe 27/03/2008"
release_root= showNoQuotes "/home/andy/MyEmacs/Site-Lisp/Packages/HaRe/editors/.."
refactorer = showNoQuotes "/home/andy/MyEmacs/Site-Lisp/Packages/HaRe/refactorer/pfe"
refactorer_client = showNoQuotes "/home/andy/MyEmacs/Site-Lisp/Packages/HaRe/refactorer/pfe_client"
preludePath = "/home/andy/MyEmacs/Site-Lisp/Packages/HaRe/tools/base/tests/HaskellLibraries"

reportFilePath = "./refactorer/duplicate/report.txt"
answerFilePath = "./refactorer/duplicate/answers.txt"
transFilePath  = "./refactorer/duplicate/transforms.txt"
mergeFilePath  = "/home/andy/MyEmacs/Site-Lisp/Packages/HaRe/editors/../refactorer/merging/mergecache.txt"
ghcPath = "/usr/lib/ghc-6.8.2"


(refactor_prg:refactor_args) = words refactorer -- for emacs
showNoQuotes x = init $ tail $ show x
