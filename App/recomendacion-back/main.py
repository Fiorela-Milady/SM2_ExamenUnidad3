from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes import auth  # Asumiendo que tienes tus rutas de auth aquí

app = FastAPI()


# Configurar CORS para permitir acceso a tu API desde los orígenes mencionados
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Lista de orígenes permitidos
    allow_credentials=True,
    allow_methods=["*"],  # Permitir todos los métodos HTTP (GET, POST, PUT, DELETE, etc.)
    allow_headers=["*"],  # Permitir todos los headers
)

# Incluir las rutas
app.include_router(auth.router)

@app.get("/")
def read_root():
    return {"message": "Bienvenido al sistema de recomendación"}
