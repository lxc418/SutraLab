%sl_read
%sl_plot_results_movie
%sl_plot_results_movie_last



%run analysis for the last time step found to be very useful when simulation is still running
delete('PART6.mat');clear_and_close;read_from=-2;sl_read_from;n=1;sl_plot_results_movie_last;post_calculation;



% run analysis to read all the result 


%delete('PART6.mat');clear_and_close;sl_read;
%two commands that i usually run
%delete('PART6.mat');sl_read;sl_plot_results_movie_mesh_neutral
%
%
%delete('PART6.mat');sl_read_;sl_plot_results_movie_mesh_neutral

%delete('PART6.mat');sl_read_last_output;sl_plot_results_movie_last;
%sl_read_and_adjust_mesh;write_inp;write_ics

