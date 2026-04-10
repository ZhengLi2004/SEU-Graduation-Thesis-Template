# SEU Thesis Template

This directory now contains a XeLaTeX thesis template and a 17-page regression sample for the Southeast University undergraduate thesis format.

## Structure

- `main.tex`: full sample entry file
- `seuthesis.cls`: thesis class file
- `content/`: sample abstracts, chapters, appendix, and acknowledgements
- `bib/references.bib`: sample bibliography data
- `imgs/`: image assets provided by the project
- `docs/`: original Word/PDF template sources
- `latexmkrc`: fixed XeLaTeX build configuration

## Build

Minimum build command:

```powershell
latexmk -xelatex main.tex
```

Recommended clean command:

```powershell
latexmk -c
```

## Notes

- The class now provides `\seublankmatter`, `\seuprefacematter`, and `\seumainmatter` for blank/preface/main page states.
- The class now provides `\seumakefrontmatter` plus the single-page commands `\seumakecover`, `\seumakeoriginalitystatement`, `\seumakeauthorizationstatement`, `\seumakeaistatement`, and `\seumottopage`.
- The class now provides `\seumakechineseabstract`, `\seumakeenglishabstract`, `\seumaketableofcontents`, and `\seuprintbibliography`.
- Chinese and English abstract body text should be edited in `content/abstract_zh.tex` and `content/abstract_en.tex`; keywords should be added with `\addkey{中文关键词}{EnglishKeyword}` in the preamble.
- Date fields in `\seusetup` should use numeric input such as `2026-4-10`; the class renders `年 / 月 / 日` automatically on the cover, statement pages, and AI statement page.
- AI usage rows can be appended with `\seuaiitem{tool=..., version=..., scope=..., process=..., pages=...}`.
- `main.pdf` is a full regression sample covering cover, declarations, AI statement, abstracts, TOC, body, figures, tables, equations, references, appendix, acknowledgements, and the final motto page.
- `imgs/cover-2.png` is reserved for the final page "止于至善" resource, not for the cover overlay.
