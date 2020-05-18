# MinReact Algorithm

MinReact is an efficient algorithm to identify the minimal metabolic networks or minimal reactome for a genome-scale metabolic network. MinReact utilises the functional classes of parsimonious FBA to identify the minimal reactome. The algorithm identifies multiple minimal reactomes for a given metabolic network. Additionally, the algorithm also takes input of the tolerance value, growth-rate cutoff and reactions to be retained in the minimal metabolic network. 

### Requirements
To perform synthetic lethality analysis using Fast-SL the following tools are needed:
1. [COBRA Toolbox](http://opencobra.github.io/cobratoolbox/)
2. A linear programming (LP) solver such as [Gurobi](http://www.gurobi.com/), [GLPK](https://www.gnu.org/software/glpk/) etc.
3. CPLEX v12.0 or higher for the parallel version of Fast-SL. For the serial version of Fast-SL, any COBRA-supported solver can be used. [CPLEX is available free for academics from IBM](https://ibm.onthehub.com/WebStore/ProductSearchOfferingList.aspx?srch=cplex)

### Citing Fast-SL
If you use MinReact in your work, please cite
>Gayathri Sambamoorthy and Karthik Raman (2020) "MinReact: a systematic approach for identifying minimal metabolic networks" _Bioinformatics_ **36** [doi:10.1093/bioinformatics/btaa497](https://academic.oup.com/bioinformatics/article/31/20/3299/195638/Fast-SL-an-efficient-algorithm-to-identify)



# Instructions for use
The algorithm uses `pFBA`. The `pFBA` code has been modified to suit the purpose of this algorithm. The modified pFBA code is available in the package as well. Additionally, `fastFVA` is used in the modified pFBA code. 

The algorithm is compatible with both COBRA 2.0 and COBRA 3.0. For COBRA 2.0, `sparseLP` and `fastFVA` codes are available in the additional folders.

## Prerequisites
1. [COBRA Toolbox](http://opencobra.github.io/cobratoolbox/)
2. IBM CPLEX solver; [CPLEX is available free for academics from IBM](https://ibm.onthehub.com/WebStore/ProductSearchOfferingList.aspx?srch=cplex)


### Acknowledgements
* [Initiative for Biological Systems Engineering](https://ibse.iitm.ac.in/)
* [Robert Bosch Centre for Data Science and Artificial Intelligence (RBCDSAI)](https://rbcdsai.iitm.ac.in/)

<img title="IBSE logo" src="https://github.com/RBC-DSAI-IITM/rbc-dsai-iitm.github.io/blob/master/images/IBSE_logo.png" height="200" width="200"><img title="RBC-DSAI logo" src="https://github.com/RBC-DSAI-IITM/rbc-dsai-iitm.github.io/blob/master/images/logo.jpg" height="200" width="351">
