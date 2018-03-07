# Multivariate Electricity Consumption Prediction with Extreme Learning Machine
In this paper, Extreme Learning Machine (ELM) is demonstrated to be a powerful tool for electricity consumption prediction based on its competitive prediction accuracy and superior computational speed compared to Support Vector Machine (SVM). Moreover, ELM is utilized to investigate the potentials of using auxiliary information such as electricity-related factors and environmental factors to augment the prediction accuracy obtained by purely using the electricity consumption factors. Furthermore, we formulate a combinatorial optimization problem of seeking an optimal subset of auxiliary factors and their corresponding optimal window sizes using the most suitable ELM structure, and propose a Discrete Dynamic Multi-Swarm Particle Swarm Optimization (DDMS-PSO) to address this problem. Experimental studies on a real-world building dataset demonstrate that electricity-related factors improve accuracy while environmental factors further boost accuracy. By using DDMSPSO, we find a subset of electricity-related and environmental factors, their respective window sizes, and the number of hidden neurons in ELM which leads to the best prediction accuracy.

## Contents of the repository
This repository contains resources used and described in the paper.

The repository is structured as follows:
> **NOTE:** this should follow the folders you have in this repository 

- `algorithms/`: Formal description of algorithm for entity normalization and sentence clustering.
- `data/`: Dataset used for this paper. 
- `code/`: Evaluation script.
- `evaluation/`: Evaluation script.
- `presentation/`: PDF of paper presentation in certain conference or venue.

## Code
Brief explanation about your code (where to start or how to run). 

## Data
Brief explanation of your datasets. 

## Additional Section
Additional section. 

## Citation
If you use the resources presented in this repository, please cite (using the following BibTeX entry):
```
@inproceedings{song2016multivariate,
  title={Multivariate electricity consumption prediction with extreme learning machine},
  author={Song, Hui and Qin, A Kai and Salim, Flora D},
  booktitle={Neural Networks (IJCNN), 2016 International Joint Conference on},
  pages={2313--2320},
  year={2016},
  organization={IEEE}
}
```
