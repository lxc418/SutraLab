function o=delete_terms(o,varargin)
% this script converts a regular nod into a 
%function [o,o2]=readNOD(varargin)
  % readNOD reads NOD file   
  %
  % INPUT
  %   filename     -- if file is named as 'abc.nod', a filename='abc'
  %                   is required
  %   outputnumber -- number of result extracted, this is useful when
  %                   output file is huge
  %   outputstart  -- (not implimented yet) the start of the result
  %
  % OUTPUT
  % o  -- a struct the same size as the number of output.
  % o2 -- a struct extracting headers with the extraction inf
  %
  % Example:
  % [noddata,nodhead]=readNOD('project','outputnumber',3);
  %    Purpose: parsing 'project.nod' (or 'project.NOD')
  %            only the first three result gets extracted

  % a string storing the caller functions
  caller = dbstack('-completenames'); caller = caller.name;

  o.varargin       = varargin;
  [o.transpose,  varargin] = getProp(varargin,'transpose','no');
  [delete_terms,  varargin] = getProp(varargin,'delete_terms','no');
  [inpObj,  varargin]      = getProp(varargin,'inp',[]);

  o.data=rmfield(o.data,'terms');
