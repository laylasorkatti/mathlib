import category_theory.instances.topological_spaces
import category_theory.limits.products
import topology.basic

universes u

open category_theory.limits
open category_theory.instances
namespace category_theory.instances

def Top.pi {β : Type u} (f : β → Top.{u}) : Top :=
{ α := Π b : β, (f b), str := by apply_instance }

def Top.pi_π {β : Type u} (f : β → Top) (b : β): Top.pi f ⟶ f b :=
{ val := λ g, g b, property := continuous_apply _ }

@[simp] def Top.hom_pi
  {α : Type u} {β : α → Top} {γ : Top}
  (f : Π a : α, γ ⟶ β a) : γ ⟶ Top.pi β :=
{ val := λ x b, f b x,
  property := continuous_pi (λ a, (f a).property) }

local attribute [extensionality] subtype.eq

instance : has_products.{u} Top.{u} :=
λ β f,
{ fan :=
  { X := Top.pi f,
    π := { app := Top.pi_π f } },
  is_product :=
  { lift := λ s, Top.hom_pi (λ j, s.π.app j),
    uniq' := λ s m w, begin tidy, rw ←w, tidy, end } }.

end category_theory.instances