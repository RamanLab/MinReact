function SetWorkerCount(nworkers)
% SetWorkerCount Configures the number of (parallel) workers
%
% Requires the Parallel computing toolbox

if ~exist('matlabpool')
   warning('Parallel computing toolbox not available.')
   return
end

if nworkers <= 1
   if GetWorkerCount() > 0
      matlabpool close
   end
else
   if GetWorkerCount() ~= nworkers
      % Only need to do this once
      if GetWorkerCount()  > 0
         matlabpool close
      end
      matlabpool('open', nworkers)
      fprintf('Parallel computation initialized\n')
   end
end
