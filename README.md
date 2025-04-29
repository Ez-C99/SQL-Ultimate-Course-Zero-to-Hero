# SQL Ultimate Course – Zero to Hero

This repository contains practical work and scripts for three comprehensive SQL courses:

1. **Data Analytics Project** (`sql-data-analytics-project`)  
2. **Data Warehouse Project** (`sql-data-warehouse-project`)  
3. **Ultimate SQL Course** (`sql-ultimate-course`)

---

## 📂 Repository Structure

```plaintext
SQL-Ultimate-Course-Zero-to-Hero
├─ sql-data-analytics-project/
│   ├─ datasets/        # Bronze → Silver → Gold CSVs & .bak backup
│   ├─ docs/            # Roadmaps, sketches & design PDFs
│   └─ scripts/         # 00_init… → 13_report… exploration & analysis
├─ sql-data-warehouse-project/
│   ├─ datasets/        # Source CRM & ERP CSVs
│   ├─ docs/            # Data models, ETL diagrams & data catalog
│   ├─ scripts/         # Bronze/Silver/Gold DDLs & loading procs
│   └─ tests/           # Quality-check scripts
└─ sql-ultimate-course/
    ├─ datasets/        # Init scripts & backups for MySQL/Postgres/SQL Server
    ├─ docs/            # Lecture slides & PDF handouts
    └─ scripts/         # 01_SELECT… → 27_AI_and_SQL.sql modules
```

---

## 🔧 Prerequisites

- [Docker Desktop for Mac](https://www.docker.com/products/docker-desktop)  
- [VS Code](https://code.visualstudio.com/) with **mssql** extension  
- Git (for cloning & pushing your repo)

---

## ⚙️ Local Setup

1. **Clone the repo**  

   ```bash
   git clone https://github.com/Ez-C99/SQL-Ultimate-Course-Zero-to-Hero.git
   cd SQL-Ultimate-Course-Zero-to-Hero
   ```

2. **Start SQL Server in Docker**  

   ```bash
   docker-compose up -d
   ```

3. **Connect via VS Code**  
   - Command Palette → **MS SQL: Connect → Create Connection Profile**  
   - Server: `localhost` / SQL Login: `sa` / `YourStrong!Passw0rd`

4. **Restore databases** (see `docker-compose.yml` volume mounts)  
   - Use the VS Code SQL explorer → **New Query** → copy the `RESTORE DATABASE…` scripts below.

   ```sql
   -- Analytics project
   RESTORE DATABASE DataWarehouseAnalytics
   FROM DISK = '/var/opt/mssql/backups/DataWarehouseAnalytics.bak'
   WITH MOVE 'DataWarehouseAnalytics' TO '/var/opt/mssql/data/DataWarehouseAnalytics.mdf',
         MOVE 'DataWarehouseAnalytics_log' TO '/var/opt/mssql/data/DataWarehouseAnalytics_log.ldf';
   GO

   -- Ultimate course (SalesDB & MyDatabase)
   RESTORE DATABASE SalesDB
   FROM DISK = '/var/opt/mssql/sqlserver_backups/SalesDB.bak'
   WITH MOVE 'SalesDB' TO '/var/opt/mssql/data/SalesDB.mdf',
         MOVE 'SalesDB_log' TO '/var/opt/mssql/data/SalesDB_log.ldf';
   GO

   RESTORE DATABASE MyDatabase
   FROM DISK = '/var/opt/mssql/sqlserver_backups/MyDatabase.bak'
   WITH MOVE 'MyDatabase' TO '/var/opt/mssql/data/MyDatabase.mdf',
         MOVE 'MyDatabase_log' TO '/var/opt/mssql/data/MyDatabase_log.ldf';
   GO
   ```

5. **(Optional)** Create `app_user` login for day-to-day work (see below).

   ```sql
   CREATE LOGIN app_user WITH PASSWORD = 'An0ther$trongPwd!';
   GO
   USE master;
   CREATE USER app_user FOR LOGIN app_user;
   GO
   ALTER SERVER ROLE db_datareader ADD MEMBER app_user;
   ALTER SERVER ROLE db_datawriter ADD MEMBER app_user;
   GO
   ```

---

## 🚀 Usage

- Navigate into each project folder in VS Code Explorer.  
- Open `.sql` scripts under `scripts/` and press **Run** (▶︎).  
- CSVs in `datasets/` can be loaded via `BULK INSERT` or your custom ETL procs.  
- Review design docs under `docs/` for diagrams, notes and architecture.

---

## 🎯 Goals

- **sql-data-analytics-project**: practice exploratory & analytical queries on a bronze→gold pipeline.  
- **sql-data-warehouse-project**: design & build a three-layer warehouse, ETL procs and data-quality tests.  
- **sql-ultimate-course**: master ANSI SQL, advanced functions, performance tuning and AI-assisted SQL.

---

## 🤝 Contributing

1. Fork the repository.  
2. Create a feature branch (`git checkout -b feature/name`).  
3. Commit your changes (`git commit -m 'Add …'`).  
4. Push to your fork (`git push origin feature/name`).  
5. Open a Pull Request.  

Please follow the folder naming conventions and add/update documentation in `docs/` as you work.

---

## 📄 License

MIT © 2025 Ezra Chamba
