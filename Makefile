run: build
	elm-reactor

build:
	elm-make src/Main.elm --output public/elm.js --warn
