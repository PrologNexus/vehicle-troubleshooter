% Define problems and their priorities
problem(engine_not_starting, 1).
problem(electrical_system_failures, 2).
problem(alternator_failure, 3).
problem(malfunctioning_automatic_transmission_control_module,56).

% Define symptoms for each problem
has_symptom(engine_not_starting, car_does_not_start).
has_symptom(engine_not_starting, clicking_noise_when_turning_key).
has_symptom(electrical_system_failures, non_functioning_lights).
has_symptom(electrical_system_failures, frequent_fuse_blowouts).
has_symptom(electrical_system_failures, dead_battery).
has_symptom(alternator_failure, dead_battery).
has_symptom(alternator_failure, dimming_lights).
has_symptom(malfunctioning_automatic_transmission_control_module, stuck_in_one_gear).
has_symptom(malfunctioning_automatic_transmission_control_module, transmission_warning_light).

% Causes of Problems
caused_by(engine_not_starting, dead_battery).
caused_by(engine_not_starting, faulty_starter_motor).
caused_by(engine_not_starting, bad_ignition_switch).
caused_by(electrical_system_failures, faulty_alternator).
caused_by(electrical_system_failures, wiring_issues).
caused_by(electrical_system_failures, malfunctioning_fuses_or_relays).
caused_by(alternator_failure, worn_alternator_brushes).
caused_by(alternator_failure, bad_bearings).
caused_by(alternator_failure, electrical_faults).
caused_by(malfunctioning_automatic_transmission_control_module, software_issues).
caused_by(malfunctioning_automatic_transmission_control_module, electrical_faults).
caused_by(malfunctioning_automatic_transmission_control_module, internal_transmission_problems).

% Start the diagnostic process
start:-
    findall(Symptom, has_symptom(_, Symptom), AllSymptoms),
    list_to_set(AllSymptoms, UniqueSymptoms),
    findall(Priority-Symptom, (member(Symptom, UniqueSymptoms), problem_priority(_, Priority-Symptom)), PrioritizedSymptoms),
    sort(1, @=<, PrioritizedSymptoms, SortedPrioritizedSymptoms),
    pairs_values(SortedPrioritizedSymptoms, SortedSymptoms),
    remove_duplicates(SortedSymptoms, UniqueSortedSymptoms),
    diagnose(UniqueSortedSymptoms,[],[],[]).

% Remove duplicate elements from a list
remove_duplicates([], []).
remove_duplicates([H|T], List) :-     
     member(H, T), !,
     remove_duplicates(T, List).
remove_duplicates([H|T], [H|T1]) :- 
     remove_duplicates(T, T1).

% Helper predicate to associate each symptom with its problems priority
problem_priority(Problem-Symptom, Priority-Symptom) :-
    problem(Problem, Priority).
	
% Main diagnosis function
diagnose([], [], [], []) :-    
    write('Unable to find problem'), !.
diagnose([], _, [], _) :-    
    write('Unable to find problem'), !.
diagnose([], _, _, _) :-    
    write('Unable to find problem'), !.
diagnose([Symptom|RestSymptoms], AskedSymptoms, ConfirmedSymptoms, Problems) :-
    ask_symptom(Symptom, Response),
	append([Symptom], AskedSymptoms, NewExcludedSymptoms),

    ( Response == yes -> 
        find_problem(Symptom, NewProblems),
        ( length(NewProblems, Length), Length > 1 -> 
            append([Symptom], ConfirmedSymptoms, NewConfirmedSymptoms),
			nl,
			write('The symptoms shows so far are: '), write(NewConfirmedSymptoms),nl,
			write('The problem has been deduced to: '), write(NewProblems),nl,

            find_remaining_symptoms(NewProblems, NewExcludedSymptoms, RestofSymptom),
			diagnose(RestofSymptom, NewExcludedSymptoms, NewConfirmedSymptoms, NewProblems);
          write('The problem is: '), write(NewProblems), nl, write_causes(NewProblems)
        );
      diagnose(RestSymptoms, [Symptom|AskedSymptoms], ConfirmedSymptoms, Problems)
    ).

% Ask user about a symptom
ask_symptom(Symptom, Response) :-
    write('Does your car have the following symptom: '), write(Symptom), write('? (yes/no) '),
    read(Response).

% Find problem based on symptom
find_problem(Symptom, Problems) :-
    findall(P, has_symptom(P, Symptom), Problems). 
	
find_remaining_symptoms([], _,[]).
find_remaining_symptoms([P|RestProblems], ExcludedSymptoms, RestofSymptoms) :-
    findall(S, (has_symptom(P, S), \+ member(S, ExcludedSymptoms)), FilteredSymptoms),
    find_remaining_symptoms(RestProblems, ExcludedSymptoms, RestofSymptomsRest),
    append(FilteredSymptoms, RestofSymptomsRest, RestofSymptoms).


% Find and write the causes of a problem
write_causes([]).
write_causes([Problem|RestProblems]) :-
    findall(Cause, caused_by(Problem, Cause), Causes),
    write('This maybe Caused by: '), write(Causes), nl,
    write_causes(RestProblems).