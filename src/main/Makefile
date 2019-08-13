include $(FSTAR_HOME)/ulib/ml/Makefile.include

all:
	fstar --odir out --codegen OCaml --extract 'Main' main.fst 
	$(OCAMLOPT) out/Main.ml -o out/main.exe
	./out/main.exe
check:
	fstar main.fst  

debug: 
	fstar main.fst --debug 'Main' --detail_errors --debug_level Medium --detail_hint_replay