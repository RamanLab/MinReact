function [Jmin, minReactNo] = minReact(model, GrowthRateCutoff,tol, eliList)

% MinReact algorithm - method to idnetify the minimal metabolic networks 
% for a given metabolic network. 
%
% Inputs:
% model                 COBRA model
%
% Optional inputs:
% 'GrowthRateCutoff'    the minimum percentage of wild-type growth that the 
%                       minimal metabolic network should retain. 
%                       (default = 1 i.e. 100% wild-type growth) 
% 'tol'                 minimum flux a reaction should possess to be 
%                       considered active (default = 0)
% 'eliList'             List of reactions to be preserved in the minimal
%                       metabolic network (default: 'ATPM')
%                     
%
% Output:
% Jmin                  Array of length mxn m - number of minimal reactomes
%                       identified, n - number of reactions
%                       Jmin is a bitwise vector consisting of
%                       presence/absence of reaction in the minimal
%                       metabolic network
% minReactNo           	Number of reactions identified in the minimal
%                       reactome

% 
% Example:
% [Jmin, minReactNo] = minReact(model, 0.9 ,1e-07)
%
%

if(~exist('eliList','var'))
    eliList = {'ATPM'};
end

if(~exist('GrowthRateCutoff','var'))
    GrowthRateCutoff = 1;
end

if(~exist('tol','var')) 
    tol = 0;
end

% 
warning('off');
initCobraToolbox;
changeCobraSolver('ibm_cplex');

%Compute the wild-type flux of the organism
solnWT = optimizeCbModel(model,'max','one'); %Find the minNorm solution of the model

% Set lb to Cut-off percentage of the WT flux
modelNew = model;
modelNew.lb(find(model.c)) = GrowthRateCutoff*solnWT.f;

% Compute the rxnClasses using pFBA
if ~isfield(model,'rules')
    modelNew = generateRules(modelNew);
end
[RxnClasses] = pFBALocal(modelNew,'geneoption',0, 'tol' , 1e-10);

pFBAOpt_Rxns = cell2mat(cellfun(@(x) find(strcmp(x,model.rxns)), RxnClasses.pFBAOpt_Rxns, 'UniformOutput', false));
MLE_Rxns = cell2mat(cellfun(@(x) find(strcmp(x,model.rxns)), RxnClasses.MLE_Rxns, 'UniformOutput', false));
Blocked_Rxns = cell2mat(cellfun(@(x) find(strcmp(x,model.rxns)), RxnClasses.Blocked_Rxns, 'UniformOutput', false));
ZeroFlux_Rxns = cell2mat(cellfun(@(x) find(strcmp(x,model.rxns)), RxnClasses.ZeroFlux_Rxns, 'UniformOutput', false));

%Remove zero-flux reactions, blocked reactions and MLE reactions from the model
RxnsToRemove = [ZeroFlux_Rxns;Blocked_Rxns;MLE_Rxns]; 
modelNew.lb(RxnsToRemove) = 0;
modelNew.ub(RxnsToRemove) = 0;

%reactions to be retained
rxnsNotToRemove = cell2mat(cellfun(@(x) find(strcmp(x, model.rxns)), eliList, 'UniformOutput', false));
pFBAOpt_Rxns = setdiff(pFBAOpt_Rxns,rxnsNotToRemove);
JnzAll = [];
JnzRxns = [];
for noOfRxns = 1:length(pFBAOpt_Rxns)
    modelMod = modelNew;
    modelMod.lb(pFBAOpt_Rxns(noOfRxns)) = 0;
    modelMod.ub(pFBAOpt_Rxns(noOfRxns)) = 0;
    solnMod = optimizeCbModel(modelMod,'max','zero'); %Find the zero norm solution
    Jnz = solnMod.x > tol | solnMod.x < -tol; % Identify Jnz
    modelMod.lb(~Jnz) = 0;
    modelMod.ub(~Jnz) = 0;
    solnModNew = optimizeCbModel(modelMod,'max','one');
    if solnModNew.stat==1 && round(solnModNew.f,4) >= round(GrowthRateCutoff* solnWT.f,4) 
        JnzAll(size(JnzAll,1)+1,:) = double(Jnz)';
        JnzRxns(length(JnzRxns)+1,1) = sum(Jnz);
    end
end

minReactNo = min(JnzRxns); %Identify the mimimum size of all the Jnzs' identified
Jmin = unique(JnzAll(JnzRxns==minReactNo,:),'rows');

    

