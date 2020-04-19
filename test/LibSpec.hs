module LibSpec where

import Test.Hspec
import Lib

import Text.ParserCombinators.Parsec
import Text.ParserCombinators.Parsec.Expr

number :: GenParser Char st Int
number = do
  token <- many1 digit
  return (read token :: Int)

boolean :: GenParser Char st Bool
boolean = do
  token <- string "true" <|> string "false"
  return $ case token of
    "true"  -> True
    "false" -> False

leftParen :: GenParser Char st String
leftParen = string "("

rightParen :: GenParser Char st String
rightParen = string ")"

spec :: Spec
spec = do

  describe "int" $ do
    it "returns an integer" $ do
      (parse number "Error" "42") `shouldBe` (Right 42)

  describe "boolean" $ do
    it "returns true" $ do
      (parse boolean "Error" "true") `shouldBe` (Right True)
    it "returns false" $ do
      (parse boolean "Error" "false") `shouldBe` (Right False)

  describe "leftParen" $ do
    it "returns (" $ do
      (parse leftParen "Error" "(") `shouldBe` (Right "(")

  describe "rightParen" $ do
    it "returns )" $ do
      (parse rightParen "Error" ")") `shouldBe` (Right ")")
