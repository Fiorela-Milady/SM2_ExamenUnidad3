from sqlalchemy import Column, Integer, String, DateTime
from sqlalchemy.types import Date
from database import Base
from pydantic import BaseModel

# Modelo SQLAlchemy para Usuario
class Usuario(Base):
    __tablename__ = 'Usuario'

    IDUsuario = Column(Integer, primary_key=True, autoincrement=True)
    Nombre = Column(String(50), nullable=False)
    Apellido = Column(String(50), nullable=False)
    CorreoElectronico = Column(String(100), nullable=False, unique=True)
    Contraseña = Column(String(255), nullable=False)
    Telefono = Column(String(15), nullable=True)
    CodigoVerificacion = Column(String(100), nullable=True)
    CodigoRecuperacion = Column(String(100), nullable=True)
    FechaExpiracionCodigo = Column(DateTime, nullable=True, default=None)

# Modelo Pydantic para la solicitud de login (solo correo y contraseña)
class UsuarioLogin(BaseModel):
    CorreoElectronico: str
    Contraseña: str


class Estudiante(Base):
    __tablename__ = 'Estudiante'

    IDEstudiante = Column(Integer, primary_key=True, autoincrement=True)
    TipoDocumento = Column(String(20), nullable=False)
    NumeroDocumento = Column(String(20), nullable=False)
    ValidadoConReniec = Column(String(20), nullable=False)
    CodigoEstudiante = Column(String(20), nullable=False, unique=True)
    ApellidoPaterno = Column(String(50), nullable=False)
    ApellidoMaterno = Column(String(50), nullable=False)
    Nombres = Column(String(100), nullable=False)
    Sexo = Column(String(10), nullable=False)
    FechaNacimiento = Column(Date, nullable=False)