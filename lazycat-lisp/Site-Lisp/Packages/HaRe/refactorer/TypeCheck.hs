module TypeCheck where

import System
import Control.Exception
import System.IO.Unsafe
import System.IO
import List
import PackageConfig    ( stringToPackageId )
import GHC hiding (SrcLoc)
import DynFlags (defaultDynFlags)
import HsSyn
import Outputable
import SrcLoc
--import AbstractIO

import LocalSettings

ghcInit args 
 = unsafePerformIO (
    do
       return "GHC Initialised."
   )

ghcTypeCheck args modName =
 unsafePerformIO (
  do
   let newArgs = args ++ ".hs"

   let packageConf = ghcPath
   
   -- /usr/local/packages/ghc-6.6/lib/ghc-6.6
   ses     <- GHC.newSession {-JustTypecheck-} (Just (filter (/= '\n') packageConf))
   dflags0 <- GHC.getSessionDynFlags ses
  -- (dflags1, fileish_args) <- GHC.parseDynamicFlags dflags0 args0
   (dflags1,fileish_args) <- GHC.parseDynamicFlags dflags0 []
   GHC.setSessionDynFlags ses $ dflags1 {verbosity = 1, hscTarget=HscNothing}
   targets <- mapM (\a -> GHC.guessTarget a Nothing ) [args]
   mapM_ (GHC.addTarget ses) targets
    
   -- dep <- depanal ses [(mkModuleName "Main")] True
    
   res <- GHC.load ses LoadAllTargets
   case res of
      Failed ->
        do
          error "Load Failed"
      Succeeded -> 
        do
          putErrStrLn "Load succeded."
          checked <- GHC.checkModule ses (mkModuleName modName) True
          case checked of
           Nothing   -> return ses
           Just cmod -> 
             do
               let ts = typecheckedSource cmod
               return ses
  )

ghcTypeCheck1 ses2 expr modName =
  unsafePerformIO(
   do

       res <- exprType ses2 (modName ++ "." ++ expr)
       case res of
         Nothing -> error "GHC failed to load module."
         Just ty -> do
                      -- ty' <- cleanType ty
                      return $ showSDoc $ ppr ty
  )

-- if -fglasgow-exts is on we show the foralls, otherwise we don't.
--  cleanType :: Type -> GHCi Type

  


debugLog :: String -> b -> b
debugLog msg b =
  unsafePerformIO (
    do
      putErrStrLn msg
      return b
    )

logAndDump :: (Outputable a) => String -> a -> b -> b
logAndDump msg a b =
  unsafePerformIO (
    do
      putErrStrLn msg
      putErrStrLn $ showSDoc (ppr a)
      return b
    )

tidyFileName :: String -> String
tidyFileName ('.':'/':str) = str
tidyFileName str           = str

data Tag = Tag TagName TagFile TagLine TagDesc
  deriving (Eq)

instance Ord Tag where
  compare (Tag t1 _ _ _) (Tag t2 _ _ _) = compare t1 t2

instance Show Tag where
  show (Tag t f l d) = makeTagsLine t f l d

type TagName = String
type TagFile = String
type TagLine = Int
type TagDesc = String

makeTagsLine :: String -> String -> Int -> String -> String
makeTagsLine tag file line desc = tag `sep` file `sep` (show line) `sep` ";\t\"" ++ desc ++ "\""
  where a `sep` b = a ++ '\t':b


putErrStrLn = hPutStrLn stderr
putErrStr = hPutStr stderr
 
