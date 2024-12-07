-- Tabla Usuario
CREATE TABLE Usuario (
    IDUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    CorreoElectronico NVARCHAR(100) NOT NULL UNIQUE,
    Contraseña NVARCHAR(255) NOT NULL,
    Telefono NVARCHAR(15),
    CodigoVerificacion NVARCHAR(100) NULL,
    CodigoRecuperacion NVARCHAR(100) NULL,
    FechaExpiracionCodigo DATETIME NULL
);
GO

-- Tabla Estudiante
CREATE TABLE Estudiante (
    IDEstudiante INT IDENTITY(1,1) PRIMARY KEY,
    TipoDocumento NVARCHAR(20) NOT NULL,
    NumeroDocumento NVARCHAR(20) NOT NULL UNIQUE,
    ValidadoConReniec NVARCHAR(20) NOT NULL,
    CodigoEstudiante NVARCHAR(20) NOT NULL UNIQUE,
    ApellidoPaterno NVARCHAR(50) NOT NULL,
    ApellidoMaterno NVARCHAR(50) NOT NULL,
    Nombres NVARCHAR(100) NOT NULL,
    Sexo NVARCHAR(10) NOT NULL,
    FechaNacimiento DATE NOT NULL
);
GO

-- Tabla Curso
CREATE TABLE Curso (
    IDCurso INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Estado NVARCHAR(10) NOT NULL CHECK (Estado IN ('Activo', 'Inactivo'))
);
GO

-- Tabla CriteriosEvaluacion
CREATE TABLE CriteriosEvaluacion (
    IDCriterio INT IDENTITY(1,1) PRIMARY KEY,
    NombreCriterio NVARCHAR(MAX) NOT NULL,
    IDCurso INT NOT NULL,
    FOREIGN KEY (IDCurso) REFERENCES Curso(IDCurso)
);
GO

-- Tabla Notas
CREATE TABLE Notas (
    IDNota INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    NumeroBimestre INT NOT NULL CHECK (NumeroBimestre BETWEEN 1 AND 4),
    IDCriterio INT NOT NULL,
    Nota CHAR(2) NOT NULL CHECK (Nota IN ('AD', 'A', 'B', 'C')),
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (IDCriterio) REFERENCES CriteriosEvaluacion(IDCriterio)
);
GO

-- Tabla Extracurricular
CREATE TABLE Extracurricular (
    IDExtracurricular INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Criterio NVARCHAR(100) NOT NULL,
    Estado NVARCHAR(10) NOT NULL CHECK (Estado IN ('Activo', 'Inactivo'))
);
GO

-- Nueva Tabla ExtracurricularEstudiante
CREATE TABLE ExtracurricularEstudiante (
    ID INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    IDExtracurricular INT NOT NULL,
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (IDExtracurricular) REFERENCES Extracurricular(IDExtracurricular)
);
GO

-- Tabla Areas
CREATE TABLE Areas (
    CodigoArea CHAR(1) PRIMARY KEY, -- C, H, A, S, I, D, E
    NombreArea NVARCHAR(100) NOT NULL,
    AtributosInteres NVARCHAR(MAX),
    AtributosAptitud NVARCHAR(MAX)
);
GO

-- Tabla PreguntasTest
CREATE TABLE PreguntasTest (
    IDPregunta INT IDENTITY(1,1) PRIMARY KEY,
    NumeroPregunta INT NOT NULL UNIQUE,
    TextoPregunta NVARCHAR(MAX) NOT NULL,
    TipoPregunta NVARCHAR(10) NOT NULL CHECK (TipoPregunta IN ('Interés', 'Aptitud')),
    CodigoArea CHAR(1) NOT NULL,
    FOREIGN KEY (CodigoArea) REFERENCES Areas(CodigoArea)
);
GO

-- Tabla RespuestasTest
CREATE TABLE RespuestasTest (
    IDRespuesta INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    IDPregunta INT NOT NULL,
    Respuesta BIT NOT NULL, -- 1 para "Sí", 0 para "No"
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (IDPregunta) REFERENCES PreguntasTest(IDPregunta)
);
GO

-- Tabla ResultadosTest
CREATE TABLE ResultadosTest (
    IDResultado INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    CodigoArea CHAR(1) NOT NULL,
    TipoPregunta NVARCHAR(10) NOT NULL CHECK (TipoPregunta IN ('Interés', 'Aptitud')),
    Puntuacion INT NOT NULL,
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (CodigoArea) REFERENCES Areas(CodigoArea)
);
GO




