from fastapi import APIRouter, HTTPException, Depends
from sqlalchemy.orm import Session
from database import get_db  # Función para obtener la sesión de base de datos
from passlib.context import CryptContext  # Para manejo de contraseñas hasheadas
from models import Estudiante, UsuarioLogin, Usuario  # Asegúrate de importar el modelo Usuario y UsuarioLogin

router = APIRouter()

# Crear el contexto de passlib para trabajar con hashes de contraseñas
pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

@router.post("/login")
async def login(usuario_login: UsuarioLogin, db: Session = Depends(get_db)):
    # Buscar el usuario por correo electrónico
    usuario = db.query(Usuario).filter(Usuario.CorreoElectronico == usuario_login.CorreoElectronico).first()
    
    # Si el usuario no existe o la contraseña es incorrecta, lanzar un error
    if not usuario or not verify_password(usuario_login.Contraseña, usuario.Contraseña):
        raise HTTPException(
            status_code=401,
            detail="Correo electrónico o contraseña incorrectos"
        )
    
    # Si las credenciales son correctas, retornar un mensaje de éxito
    return {
        "IDUsuario": usuario.IDUsuario,
        "Nombre": usuario.Nombre,
        "Apellido": usuario.Apellido,
        "CorreoElectronico": usuario.CorreoElectronico,
        "message": "Login exitoso",
    }

# Función para verificar si la contraseña en texto plano coincide con la hasheada
def verify_password(plain_password: str, hashed_password: str) -> bool:
    return pwd_context.verify(plain_password, hashed_password)

@router.get("/estudiantes")
def get_estudiantes(db: Session = Depends(get_db)):
    estudiantes = db.query(Estudiante).all()
    return estudiantes