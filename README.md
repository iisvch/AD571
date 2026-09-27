# Statistical Learning

This repository contains a Quarto book for a comprehensive course in
statistical learning. The book presents concepts, modeling workflows,
and reproducible examples as one continuous sequence rather than as
separate lecture and lab materials.

The course begins with statistical learning foundations and linear
regression, then builds toward interactions, classification, logistic
regression, discriminant analysis, resampling, feature engineering,
regularization, dimension reduction, nonlinear regression, tree-based
methods, ensembles, support vector machines, unsupervised learning, and
applied case studies.

## Book Contents

The rendered book currently contains 21 chapters:

| Chapter | Topic |
|---:|---|
| 1 | Statistical Learning Foundations |
| 2 | Linear Regression |
| 3 | Interactions and Marginal Effects |
| 4 | Classification Foundations |
| 5 | Logistic Regression and ROC Analysis |
| 6 | Discriminant Analysis |
| 7 | Model Assessment and Resampling |
| 8 | Data Splitting and Feature Engineering |
| 9 | Model Selection and Regularization |
| 10 | Dimension Reduction |
| 11 | Bias, Variance, and Nonlinear Models |
| 12 | Polynomial Regression and Step Functions |
| 13 | Splines and Generalized Additive Models |
| 14 | Classification Model Comparison |
| 15 | Margins and Perceptron |
| 16 | Tree-Based Methods |
| 17 | Ensemble Methods |
| 18 | Support Vector Machines |
| 19 | Unsupervised Learning |
| 20 | Statistical Learning in Practice |
| 21 | Applied Statistical Learning Case Studies |

## Repository Layout

| Path | Purpose |
|---|---|
| `_quarto.yml` | Book configuration, chapter order, HTML format, and bibliography settings. |
| `index.qmd` | Preface and book-level orientation. |
| `lectures/` | Integrated Quarto chapter files used in the rendered book. |
| `theme/` and `styles.css` | Academic visual theme and supplemental styling. |
| `datasets/` and `data/` | Course datasets used by examples and case studies. |
| `docs/` | Internal source maps, conversion notes, and maintenance references. |
| `renv.lock` and `renv/` | R environment metadata for reproducible rendering. |

## Rendering the Book

Install [Quarto](https://quarto.org/) and restore the R environment if
you want a fully reproducible local build:

```r
renv::restore()
```

Render the full book from the repository root:

```powershell
quarto render
```

The rendered HTML book is written to `_book/index.html`.

## Code Examples

Examples are organized with grouped language tabsets when both R and
Python versions are available. The tabsets use Quarto's shared language
grouping so a reader can switch between languages consistently across a
chapter.

Code chunks are currently configured with `#| eval: false`. This keeps
the book stable across machines, avoids duplicate outputs when both
languages are shown, and lets readers inspect complete code without
requiring every local package or dataset dependency at render time.

When adding examples, use executable Quarto chunk fences rather than
plain Markdown code fences:

````markdown
```{r}
#| echo: true
#| eval: false
#| fig-align: center

# R code here
```
````

````markdown
```{python}
#| echo: true
#| eval: false
#| fig-align: center

# Python code here
```
````

## Editing Guidelines

Keep chapters student-facing, concise, and cohesive. New material should
read as part of the book rather than as a separate lab handout, slide
deck, or instructor note.

Use the chapter sequence in `_quarto.yml` as the source of truth for the
rendered book. Supporting files in `docs/` can describe provenance and
maintenance decisions, but the book itself should stay focused on the
learning path.

Before opening a pull request, run:

```powershell
quarto render
```

For quick structural checks, these searches are also useful:

```powershell
rg -n "Worked Example|Applied Practice" lectures
rg -n '```r|```python' lectures
rg -n "#\\| eval: true" lectures
```
