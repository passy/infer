(*
 * Copyright (c) 2016 - present Facebook, Inc.
 * All rights reserved.
 *
 * This source code is licensed under the BSD style license found in the
 * LICENSE file in the root directory of this source tree. An additional grant
 * of patent rights can be found in the PATENTS file in the same directory.
 *)

open! IStd

(** Module for Type Environments. *)

(** Type for type environment. *)
type t

val create : unit -> t
(** Create a new type environment. *)

val load : SourceFile.t -> t option
(** Load a type environment for a source file *)

val load_global : unit -> t option
(** load the global type environment (Java) *)

val store : SourceFile.t -> t -> unit
(** Save a type environment into a file *)

val store_global : t -> unit
(** save a global type environment (Java) *)

val lookup : t -> Typ.Name.t -> Typ.Struct.t option
(** Look up a name in the global type environment. *)

val mk_struct :
  t -> ?default:Typ.Struct.t -> ?fields:Typ.Struct.fields -> ?statics:Typ.Struct.fields
  -> ?methods:Typ.Procname.t list -> ?supers:Typ.Name.t list -> ?annots:Annot.Item.t -> Typ.Name.t
  -> Typ.Struct.t
(** Construct a struct_typ, normalizing field types *)

val add_field : t -> Typ.Name.t -> Typ.Struct.field -> unit
(** Add a field to a given struct in the global type environment. *)

val sort_fields_tenv : t -> unit

val pp : Format.formatter -> t -> unit  [@@warning "-32"]
(** print a type environment *)

val language_is : t -> Language.t -> bool
(** Test the language from which the types in the tenv were translated *)
