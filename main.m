%Projet Matlab Crappe Martin 



% Canal fréquentiel = bande de fréquence déterminée sur le canal partagé

clear all;
close all;

%% Définition des parametres de la simulation
parametre;

%% Calcul des variables utiles dépendant de ces param`etres
setup;

%% Calcul des signaux dans l’émetteur
emetteur;
% Manque adaptation amplitude


%% Passage à travers le canal
canal;
% Manque délais
% Manque filtre passe bas avant de l'envoyer

% Calcul des opérations effectuées dans le récepteur
%% Reception
recepteur;
% Manque troncature du filtre
% Manque mise à l'échelle pour respecter la dynamique de l'ADC

%resultats;

% Affichage des résultats

