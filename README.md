# corona-analysis
A data perspective on three common Corona questions

In this notebook we will
* Look at data to answer common Corona questions
* Combine and celebrate Open Data from different sources
* Analyze the data according to the CRISP-DM process

This project was heavily motivated by the project at https://github.com/ard-data/2020-rki-archive.

---

We use `pandas` and `sklearn` for analysis, and `matplotlib`/`seaborn` for visualization.

* `corona.ipynb` is the notebook holding the analysis and further explanations
* `corona-cases.csv` and `weather.csv` files hold the feature data for each day between `24 Mar 2020` and `31 Dec 2020`
* `query.sh` is the bash script querying the corona data at https://github.com/ard-data/2020-rki-archive/tree/master/data/2_parsed
