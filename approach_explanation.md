# Approach Explanation

## Overview

Our solution is designed as a generic, lightweight, CPU-compatible intelligent document analysis system that processes PDF documents to extract and prioritize the most relevant sections based on a given persona and job-to-be-done. The core objective is to provide meaningful and context-aware outputs tailored to diverse domains such as research, education, and business.

---

## Methodology

### 1. Section Extraction

We use PyMuPDF (fitz) to read and parse PDFs. A robust heuristic-based approach identifies potential section titles based on typography, casing, and positional context:

- Titles are assumed to be short, capitalized phrases.

- We check for isolated lines or lines in all uppercase with limited word count.

- Content between titles is grouped as the section's body.

This technique ensures the approach generalizes across diverse document formats without relying on fixed templates.

---

### 2. Keyword-Based Relevance Scoring

We determine the relevance of each section using a scoring function that matches it with the persona and job-to-be-done:

- **Keyword Extraction**: We tokenize the persona and job description using nltk, filter stopwords, and extract the top 20 keywords using frequency analysis.

- **Overlap Scoring**: Relevance is calculated based on keyword overlap between:
    - Section title and the query.
    - Section content and the query.

- **Heuristics**: Additional factors like content length and vocabulary diversity are added to the final score, which is then normalized.

This scoring allows flexible comparison across various domains and writing styles.

---

### 3. Subsection Refinement

To generate concise summaries:

- The top-ranked sections are further processed to extract 5 important sentences using a combination of:

    - Keyword richness

    - Sentence position (beginning and end of section preferred)

    - Sentence length heuristics

    - Presence of indicative words like "important", "key", "must", etc.

This mimics human summarization behavior and ensures information-rich output within constraints.

---

### 4. Output Format

The final JSON output contains:

- Metadata (input files, persona, job, timestamp)

- Top 5 Extracted Sections (with title, document, page number, rank)

- Subsection Summaries (refined key points for each top section)

This format supports downstream integration, UI rendering, or further automation.

---

## Constraints Handling

- **No Internet**: No internet access or external APIs are required.

- **CPU Only**: All operations run efficiently within 60 seconds on 3–5 documents.

- **< 1GB Memory**: Lightweight processing via nltk, PyMuPDF, and pure Python.

---

## Conclusion

Our approach balances interpretability, efficiency, and generalizability, making it suitable for a wide range of applications involving human-centric document summarization. It uses thoughtful heuristics instead of large ML models, ensuring reliability under real-world constraints.