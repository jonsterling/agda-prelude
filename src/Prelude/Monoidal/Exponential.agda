{-# OPTIONS --without-K #-}

module Prelude.Monoidal.Exponential where

open import Agda.Primitive
open import Prelude.Monoidal.Exponential.Boot public
  hiding (module ⇒)
open import Prelude.Monoidal.Product

module ⇒ where
  open Prelude.Monoidal.Exponential.Boot.⇒ public

  open ⊗
    using (_,_)
    using (fst)

  -- currying
  λ⇑
    : ∀ ..{ℓ₀ ℓ₁ ℓ₂}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → {C : Set ℓ₂}
    → (A ⊗ B → C)
    → (A → B ⇒ C)
  λ⇑ f a b = f (a , b)

  -- uncurrying
  λ⇓
    : ∀ ..{ℓ₀ ℓ₁ ℓ₂}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → {C : Set ℓ₂}
    → (A → B ⇒ C)
    → (A ⊗ B → C)
  λ⇓ f (a , b) = f a b

  syntax λ⇓ (λ a → M) = λ⇓[ a ] M

  -- evaluation
  ap
    : ∀ ..{ℓ₀ ℓ₁}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → (A ⇒ B) ⊗ A → B
  ap (f , a) = f a

  -- functoriality
  [_⇒_]
    : ∀ ..{ℓ₀ ℓ₁ ℓ₂ ℓ₃}
    → {X₀ : Set ℓ₀}
    → {X₁ : Set ℓ₁}
    → {A : Set ℓ₂}
    → {B : Set ℓ₃}
    → (f : X₀ → A)
    → (g : B → X₁)
    → (A ⇒ B) → (X₀ ⇒ X₁)
  [ f ⇒ g ] = λ⇑ (ap <∘ ⊗.⟨ cmp g ⊗ f ⟩)

  -- diagonal
  Δ[_]
    : ∀ ..{ℓ₀ ℓ₁}
    → {A : Set ℓ₀}
    → {B : Set ℓ₁}
    → A ⇒ (B ⇒ A)
  Δ[_] = λ⇑ fst
