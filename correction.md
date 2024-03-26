Bon travail on voit l'implication.

Je ne vois pas pourquoi créé ton module 3-cloudwatch. Il aurait fallu simplement appelé via aws_lambda_invoke la fonction lambda que tu as créé qui envoie des messages à SNS. Tu aurai pu faire le trigger de la lambda directement dans ton code terraform. 
C'est pour ça que ton code de la lambda a besoin de describe les EC2. Normalement tu passes l'id de l'EC2 en paramètre de la l'invocation de la function lamda.
Vous n'avez pas les droits de créer de rôle sur la sandboxx donc je ne pense pas que ton module 4-preventmistake puisse fonctionner dans le compte de démo.
Pas besoin de créer une deuxieme fonction lambda. tu aurai pu utiliser la première

+ 1 pour la doc tf + 0.5 pour semantic release, il te manque juste les permissions pour pousser le tag.
note : 16.5 / 20 