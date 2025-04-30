# SQL Ultimate Course – Zero to Hero

This repository contains practical work and scripts for three comprehensive SQL course sections:

1. **Ultimate SQL Course** (`1-sql-ultimate-course`)
2. **Data Warehouse Project** (`2-sql-data-warehouse-project`)
3. **Data Analytics Project** (`3-sql-data-analytics-project`)

---

## 📂 Full Repository Structure

```plaintext
SQL-Ultimate-Course-Zero-to-Hero
├─ 1-sql-ultimate-course
│  ├─ datasets
│  │  ├─ Customers.csv
│  │  ├─ Employees.csv
│  │  ├─ Orders.csv
│  │  ├─ OrdersArchive.csv
│  │  ├─ Products.csv
│  │  ├─ mysql
│  │  │  ├─ init-mysql-mydatabase.sql
│  │  │  └─ init-mysql-salesdb.sql
│  │  ├─ postgres
│  │  │  ├─ init-postgres-mydatabase.sql
│  │  │  └─ init-postgres-salesdb.sql
│  │  └─ sql-server
│  │     ├─ MyDatabase.bak
│  │     ├─ SalesDB.bak
│  │     ├─ init-sqlserver-mydatabase.sql
│  │     └─ init-sqlserver-salesdb.sql
│  ├─ docs
│  │  ├─ 00_SalesDB_DataModel.png
│  │  ├─ 01_SQL_Introduction.pdf
│  │  ├─ … (full PDF handouts list)
│  └─ scripts
│     ├─ 01_Query_Data_SELECT.sql
│     ├─ …
│     └─ 27_AI_and_SQL.sql
├─ 2-sql-data-warehouse-project
│  ├─ datasets (CRM & ERP CSVs)
│  ├─ docs (drawio, PNG, PDF diagrams & catalog)
│  ├─ scripts (bronze→silver→gold DDL & ETL)
│  └─ tests (quality checks)
├─ 3-sql-data-analytics-project
│  ├─ datasets (bronze→silver→gold CSVs & .bak)
│  ├─ docs (roadmaps & notes)
│  └─ scripts (00_init→13_report SQL modules)
├─ docker-compose.yml
└─ README.md
```

---

## 🔧 Prerequisites

