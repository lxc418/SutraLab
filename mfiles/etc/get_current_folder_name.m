function o = get_current_folder_name()
%function [boolean,varargin] = get_current_folder_name()

%http://stackoverflow.com/questions/22509260/how-to-get-the-name-of-the-parent-folder-of-a-file-specified-by-its-full-path

s = regexp(pwd, '/', 'split');
o=s{end};

