-- Labelled fields, used in patterns and expressions
module HsFieldsStruct where

import Data.Generics

type HsFieldsI i e = [HsFieldI i e]

data HsFieldI i e = HsField i e deriving (Read, Eq, Show, Data, Typeable)   

fieldName (HsField n _) = n
