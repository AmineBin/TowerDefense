-- Table des utilisateurs : contient les comptes des joueurs avec pseudo et mot de passe
CREATE TABLE IF NOT EXISTS users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    username TEXT NOT NULL UNIQUE,
    password TEXT NOT NULL
);

-- Table des amis : gère les relations d'amitié entre joueurs avec un statut (accepted, pending, refused)
CREATE TABLE IF NOT EXISTS friends (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT NOT NULL,
    friend_id INT NOT NULL,
    status TEXT NOT NULL DEFAULT 'pending' CHECK (status IN ('accepted', 'pending', 'refused')),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (friend_id) REFERENCES users(id)
);

-- Table de progression : sauvegarde l'état du joueur dans le jeu (vague actuelle, argent, score, date de sauvegarde)
CREATE TABLE IF NOT EXISTS progress (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT NOT NULL,
    current_wave INT NOT NULL,
    money INT NOT NULL,
    score INT DEFAULT 0,
    save_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table des tours : stocke toutes les tours construites par un joueur, leur type, position et niveau
CREATE TABLE IF NOT EXISTS towers (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    user_id INT NOT NULL,
    tower_type TEXT NOT NULL,
    position_x INT NOT NULL,
    position_y INT NOT NULL,
    level INT DEFAULT 1,
    FOREIGN KEY (user_id) REFERENCES users(id)
);