INSERT INTO Areas (CodigoArea, NombreArea, AtributosInteres, AtributosAptitud)
VALUES
('C', 'Área Administrativa', 'Organización, Supervisión, Orden, Análisis y síntesis, Colaboración, Cálculo', 'Persuasivo, Objetivo, Práctico, Tolerante, Responsable, Ambicioso'),
('H', 'Área de Humanidades y Ciencias Sociales y Jurídicas', 'Precisión Verbal, Organización, Relación de hechos, Lingüística, Orden, Justicia', 'Responsable, Justo, Conciliador, Persuasivo, Sagaz, Imaginativo'),
('A', 'Área Artística', 'Estético, Armónico, Manual, Visual, Auditivo', 'Sensible, Imaginativo, Creativo, Detallista, Innovador, Intuitivo'),
('S', 'Área de Ciencias de la Salud', 'Asistir, Investigar, Precisión, Percepción, Análisis, Ayudar', 'Altruista, Solidario, Paciente, Comprensivo, Respetuoso, Persuasivo'),
('I', 'Área de Enseñanzas Técnicas', 'Cálculo, Científico, Manual, Exactitud, Planificar', 'Preciso, Práctico, Crítico, Analítico, Rígido'),
('D', 'Área de Defensa y Seguridad', 'Justicia, Equidad, Colaboración, Espíritu de equipo, Liderazgo', 'Arriesgado, Solidario, Valiente, Agresivo, Persuasivo'),
('E', 'Área de Ciencias Experimentales', 'Investigación, Orden, Organización, Análisis y Síntesis, Cálculo numérico, Clasificar', 'Metódico, Analítico, Observador, Introvertido, Paciente, Seguro');



