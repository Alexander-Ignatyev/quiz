run: build
	elm-reactor

build:
	elm-make src/Main.elm --output public/assets/js/elm.js --warn
