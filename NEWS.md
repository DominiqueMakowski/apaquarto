# News for apaquarto


# Future Version Wishlist

- Masked references
- Create landscape pages for wide figures and tables.
- Figure and Tables in .pdf jou mode should fit automatically.
- Typst version that would allow for easy customization

# Version 3.1.0 (2024-09-02)

- The `floatsintext` option now works in docx and html. Setting it to
  `true`, intermingles text, figures, and tables. Setting it to `false`
  moves all figures and tables to the end of the document.

# Version 3.0.0 (2024-01-20)

The main goal for version 3 was to do everything with lua filters
instead of R. It was quite a journey, but apaquarto is now completely
independent of R, which should help folks working with other languages.

## Breaking changes

- The the `apafg-` and `apatb-` prefixes are no longer used for figures
  and tables. Use the standard Quarto prefixes (`fig-` and `tbl-`), as
  well as the standard quarto referencing syntax (e.g,. `@fig-myplot`
  will reference the `fig-myplot` chunk.).
- The include statement below the metadata is no longer used and must be
  deleted. An informative error will provide instruction if the include
  statement remains.

## Improvements

### .docx

- The title page and abstract page are now processed using lua filters
  instead of R.
- The officer package is no longer required to create a new reference
  document every time the document is rendered. Now, a lua filter looks
  for the `shorttitle` field in your yaml. If that is not found, the
  `title` and `subtitle` fields are used instead. The running header is
  assigned to the `description` field in the quarto metadata. This value
  will show up in the `Comments` field in the rendered .docx file, which
  is then inserted into the field box in the header.
- The .docx running header is set with a lua filter and a docx field
  that draws from the .docx metadata.

### .pdf

- The jou (journal) mode in .pdf is better supported. There are a few
  hacky solutions that need a bit of work.

# Version 2.0.0 (2023-11-10)

- Many small fixes
- Support for .html and .pdf became more solid.
- CReditT taxonomy added for author roles.

# Version 1.0.0 (2023-03-05)

Initial release. Basic functions worked, but relied on many hacks that I
always intended to fix. Mostly just for .docx, but .html and .pdf
supported to some degree.

- Most of the title page information was processed in R because I did
  not understand lua. UPDATE: As of version 3.0.0, all of the R code
  that used to be inserted, is not longer used. The lua filters take
  care of everything in the .html and .docx formats.
- Because I did not yet understand lua and Quarto, I processed figures
  and tables differently in a non-standard way. I wrestled with Quarto,
  but I could not stop it from formatting the captions the way it wanted
  to. Finally I gave up and processed them with non-standard syntax and
  knitr hooks. UPDATE: This was always intended to be a temporary
  solution. As of version 3.0.0, all non-standard syntax is gone.
- The ability to put simple markdown notes below figures and tables was
  important to me. The tricky part was to get them to travel with the
  figures and tables when they were part of floats or when they moved to
  the end of the document. Many headaches later, it works using the
  `apa-note` chunk option or `apa-note` as a custom attribute of a
  fenced div.
- APA level 4 and 5 headings should remain as true headings that appear
  in the navigation tab in MS Word. Yet they appear as if they are in
  the same paragraph with subsequent text. This feature was implemented
  with apaquarto.lua filter that inserts openxml tags in the headers:

<!-- -->

    ```openxml
    <w:vanish/><w:specVanish/>
    ```

This creates a *Style Separator* character that you can see in MS Word
by clicking the Show/Hide ¶ button. BTW, the CTRL+ALT+Enter keyboard
shortcut in Word will insert a style separator. See
https://www.cadmanediting.com/the-style-separator-a-hidden-gem-in-ms-word
