(lang dune 3.16)

(using menhir 3.0)

(name mod_lang)

(generate_opam_files true)

(source
 (github kwonlauren/mod-lang))

(authors "Lauren Kwon")

(maintainers "Lauren Kwon")

(license LICENSE)

(documentation https://url/to/documentation)

(package
 (name mod_lang)
 (synopsis "The mod language")
 (description "The mod language, a toy language for the obfuscation project")
 (depends ocaml dune core ppx_jane menhir))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/reference/dune-project/index.html
