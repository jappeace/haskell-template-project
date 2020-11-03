OPTIMIZATION=-O0
build: 
	cabal new-build all -j --ghc-options $(OPTIMIZATION)

haddock:
	cabal new-haddock all

haddock-hackage:
	cabal new-haddock all --haddock-for-hackage --haddock-option=--hyperlinked-source
	echo "the hackage ui doesn't accept the default format, use command instead"
	cabal upload -d --publish ./dist-newstyle/*-docs.tar.gz

hpack:
	nix-shell ./nix/hpack-shell.nix --run "make update-cabal"

ghcid: clean hpack
	ghcid \
		--test="main" \
		--command="ghci" \
		test/Spec
ghcid-app: clean hpack
	ghcid \
		--main="main" \
		--command="ghci" \
		app/exe

ghci:
	ghci app/exe

etags:
	hasktags  -e ./src

update-cabal: etags
	hpack --force ./

clean:
	rm -fR dist dist-*

.PHONY: test

sdist: hpack
	nix-build . # ad-hoc proof it builds
	cabal sdist

run:
	cabal new-run exe --ghc-options $(OPTIMIZATION) -- \

brittany_:
	$(shell set -x; for i in `fd hs`; do hlint --refactor --refactor-options=-i $$i; brittany --write-mode=inplace $$i; done)

brittany:
	nix-shell ./nix/travis-shell.nix --run "make brittany_"

bundle:
	rm -f result
	nix-build nix/bundle.nix
	mv result template