- **Docker Desktop** (Mac or Windows) for containerised DBMS services
- **Visual Studio Code**
  - **Docker** extension by Microsoft
  - **mssql** extension (SQL Server client)
  - **PostgreSQL** extension by Microsoft or `SQLTools PostgreSQL` for Postgres ([github.com](https://github.com/microsoft/vscode-postgresql?utm_source=chatgpt.com))
  - **MySQL Shell for VS Code** or `SQLTools MySQL` extension for MySQL ([dev.mysql.com](https://dev.mysql.com/doc/mysql-shell-gui/en/mysql-shell-for-vscode-setup.html?utm_source=chatgpt.com))
- **Git** for version control

---

## ⚙️ Docker Compose Configuration

All services are defined in `docker-compose.yml`. This spins up SQL Server, Postgres and MySQL containers, plus mounts initialisation scripts and backups for each course section:

```yaml
version: '3.8'
services:
  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    container_name: sqlserver-dev
    ports: ['1433:1433']
    environment:
      ACCEPT_EULA: 'Y'
      SA_PASSWORD: 'YourStrong!Passw0rd'
    volumes:
      # Ultimate SQL Course backups and init scripts
      - ./1-sql-ultimate-course/datasets/sql-server:/var/opt/mssql/sqlserver_backups:ro
      # Data Analytics project .bak file
      - ./3-sql-data-analytics-project/datasets/DataWarehouseAnalytics.bak:/var/opt/mssql/backups/DataWarehouseAnalytics.bak:ro
      # Data Warehouse project init script
      - ./2-sql-data-warehouse-project/scripts/init_database.sql:/var/opt/mssql/init/init_datawarehouse.sql:ro
  postgres:
    image: postgres:15
    container_name: postgres-dev
    ports: ['5432:5432']
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: YourStrong!Passw0rd
    volumes:
      # Ultimate SQL Course init scripts
      - ./1-sql-ultimate-course/datasets/postgres:/docker-entrypoint-initdb.d:ro
      # Data Warehouse project does not auto-run on Postgres; see section below.
  mysql:
    image: mysql:8.0
    container_name: mysql-dev
    ports: ['3306:3306']
    environment:
      MYSQL_ROOT_PASSWORD: YourStrong!Passw0rd
    volumes:
      # Ultimate SQL Course init scripts
      - ./1-sql-ultimate-course/datasets/mysql:/docker-entrypoint-initdb.d:ro
      # Data Warehouse project does not auto-run on MySQL; see section below.
```

Bring up all containers:

```bash
docker compose up -d
```

---

## 🗄️ SQL Server Setup (Optional)

1. **Connect** via VS Code’s **mssql** extension:
   - Server: `localhost`, Port: `1433` (SQL Login)  
2. **Authenticate** as `sa/YourStrong!Passw0rd`.  
3. **Restore** backups in a New Query:

   ```sql
   RESTORE DATABASE MyDatabase FROM DISK = '/var/opt/mssql/sqlserver_backups/MyDatabase.bak' WITH MOVE 'MyDatabase' TO '/var/opt/mssql/data/MyDatabase.mdf', MOVE 'MyDatabase_log' TO '/var/opt/mssql/data/MyDatabase_log.ldf';
   RESTORE DATABASE SalesDB FROM DISK = '/var/opt/mssql/sqlserver_backups/SalesDB.bak' WITH MOVE 'SalesDB' TO '/var/opt/mssql/data/SalesDB.mdf', MOVE 'SalesDB_log' TO '/var/opt/mssql/data/SalesDB_log.ldf';
   ```

4. **Verify**:  

   ```sql
   SELECT name,state_desc FROM sys.databases WHERE name IN ('MyDatabase','SalesDB');
   ```

---

## 🐘 PostgreSQL Setup

Container uses official Postgres image and auto-runs any `*.sql` in `/docker-entrypoint-initdb.d` ([datadrenaline.medium.com](https://datadrenaline.medium.com/build-your-own-sql-fiddle-with-docker-vscode-88dfa54105fe?utm_source=chatgpt.com)). Following your Docker Compose:

1. **Initialisation**:
   - On startup, Postgres executes:
     - `init-postgres-mydatabase.sql` → creates `mydatabase`  
     - `init-postgres-salesdb.sql`   → creates `salesdb`  
2. **Install Extension** in VS Code:

   ```text
   ⇧⌘X → search 'PostgreSQL' by Microsoft → Install  ([github.com](https://github.com/microsoft/vscode-postgresql?utm_source=chatgpt.com))
   ```

3. **Create Connection Profile**:
   - Command Palette (`⇧⌘P`) → **PostgreSQL: New Query** → **Create Connection Profile**
   - Host: `localhost`, Port: `5432`
   - User: `postgres`, Password: `YourStrong!Passw0rd`
   - Database: `postgres` (to list all) or `mydatabase`/`salesdb`  
4. **Verify**:

   ```sql
   \l        -- lists all databases
   \c mydatabase
   \dt       -- list tables in mydatabase
   ```

---

## 🐬 MySQL Setup

MySQL container auto-runs any `*.sql` under `/docker-entrypoint-initdb.d` on first run ([stackoverflow.com](https://stackoverflow.com/questions/38504257/mysql-scripts-in-docker-entrypoint-initdb-are-not-executed?utm_source=chatgpt.com)).

1. **Initialisation**:
   - `init-mysql-mydatabase.sql` → creates `mydatabase`
   - `init-mysql-salesdb.sql`   → creates `salesdb`
2. **Install Extension** in VS Code:

   ```text
   ⇧⌘X → search 'MySQL Shell for VS Code' → Install  ([dev.mysql.com](https://dev.mysql.com/doc/mysql-shell-gui/en/mysql-shell-for-vscode-setup.html?utm_source=chatgpt.com))
   ```

3. **Connect**:
   - Command Palette (`⇧⌘P`) → **MySQL: Add Connection**
   - Host: `localhost`, Port: `3306`
   - User: `root`, Password: `YourStrong!Passw0rd`
   - Default: `mydatabase` or `salesdb`
4. **Verify**:

   ```sql
   SHOW DATABASES;
   USE mydatabase;
   SHOW TABLES;
   ```

---

## 🚀 Usage

- Switch your VS Code connection to the chosen DBMS.  
- Open and run `.sql` scripts in `scripts/` for each section.  
- Use `docs/` for diagrams, handouts, and architectural guidance.

---

## 🤝 Contributing

Fork → Branch → Commit → Push → Pull Request. Follow existing naming conventions and update docs accordingly.

---

## 📄 License

MIT © 2025 Ezra Chamba
