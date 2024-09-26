### **Plan de Test Back-End**

| **Nom du Test**                   | **Description**                                 | **Le**          | **État**  |
|------------------------------------|-------------------------------------------------|-----------------|-----------|
| `/user/login`                      | Test de la connexion utilisateur avec JWT       | 12/09/2024      | ✅ Succès |
| `/user/register`                   | Test de l'inscription d'un nouvel utilisateur   | 12/09/2024      | ✅ Succès |
| `/entry` (GET)                     | Récupération de toutes les entrées d'un utilisateur | 12/09/2024   | ✅ Succès |
| `/entry` (POST)                    | Création d'une nouvelle entrée                  | 12/09/2024     | ✅ Succès |
| `/entry/{entryID}` (DELETE)        | Suppression d'une entrée spécifique par ID      | 12/09/2024      | ✅ Succès |

### **Plan de Test Front-End**

| **Nom du Test**             | **Description**                                         | **Le**          | **État**  |
|-----------------------------|---------------------------------------------------------|-----------------|-----------|
| **Test Connexion Utilisateur** | Vérification de connexion avec un JWT valide | 16/09/2024  | ✅ Succès |
| **Test Inscription Utilisateur** | Vérification de l'inscription | 16/09/2024  | ✅ Succès |
| **Test Affichage des Entrées**  | Vérification de l'affichage correct des entrées de l'utilisateur | 16/09/2024  | ✅ Succès |
| **Test Création d'Entrée**      | Vérification de la création d'une nouvelle entrée via formulaire | 16/09/2024  | ✅ Succès |
| **Test Suppression d'Entrée**   | Vérification de la suppression d'une entrée après confirmation | 16/09/2024  | ✅ Succès |
