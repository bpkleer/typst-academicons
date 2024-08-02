#import "lib.typ": *

= typst-academicons

bpkleer

https://github.com/bpkleer/typst-academicons

A Typst library for Academicons v1.9.4 icons through the desktop fonts.

This is based on the code from `duskmoon314` and the package for #link("https://github.com/duskmoon314/typst-fontawesome")[#text("typst-fontawesome", weight: "bold")].

== Usage

=== Install the fonts

You can download the fonts from the official website: https://jpswalsh.github.io/academicons/

After downloading the zip file, you can install the fonts depending on your OS.

==== Typst web app

You can simply upload the `ttf` files to the web app and use them with this package.

==== Mac

You can double click the `ttf` files to install them.

==== Windows

You can right click the `ttf` files and select `Install`.

=== Import the library

==== Using the typst packages

You can install the library using the typst packages:

`#import "@preview/academicons:0.1.0": *`

==== Manually install

Copy all files start with `lib` to your project and import the library:

`#import "lib.typ": *`

There are three files:

- `lib.typ`: The main entrypoint of the library.
- `lib-impl.typ`: The implementation of `ai-icon`.
- `lib-gen.typ`: The generated icons.

I recommend renaming these files to avoid conflicts with other libraries.

=== Use the icons

You can use the `ai-icon` function to create an icon with its name:

```typst #ai-icon("lattes")``` #ai-icon("lattes")

Or you can use the `ai-` prefix to create an icon with its name:

```typst #ai-lattes()``` #ai-lattes() (This is equivalent to ```typst ai-icon().with("lattes")```)

==== Full list of icons

You can find all icons on the #link("https://jpswalsh.github.io/academicons/")[official website].

==== Customization

The `ai-icon` function passes args to `text`, so you can customize the icon by passing parameters to it:

```typst #ai-icon("lattes", fill: blue)``` #ai-icon("lattes", fill: blue)

```typst #ai-lattes(size: 15pt)``` #ai-lattes(size: 15pt)

==== Stacking icons 

The `ai-stack` function can be used to create stacked icons:

```typst #ai-stack(ai-icon-args: (fill: black), "doi", ("cv", (fill: blue, size: 20pt)))``` #ai-stack(ai-icon-args: (fill: black), "doi", ("cv", (fill: blue, size: 20pt)))

Declaration is `ai-stack(box-args: (:), grid-args: (:), ai-icon-args: (:), ..icons)`

- The order of the icons is from the bottom to the top.
- `ai-icon-args` is used to set the default args for all icons.
- You can also control the internal `box` and `grid` by passing the `box-args` and `grid-args` to the `ai-stack` function.
- Currently, four types of icons are supported. The first three types leverage the `ai-icon` function, and the last type is just a content you want to put in the stack.
  - `str`, e.g., `"lattes"`
  - `array`, e.g., `("lattes", (fill: white, size: 5.5pt))`
  - `arguments`, e.g. `arguments("lattes", fill: white)`
  - `content`, e.g. `ai-lattes(fill: white)`

== Gallery

Here are all the icons in the library. The first column is the icon function you can use, and the second column is what you get with `ai-<iconname>`. The third column is what you get when you use `ai-icon("<iconname>")` with the icon name.

#include "gallery.typ"