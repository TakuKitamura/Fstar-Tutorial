include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	fstar main.fst --odir out --codegen OCaml --extract 'Main'  --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay --warn_error -272
	$(OCAMLOPT) out/Main.ml -o out/main.exe
	./out/main.exe

debug: 
	fstar main.fst --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay --warn_error -272

playground:
	fstar playground.fst --odir out --codegen OCaml --extract 'Playground'  --debug 'Playground' --detail_errors --debug_level Extreme --detail_hint_replay --warn_error -272
	$(OCAMLOPT) out/Playground.ml -o out/playground.exe
	./out/playground.exe

krml: 
	krml krml.fst -verbose -drop WasmSupport -tmpdir ./out -no-prefix Krml krml.fst
