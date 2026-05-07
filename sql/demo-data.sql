SET NAMES utf8mb4;

UPDATE inventory
SET invImage = CONCAT('/phpmotors', invImage),
    invThumbnail = CONCAT('/phpmotors', invThumbnail)
WHERE invImage NOT LIKE '/phpmotors/%';

UPDATE inventory
SET invImage = '/phpmotors/images/vehicles/wrangler.jpg',
    invThumbnail = '/phpmotors/images/vehicles/wrangler-tn.jpg'
WHERE invMake = 'Jeep ' AND invModel = 'Wrangler';

UPDATE inventory
SET invImage = REPLACE(invImage, '/phpmotors/images/', '/phpmotors/images/vehicles/'),
    invThumbnail = REPLACE(invThumbnail, '/phpmotors/images/', '/phpmotors/images/vehicles/')
WHERE invImage LIKE '/phpmotors/images/%'
  AND invImage NOT LIKE '/phpmotors/images/vehicles/%';

UPDATE inventory
SET invImage = '/phpmotors/images/no-image.png',
    invThumbnail = '/phpmotors/images/no-image.png'
WHERE invMake = 'Dog ' AND invModel = 'Car';

CREATE TABLE IF NOT EXISTS reviews (
  reviewId int UNSIGNED NOT NULL AUTO_INCREMENT,
  reviewText text NOT NULL,
  reviewDate timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  invId int NOT NULL,
  clientId int UNSIGNED NOT NULL,
  PRIMARY KEY (reviewId),
  KEY reviews_inventory_fk (invId),
  KEY reviews_client_fk (clientId),
  CONSTRAINT reviews_inventory_fk FOREIGN KEY (invId) REFERENCES inventory (invId) ON DELETE CASCADE,
  CONSTRAINT reviews_client_fk FOREIGN KEY (clientId) REFERENCES clients (clientId) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

INSERT INTO clients (clientId, clientFirstname, clientLastname, clientEmail, clientPassword, clientLevel, comment)
VALUES
  (1, 'Demo', 'Admin', 'demo.admin@phpmotors.test', 'demo-mode-login', '3', 'Demo admin for portfolio walkthrough.'),
  (2, 'Ariel', 'Reviewer', 'demo.user@phpmotors.test', 'demo-mode-login', '1', 'Sample client for seeded reviews.')
ON DUPLICATE KEY UPDATE
  clientFirstname = VALUES(clientFirstname),
  clientLastname = VALUES(clientLastname),
  clientEmail = VALUES(clientEmail),
  clientLevel = VALUES(clientLevel),
  comment = VALUES(comment);

DELETE FROM reviews
WHERE reviewText IN (
  'Great catalog experience: filters, detail pages and account actions are ready to show in a portfolio demo.',
  'The admin inventory flow is useful for demonstrating CRUD with PHP and MySQL.'
);

INSERT INTO reviews (reviewText, invId, clientId)
VALUES
  ('Great catalog experience: filters, detail pages and account actions are ready to show in a portfolio demo.', 10, 1),
  ('The admin inventory flow is useful for demonstrating CRUD with PHP and MySQL.', 3, 2);
