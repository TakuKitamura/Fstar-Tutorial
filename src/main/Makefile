include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	fstar --odir out --codegen OCaml --extract 'Main' main.fst 
	$(OCAMLOPT) out/Main.ml -o out/main.exe
	./out/main.exe
check:
	fstar main.fst  

debug: 
	fstar main.fst --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay

playground:
		fstar playground.fst --odir out --codegen OCaml --extract 'Playground'  --debug 'Main' --detail_errors --debug_level Extreme --detail_hint_replay
	$(OCAMLOPT) out/Playground.ml -o out/playground.exe
	./out/playground.exe

