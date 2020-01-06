% Example of using fastFVA

% Stoichiometric matrix
% (adapted from Papin et al. Genome Res. 2002 12: 1889-1900.)
model.S=[
%	 v1 v2 v3 v4 v5 v6 b1 b2 b3
    -1  0  0  0  0  0  1  0  0 % A
	  1 -2 -2  0  0  0  0  0  0 % B
	  0  1  0  0 -1 -1  0  0  0 % C
	  0  0  1 -1  1  0  0  0  0 % D
	  0  0  0  1  0  1  0 -1  0 % E
	  0  1  1  0  0  0  0  0 -1 % byp
	  0  0 -1  1 -1  0  0  0  0 % cof
        ];

% Flux limits
%           v1   v2   v3   v4   v5   v6   b1    b2   b3
model.lb=[   0,   0,   0,   0,   0,   0,   0,   0,   0]'; % Irreversibility
model.ub=[ inf, inf, inf, inf, inf, inf,  10, inf, inf]'; % b1 represents the "substrate"

% b2 represents the "growth"
model.c=[0 0 0 0 0 0 0 1 0]';
model.b=zeros(size(model.S,1),1);

rxns={'v1','v2','v3','v4','v5','v6','b1','b2','b3'};

optPercentage=100; % FVA based on maximum growth
for iExperiment=1:2
   if iExperiment==1
      str='Flux ranges for the wild-type network';
   elseif iExperiment==2
      str='Flux ranges for a mutant with reaction v6 knocked out';
      model.lb(6)=0;
      model.ub(6)=0;
   end
   [minFlux,maxFlux,optsol,ret]=fastFVA(model, optPercentage);

   nFlux=length(minFlux);
   fprintf('\n%s\n\t[min,   max]\n',str)
   for i=1:nFlux
      fprintf('%s\t%1.2f\t%1.2f\n', rxns{i}, minFlux(i),maxFlux(i))
   end

   figure,hold on
   plot(1:nFlux,minFlux,'o')
   plot(1:nFlux,maxFlux,'o')
   line(repmat(1:nFlux,2,1),[minFlux';maxFlux'],'Color','k')
   xlim([0.5 9.5]),ylim([-1 11])
   set(gca,'XTickLabel',{'v1','v2','v3','v4','v5','v6','b1','b2','b3'})
   title(str)
end
