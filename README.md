# MinReact Algorithm

MinReact is an efficient algorithm to identify the minimal metabolic networks or minimal reactome for a genome-scale metabolic network. MinReact utilises the functional classes of parsimonious FBA to identify the minimal reactome. The algorithm identifies multiple minimal reactomes for a given metabolic network. Additionally, the algorithm also takes input of the tolerance value, growth-rate cutoff and reactions to be retained in the minimal metabolic network. 

Inputs:


#Instructions for use
The algorithm uses pFBA. The pFBA code has been modified to suit the purpose of the algorithm. The modified pFBA code is available in the package as well. Additionally, fastFVA is used in the modified pFBA code. 

The algorithm is compatible with both versions of COBRA 2.0 and COBRA 3.0. For COBRA 2.0, sparseLP and fastFVA codes are available in the additional folders.  

Prerequisite:
IBM CPLEX solver

