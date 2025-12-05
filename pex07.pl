% pex5.pl
% USAFA UFO Sightings 2024
%
% name: Jeff Kwon
%
% Documentation: Other than consulting the HW7 code, none.
%

% The query to get the answer(s) or that there is no answer
% ?- solve.

object(balloon).
object(kite).
object(aircraft).
object(cloud).

cadet(smith).
cadet(garcia).
cadet(chen).
cadet(jones).

day(tuesday).
day(wednesday).
day(thursday).
day(friday).

solve :-
    object(SmithObject), object(GarciaObject), object(ChenObject), object(JonesObject),
    all_different([SmithObject, GarciaObject, ChenObject, JonesObject]),

    day(SmithDay), day(GarciaDay),
    day(ChenDay), day(JonesDay),
    all_different([SmithDay, GarciaDay, ChenDay, JonesDay]),

    Triples = [ [smith, SmithObject, SmithDay],
    [garcia, GarciaObject, GarciaDay],
    [chen, ChenObject, ChenDay],
    [jones, JonesObject, JonesDay] ],

    % C4C Smith did not see a weather balloon, nor kite.
    \+ member([smith, balloon, _], Triples),
    \+ member([smith, kite, _], Triples),

    % The one who saw the kite isn’t C4C Garcia.
    \+ member([garcia, kite, _], Triples),

    % Fridays sighting was made by either C4C Chen or the one who saw the fighter aircraft.
    member([chen, _, friday], Triples),
    member([_, aircraft, friday], Triples),

    % The kite was not sighted on Tuesday.
    \+ member([_, kite, tuesday], Triples),

    % Neither C4C Garcia nor C4C Jones saw the weather balloon.
    \+ member([garcia, balloon, _], Triples),
    \+ member([jones, balloon, _], Triples),

    % C4C Jones did not make their sighting on Tuesday.
    \+ member([jones, _, tuesday], Triples),

    % C4C Smith saw an object that turned out to be a cloud.
    member([smith, cloud, _], Triples),

    % The fighter aircraft was spotted on Friday.
    member([_, aircraft, friday], Triples),

    % The weather balloon was not spotted on Wednesday
    \+ member([_, balloon, wednesday], Triples),

    cadet(TuesCadet), cadet(WedCadet), cadet(ThursCadet), cadet(FriCadet),
    object(TuesObject), object(WedObject), object(ThursObject), object(FriObject),
    member([TuesCadet,TuesObject,tuesday],Triples),
    member([WedCadet,WedObject,wednesday],Triples),
    member([ThursCadet,ThursObject,thursday],Triples),
    member([FriCadet,FriObject,friday],Triples),
    
    tell(TuesCadet,TuesObject,tuesday),
    tell(WedCadet,WedObject,wednesday),
    tell(ThursCadet,ThursObject,thursday),
    tell(FriCadet,FriObject,friday).

% Succeeds if all elements of the argument list are bound and different.
% Fails if any elements are unbound or equal to some other element.
all_different([H | T]) :- member(H, T), !, fail.
all_different([_ | T]) :- all_different(T).
all_different([_]).

% Smith saw the cloud on (Tues/Wed/Thurs)
% Garcia saw the aircraft on Friday
% Chen saw the balloon on (Tuseday/Thursday)
% Jones saw the kite on (Wednesday/Thursday)

tell(X, Y, Z) :-
    write('C4C '), write(X), write(' saw the '), write(Y),
    write(' on '), write(Z), write('.'), nl.   