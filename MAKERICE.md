  This file documents all of the constructors implemented by this package. They are organised by the type of element that they create, and their possible parameters and respective meanings are expressed.
  This file should be updated as new constructors are added. Each constructor documented should obey the following canonical form:

## element short name (element long name): constructor identifier
constructor identifier {
  parameter: description of parameter
  element accepted as parameter: identification of element short name
}

# Here are the currently supported constructors:

## rice (ricing config): makeRice
makeRice {
  customFiles: list of {input, ouput} where input is a filepath and output is a list of filepaths
  wm: a wm element
}

## wm (window manager): makeWM.i3
makeWM.i3 {
  font: a font (fontfact) element
  term: a term (terminal) element
  modkey: the key used to trigger the default i3 key bindings
    (Mod4 is windows key, Mod3 is alt key.)
}

# term (terminal): makeTerm.lilyterm
makeTerm.lilyterm {
  browser: the browser used to open http:// and ftp:// links
  email: the email client used to open email addresses
  font: a font (font face) element
}

# font (fontface): makeFont
makeFont {
  name: the name of the font (current only dejavu is supported)
  size: the pt size of the font
}
