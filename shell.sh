mkdir -p _build/refmt

eval $(./node_modules/.bin/dependencyEnv)
nopam

ocamlfind ocamlc -pp "refmt --print binary" -bin-annot -g -w -30 -w -40 -I _build/refmt/src  -package compiler-libs.common,reason,js_of_ocaml,menhirLib,ocaml-migrate-parsetree  -o _build/refmt/Refmt_Tar__Refmt -c -impl src/refmt/Refmt.re
ocamlfind ocamlc  -linkpkg -package compiler-libs.common,js_of_ocaml,menhirLib,ocaml-migrate-parsetree,reason -g -o _build/refmt/app.byte  _build/refmt/Refmt_Tar__Refmt.cmo
js_of_ocaml --source-map --no-inline --debug-info --pretty --linkall +weak.js +toplevel.js --opt 3 --disable strict -o _build/refmt/app.js _build/refmt/app.byte
