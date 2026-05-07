# Gestion de Autos - Demo PHP Motors

Demo funcional de gestion de autos hecho en PHP y MySQL. Incluye catalogo por clasificacion, detalle de vehiculo, registro/login, administracion de inventario y reviews.

## Ejecutar con Docker

Requisitos: Docker Desktop.

```bash
docker compose up --build
```

Abrir:

```text
http://localhost:8080/phpmotors/
```

Credenciales demo de administrador:

```text
Email: demo.admin@phpmotors.test
Password: Portfolio1!
```

La base MySQL queda expuesta en `localhost:3307` por si quieres inspeccionarla. Si necesitas reiniciar los datos desde cero:

```bash
docker compose down -v
docker compose up --build
```

## Ejecutar con XAMPP/WAMP

1. Copia este proyecto dentro de `htdocs/phpmotors`.
2. Crea una base de datos llamada `phpmotors`.
3. Importa `sql/phpmotors.sql`.
4. Importa `sql/demo-data.sql`.
5. Verifica en `library/connections.php` las credenciales locales de MySQL o define estas variables de entorno: `DB_HOST`, `DB_NAME`, `DB_USER`, `DB_PASSWORD`.
6. Abre `http://localhost/phpmotors/`.

## Rutas para mostrar en portafolio

- Home/catalogo: `http://localhost:8080/phpmotors/`
- Login: `http://localhost:8080/phpmotors/accounts/index.php?action=login`
- Admin: iniciar sesion con las credenciales demo y entrar a "Vehicle Management".
- Clasificaciones: usar el menu superior para ver autos por categoria.

## Publicar para el boton "Demo" del portafolio

Si solo necesitas que el visitante navegue y vea el proyecto, usa la version estatica en `portfolio-demo/`. Esa carpeta no necesita PHP, MySQL ni Docker, y puede subirse junto con tu portafolio a Netlify, Vercel, GitHub Pages o cualquier hosting estatico.

El boton Demo de tu portafolio debe apuntar a:

```text
/portfolio-demo/
```

Si quieres publicar la aplicacion PHP real con base de datos, la opcion mas directa para este proyecto es Railway, porque permite publicar un contenedor Docker y agregar MySQL al mismo proyecto.

1. Sube este repositorio a GitHub.
2. En Railway, crea un nuevo proyecto desde el repositorio.
3. Agrega una base de datos MySQL al proyecto.
4. En el servicio web, define esta variable:

```text
DEMO_MODE=true
```

5. Railway expone las variables `MYSQLHOST`, `MYSQLPORT`, `MYSQLDATABASE`, `MYSQLUSER` y `MYSQLPASSWORD`; la app ya las lee automaticamente.
6. Genera el dominio publico del servicio web.
7. En tu portafolio, el boton Demo debe apuntar a:

```text
https://tu-dominio-de-railway/phpmotors/
```

En Render tambien se puede desplegar con Docker y MySQL, pero requiere configurar el servicio de MySQL y sus variables manualmente. El contenedor ya incluye el codigo y si `DEMO_MODE=true` prepara los datos demo al iniciar.