INSERT INTO PreguntasTest (NumeroPregunta, TextoPregunta, TipoPregunta, CodigoArea)
VALUES
(1, '¿Aceptarías trabajar escribiendo artículos en la sección económica de un diario?', 'Interés', 'C'),
(2, '¿Te ofrecerías para organizar la despedida de soltero de uno de tus amigos?', 'Aptitud', 'C'),
(3, '¿Te gustaría dirigir/crear un proyecto de urbanización en tu provincia?', 'Interés', 'A'),
(4, '¿A una frustración siempre opones un pensamiento positivo?', 'Aptitud', 'S'),
(5, '¿Te dedicarías a socorrer a personas accidentadas o atacadas por asaltantes?', 'Interés', 'D'),
(6, '¿Cuando eras chico, te interesaba saber cómo estaban construidos tus juguetes?', 'Interés', 'I'),
(7, '¿Te interesan más los misterios de la naturaleza que los secretos de la tecnología?', 'Aptitud', 'E'),
(8, '¿Escuchas atentamente los problemas que te plantean tus amigos?', 'Interés', 'S'),
(9, '¿Te ofrecerías para explicar a tus compañeros un determinado tema que ellos no entendieron?', 'Interés', 'H'),
(10, '¿Eres exigente y crítico con tu equipo de trabajo?', 'Aptitud', 'I'),
(11, '¿Te atrae armar rompecabezas o puzzles?', 'Interés', 'A'),
(12, '¿Te gustaría conocer la diferencia entre macroeconomía y microeconomía?', 'Interés', 'C'),
(13, '¿Usar uniforme te hace sentir distinto, importante?', 'Aptitud', 'D'),
(14, '¿Participarías como profesional en un espectáculo de acrobacia aérea?', 'Interés', 'D'),
(15, '¿Organizas tu dinero de manera que te alcance hasta el próximo cobro?', 'Aptitud', 'C'),
(16, '¿Convences fácilmente a otras personas sobre la validez de tus argumentos?', 'Interés', 'S'),
(17, '¿Te gustaría estar informado sobre los nuevos descubrimientos que se están realizando sobre el origen del Universo?', 'Interés', 'E'),
(18, '¿Ante una situación de emergencia actúas rápidamente?', 'Aptitud', 'D'),
(19, '¿Cuando tienes que resolver un problema matemático, perseveras hasta encontrar la solución?', 'Interés', 'I'),
(20, '¿Si te convocara tu club preferido para planificar, organizar y dirigir un campo de deportes, aceptarías?', 'Interés', 'C'),
(21, '¿Eres el que pone un toque de alegría en las fiestas?', 'Interés', 'A'),
(22, '¿Crees que los detalles son tan importantes como el todo?', 'Aptitud', 'A'),
(23, '¿Te sentirías a gusto trabajando en un ámbito hospitalario?', 'Interés', 'S'),
(24, '¿Te gustaría participar para mantener el orden ante grandes desórdenes y cataclismos?', 'Interés', 'D'),
(25, '¿Pasarías varias horas leyendo algún libro de tu interés?', 'Interés', 'H'),
(26, '¿Planificas detalladamente tus trabajos antes de empezar?', 'Aptitud', 'I'),
(27, '¿Entablas una relación casi personal con tu ordenador?', 'Interés', 'I'),
(28, '¿Disfrutas modelando con arcilla?', 'Interés', 'A'),
(29, '¿Ayudas habitualmente a los no videntes (a quien lo necesite) a cruzar la calle?', 'Aptitud', 'S'),
(30, '¿Consideras importante que desde la educación secundaria se fomente la actitud crítica y la participación activa?', 'Aptitud', 'H'),
(31, '¿Aceptarías que las mujeres formaran parte de las fuerzas armadas bajo las mismas normas que los hombres?', 'Interés', 'D'),
(32, '¿Te gustaría crear nuevas técnicas para descubrir las patologías de algunas enfermedades a través del microscopio?', 'Interés', 'E'),
(33, '¿Participarías en una campaña de prevención contra la enfermedad como el sida?', 'Interés', 'S'),
(34, '¿Te interesan los temas relacionados al pasado y a la evolución del hombre?', 'Interés', 'H'),
(35, '¿Te incluirías en un proyecto de investigación de los movimientos sísmicos y sus consecuencias?', 'Interés', 'E'),
(36, '¿Fuera de los horarios escolares, dedicas algún día de la semana a la realización de actividades corporales?', 'Interés', 'A'),
(37, '¿Te interesan las actividades de mucha acción y de reacción rápida en situaciones imprevistas y de algún peligro?', 'Interés', 'D'),
(38, '¿Te ofrecerías para colaborar como voluntario en los gabinetes espaciales de la NASA?', 'Interés', 'I'),
(39, '¿Te gusta más el trabajo manual que el trabajo intelectual?', 'Aptitud', 'A'),
(40, '¿Estarías dispuesto a renunciar a un momento placentero para ofrecer tu servicio como profesional (ayudando)?', 'Aptitud', 'S'),
(41, '¿Participarías de una investigación sobre la violencia en el fútbol?', 'Interés', 'H'),
(42, '¿Te gustaría trabajar en un laboratorio mientras estudias?', 'Interés', 'E'),
(43, '¿Arriesgarías tu vida para salvar la vida de otro que no conoces?', 'Aptitud', 'D'),
(44, '¿Te agradaría hacer un curso de primeros auxilios?', 'Interés', 'S'),
(45, '¿Tolerarías empezar tantas veces como fuere necesario hasta obtener el logro deseado?', 'Interés', 'A'),
(46, '¿Distribuyes tu horarios del día adecuadamente para poder hacer todo lo planeado?', 'Aptitud', 'C'),
(47, '¿Harías un curso para aprender a fabricar los instrumentos y/o piezas de las máquinas o aparatos con que trabajas?', 'Interés', 'I'),
(48, '¿Elegirías una profesión en la tuvieras que estar algunos meses alejado de tu familia, por ejemplo el marino?', 'Interés', 'D'),
(49, '¿Te radicarías en una zona agrícola-ganadera para desarrollar tus actividades como profesional?', 'Interés', 'E'),
(50, '¿Cuando estás en un grupo trabajando, te entusiasma producir ideas originales y que sean tenidas en cuenta?', 'Interés', 'A'),
(51, '¿Te resulta fácil coordinar un grupo de trabajo?', 'Aptitud', 'C'),
(52, '¿Te resultó interesante el estudio de las ciencias biológicas?', 'Interés', 'S'),
(53, '¿Si una gran empresa solicita un profesional como gerente de comercialización, te sentirías a gusto desempeñando ese rol?', 'Interés', 'C'),
(54, '¿Te incluirías en un proyecto nacional de desarrollo de la principal fuente de recursos de tu provincia?', 'Interés', 'H'),
(55, '¿Tienes interés por saber cuales son las causas que determinan ciertos fenómenos, aunque saberlo no altere tu vida?', 'Aptitud', 'E'),
(56, '¿Descubriste algún filósofo o escritor que haya expresado tus mismas ideas con antelación?', 'Interés', 'H'),
(57, '¿Desearías que te regalen algún instrumento musical para tu cumpleaños?', 'Interés', 'A'),
(58, '¿Aceptarías colaborar con el cumplimiento de las normas en lugares públicos?', 'Interés', 'D'),
(59, '¿Crees que tus ideas son importantes, y haces todo lo posible para ponerlas en práctica?', 'Aptitud', 'I'),
(60, '¿Cuando se descompone un artefacto en tu casa, te dispones prontamente a repararlo?', 'Interés', 'I'),
(61, '¿Formarías parte de un equipo de trabajo orientado a la preservación de la flora y la fauna en extinción?', 'Interés', 'E'),
(62, '¿Leerías revistas relacionadas con los últimos avances científicos y tecnológicos en el área de la salud?', 'Interés', 'S'),
(63, '¿Preservar las raíces culturales de nuestro país, te parece importante y necesario?', 'Aptitud', 'H'),
(64, '¿Te gustaría realizar una investigación que contribuyera a hacer más justa la distribución de la riqueza?', 'Interés', 'H'),
(65, '¿Te gustaría realizar tareas auxiliares en una nave, como por ejemplo izado y arriado de velas, pintura y conservación del casco, arreglo de averías, conservación de motores, etc.?', 'Interés', 'D'),
(66, '¿Crees que un país debe poseer la más alta tecnología armamentista, a cualquier precio?', 'Aptitud', 'D'),
(67, '¿La libertad y la justicia son valores fundamentales en tu vida?', 'Interés', 'D'),
(68, '¿Aceptarías hacer una práctica pagadas en una industria de productos alimenticios en el sector de control de calidad?', 'Interés', 'E'),
(69, '¿Consideras que la salud pública debe ser prioritaria, gratuita y eficiente para todos?', 'Aptitud', 'S'),
(70, '¿Te interesaría investigar sobre alguna nueva vacuna?', 'Interés', 'S'),
(71, '¿En un equipo de trabajo, preferís el rol de coordinador?', 'Interés', 'C'),
(72, '¿En una discusión entre amigos, te ofreces como mediador?', 'Aptitud', 'H'),
(73, '¿Estás de acuerdo con la formación de un cuerpo de soldados profesionales?', 'Interés', 'D'),
(74, '¿Lucharías por una causa justa hasta las últimas consecuencias?', 'Interés', 'D'),
(75, '¿Te gustaría investigar científicamente sobre cultivos agrícolas?', 'Interés', 'E'),
(76, '¿Harías un nuevo diseño de una prenda pasada de moda, ante una reunión?', 'Aptitud', 'A'),
(77, '¿Visitarías un observatorio astronómico para conocer en acción el funcionamiento de los aparatos?', 'Interés', 'E'),
(78, '¿Dirigirías el área de importación y exportación de una empresa?', 'Interés', 'C'),
(79, '¿Te cohíbes/inhibes –cortas- al entrar a un lugar nuevo con gente desconocida?', 'Aptitud', 'E'),
(80, '¿Te gratificaría el trabajar con niños?', 'Interés', 'H'),
(81, '¿Harías el diseño de un cartel o afiche para una campaña contra el sida?', 'Interés', 'A'),
(82, '¿Dirigirías un grupo de teatro independiente?', 'Aptitud', 'A'),
(83, '¿Enviarías tu curriculum a una empresa automotriz que solicita gerente para su área de producción?', 'Interés', 'I'),
(84, '¿Participarías en un grupo de defensa internacional dentro de alguna fuerza armada?', 'Interés', 'D'),
(85, '¿Te costearías tus estudios trabajando en una auditoría –revisión de las cuentas-?', 'Interés', 'C'),
(86, '¿Eres de los que defiendes causas perdidas?', 'Aptitud', 'H'),
(87, '¿Ante una emergencia epidémica participarías en una campaña brindando tu ayuda?', 'Interés', 'S'),
(88, '¿Sabrías responder que significa ADN o ARN?', 'Interés', 'E'),
(89, '¿Elegirías una carrera cuyo instrumento de trabajo fuere la utilización de un idioma extranjero?', 'Interés', 'H'),
(90, '¿Trabajar con objetos, máquinas, te resulta más gratificante que trabajar con personas?', 'Aptitud', 'I'),
(91, '¿Te resultaría gratificante ser asesor contable en una empresa reconocida?', 'Interés', 'C'),
(92, '¿Ante un llamado solidario, te ofrecerías para cuidar a un enfermo?', 'Interés', 'S'),
(93, '¿Te atrae investigar sobre los misterios del universo, por ejemplo los agujeros negros?', 'Interés', 'E'),
(94, '¿El trabajo individual te resulta más rápido y efectivo que el trabajo grupal?', 'Aptitud', 'I'),
(95, '¿Dedicarías parte de tu tiempo a ayudar a personas con carencias o necesitadas?', 'Interés', 'S'),
(96, '¿Cuando eliges tu ropa o decoras un ambiente, tienes en cuenta la combinación de los colores, las telas o el estilo de los muebles?', 'Interés', 'A'),
(97, '¿Te gustaría trabajar como profesional dirigiendo la construcción de una empresa hidroeléctrica?', 'Interés', 'E'),
(98, '¿Sabes qué es el PIB? Se trata de un concepto económico. ¿Te gusta este tipo de tema?', 'Interés', 'C');

