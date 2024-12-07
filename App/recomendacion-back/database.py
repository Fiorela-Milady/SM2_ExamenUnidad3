from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import sessionmaker

# Configuración de la base de datos
SQLALCHEMY_DATABASE_URL = "mssql+pyodbc://DESKTOP-8U07BS7/Zenturiqdb?driver=ODBC+Driver+17+for+SQL+Server"

# Crear el engine de SQLAlchemy
engine = create_engine(SQLALCHEMY_DATABASE_URL, connect_args={"trusted_connection": "yes"})

# Crear una instancia de sessionmaker
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

# Crear una base para las clases
Base = declarative_base()

# Dependencia para obtener la sesión de base de datos
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
