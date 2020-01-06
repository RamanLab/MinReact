function nworkers=GetWorkerCount()
% GetWorkerCount Obtain the size of the parallel worker pool.

if ~exist('matlabpool')
   % Parallel computing toolbox not installed
   nworkers=0;
else
   % NOTE: If you have an old version of the Parallel computing toolbox
   %       installed (R2007b), the following form of matlabpool is not
   %       supported. In this case you can either hardcode the number of
   %       workers below or use the function "pool_size" listed on the
   %       Mathworks support web instead (Technical Solution ID: 1-5UDHQP).
   nworkers=matlabpool('size');
end
