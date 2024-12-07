-- Tabla Usuario
CREATE TABLE Usuario (
    IDUsuario INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(50) NOT NULL,
    Apellido NVARCHAR(50) NOT NULL,
    CorreoElectronico NVARCHAR(100) NOT NULL UNIQUE,
    Contrase�a NVARCHAR(255) NOT NULL,
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
    TipoPregunta NVARCHAR(10) NOT NULL CHECK (TipoPregunta IN ('Inter�s', 'Aptitud')),
    CodigoArea CHAR(1) NOT NULL,
    FOREIGN KEY (CodigoArea) REFERENCES Areas(CodigoArea)
);
GO

-- Tabla RespuestasTest
CREATE TABLE RespuestasTest (
    IDRespuesta INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    IDPregunta INT NOT NULL,
    Respuesta BIT NOT NULL, -- 1 para "S�", 0 para "No"
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (IDPregunta) REFERENCES PreguntasTest(IDPregunta)
);
GO

-- Tabla ResultadosTest
CREATE TABLE ResultadosTest (
    IDResultado INT IDENTITY(1,1) PRIMARY KEY,
    IDEstudiante INT NOT NULL,
    CodigoArea CHAR(1) NOT NULL,
    TipoPregunta NVARCHAR(10) NOT NULL CHECK (TipoPregunta IN ('Inter�s', 'Aptitud')),
    Puntuacion INT NOT NULL,
    FOREIGN KEY (IDEstudiante) REFERENCES Estudiante(IDEstudiante),
    FOREIGN KEY (CodigoArea) REFERENCES Areas(CodigoArea)
);
GO




INSERT INTO Areas (CodigoArea, NombreArea, AtributosInteres, AtributosAptitud)
VALUES
('C', '�rea Administrativa', 'Organizaci�n, Supervisi�n, Orden, An�lisis y s�ntesis, Colaboraci�n, C�lculo', 'Persuasivo, Objetivo, Pr�ctico, Tolerante, Responsable, Ambicioso'),
('H', '�rea de Humanidades y Ciencias Sociales y Jur�dicas', 'Precisi�n Verbal, Organizaci�n, Relaci�n de hechos, Ling��stica, Orden, Justicia', 'Responsable, Justo, Conciliador, Persuasivo, Sagaz, Imaginativo'),
('A', '�rea Art�stica', 'Est�tico, Arm�nico, Manual, Visual, Auditivo', 'Sensible, Imaginativo, Creativo, Detallista, Innovador, Intuitivo'),
('S', '�rea de Ciencias de la Salud', 'Asistir, Investigar, Precisi�n, Percepci�n, An�lisis, Ayudar', 'Altruista, Solidario, Paciente, Comprensivo, Respetuoso, Persuasivo'),
('I', '�rea de Ense�anzas T�cnicas', 'C�lculo, Cient�fico, Manual, Exactitud, Planificar', 'Preciso, Pr�ctico, Cr�tico, Anal�tico, R�gido'),
('D', '�rea de Defensa y Seguridad', 'Justicia, Equidad, Colaboraci�n, Esp�ritu de equipo, Liderazgo', 'Arriesgado, Solidario, Valiente, Agresivo, Persuasivo'),
('E', '�rea de Ciencias Experimentales', 'Investigaci�n, Orden, Organizaci�n, An�lisis y S�ntesis, C�lculo num�rico, Clasificar', 'Met�dico, Anal�tico, Observador, Introvertido, Paciente, Seguro');



INSERT INTO PreguntasTest (NumeroPregunta, TextoPregunta, TipoPregunta, CodigoArea)
VALUES
(1, '�Aceptar�as trabajar escribiendo art�culos en la secci�n econ�mica de un diario?', 'Inter�s', 'C'),
(2, '�Te ofrecer�as para organizar la despedida de soltero de uno de tus amigos?', 'Aptitud', 'C'),
(3, '�Te gustar�a dirigir/crear un proyecto de urbanizaci�n en tu provincia?', 'Inter�s', 'A'),
(4, '�A una frustraci�n siempre opones un pensamiento positivo?', 'Aptitud', 'S'),
(5, '�Te dedicar�as a socorrer a personas accidentadas o atacadas por asaltantes?', 'Inter�s', 'D'),
(6, '�Cuando eras chico, te interesaba saber c�mo estaban construidos tus juguetes?', 'Inter�s', 'I'),
(7, '�Te interesan m�s los misterios de la naturaleza que los secretos de la tecnolog�a?', 'Aptitud', 'E'),
(8, '�Escuchas atentamente los problemas que te plantean tus amigos?', 'Inter�s', 'S'),
(9, '�Te ofrecer�as para explicar a tus compa�eros un determinado tema que ellos no entendieron?', 'Inter�s', 'H'),
(10, '�Eres exigente y cr�tico con tu equipo de trabajo?', 'Aptitud', 'I'),
(11, '�Te atrae armar rompecabezas o puzzles?', 'Inter�s', 'A'),
(12, '�Te gustar�a conocer la diferencia entre macroeconom�a y microeconom�a?', 'Inter�s', 'C'),
(13, '�Usar uniforme te hace sentir distinto, importante?', 'Aptitud', 'D'),
(14, '�Participar�as como profesional en un espect�culo de acrobacia a�rea?', 'Inter�s', 'D'),
(15, '�Organizas tu dinero de manera que te alcance hasta el pr�ximo cobro?', 'Aptitud', 'C'),
(16, '�Convences f�cilmente a otras personas sobre la validez de tus argumentos?', 'Inter�s', 'S'),
(17, '�Te gustar�a estar informado sobre los nuevos descubrimientos que se est�n realizando sobre el origen del Universo?', 'Inter�s', 'E'),
(18, '�Ante una situaci�n de emergencia act�as r�pidamente?', 'Aptitud', 'D'),
(19, '�Cuando tienes que resolver un problema matem�tico, perseveras hasta encontrar la soluci�n?', 'Inter�s', 'I'),
(20, '�Si te convocara tu club preferido para planificar, organizar y dirigir un campo de deportes, aceptar�as?', 'Inter�s', 'C'),
(21, '�Eres el que pone un toque de alegr�a en las fiestas?', 'Inter�s', 'A'),
(22, '�Crees que los detalles son tan importantes como el todo?', 'Aptitud', 'A'),
(23, '�Te sentir�as a gusto trabajando en un �mbito hospitalario?', 'Inter�s', 'S'),
(24, '�Te gustar�a participar para mantener el orden ante grandes des�rdenes y cataclismos?', 'Inter�s', 'D'),
(25, '�Pasar�as varias horas leyendo alg�n libro de tu inter�s?', 'Inter�s', 'H'),
(26, '�Planificas detalladamente tus trabajos antes de empezar?', 'Aptitud', 'I'),
(27, '�Entablas una relaci�n casi personal con tu ordenador?', 'Inter�s', 'I'),
(28, '�Disfrutas modelando con arcilla?', 'Inter�s', 'A'),
(29, '�Ayudas habitualmente a los no videntes (a quien lo necesite) a cruzar la calle?', 'Aptitud', 'S'),
(30, '�Consideras importante que desde la educaci�n secundaria se fomente la actitud cr�tica y la participaci�n activa?', 'Aptitud', 'H'),
(31, '�Aceptar�as que las mujeres formaran parte de las fuerzas armadas bajo las mismas normas que los hombres?', 'Inter�s', 'D'),
(32, '�Te gustar�a crear nuevas t�cnicas para descubrir las patolog�as de algunas enfermedades a trav�s del microscopio?', 'Inter�s', 'E'),
(33, '�Participar�as en una campa�a de prevenci�n contra la enfermedad como el sida?', 'Inter�s', 'S'),
(34, '�Te interesan los temas relacionados al pasado y a la evoluci�n del hombre?', 'Inter�s', 'H'),
(35, '�Te incluir�as en un proyecto de investigaci�n de los movimientos s�smicos y sus consecuencias?', 'Inter�s', 'E'),
(36, '�Fuera de los horarios escolares, dedicas alg�n d�a de la semana a la realizaci�n de actividades corporales?', 'Inter�s', 'A'),
(37, '�Te interesan las actividades de mucha acci�n y de reacci�n r�pida en situaciones imprevistas y de alg�n peligro?', 'Inter�s', 'D'),
(38, '�Te ofrecer�as para colaborar como voluntario en los gabinetes espaciales de la NASA?', 'Inter�s', 'I'),
(39, '�Te gusta m�s el trabajo manual que el trabajo intelectual?', 'Aptitud', 'A'),
(40, '�Estar�as dispuesto a renunciar a un momento placentero para ofrecer tu servicio como profesional (ayudando)?', 'Aptitud', 'S'),
(41, '�Participar�as de una investigaci�n sobre la violencia en el f�tbol?', 'Inter�s', 'H'),
(42, '�Te gustar�a trabajar en un laboratorio mientras estudias?', 'Inter�s', 'E'),
(43, '�Arriesgar�as tu vida para salvar la vida de otro que no conoces?', 'Aptitud', 'D'),
(44, '�Te agradar�a hacer un curso de primeros auxilios?', 'Inter�s', 'S'),
(45, '�Tolerar�as empezar tantas veces como fuere necesario hasta obtener el logro deseado?', 'Inter�s', 'A'),
(46, '�Distribuyes tu horarios del d�a adecuadamente para poder hacer todo lo planeado?', 'Aptitud', 'C'),
(47, '�Har�as un curso para aprender a fabricar los instrumentos y/o piezas de las m�quinas o aparatos con que trabajas?', 'Inter�s', 'I'),
(48, '�Elegir�as una profesi�n en la tuvieras que estar algunos meses alejado de tu familia, por ejemplo el marino?', 'Inter�s', 'D'),
(49, '�Te radicar�as en una zona agr�cola-ganadera para desarrollar tus actividades como profesional?', 'Inter�s', 'E'),
(50, '�Cuando est�s en un grupo trabajando, te entusiasma producir ideas originales y que sean tenidas en cuenta?', 'Inter�s', 'A'),
(51, '�Te resulta f�cil coordinar un grupo de trabajo?', 'Aptitud', 'C'),
(52, '�Te result� interesante el estudio de las ciencias biol�gicas?', 'Inter�s', 'S'),
(53, '�Si una gran empresa solicita un profesional como gerente de comercializaci�n, te sentir�as a gusto desempe�ando ese rol?', 'Inter�s', 'C'),
(54, '�Te incluir�as en un proyecto nacional de desarrollo de la principal fuente de recursos de tu provincia?', 'Inter�s', 'H'),
(55, '�Tienes inter�s por saber cuales son las causas que determinan ciertos fen�menos, aunque saberlo no altere tu vida?', 'Aptitud', 'E'),
(56, '�Descubriste alg�n fil�sofo o escritor que haya expresado tus mismas ideas con antelaci�n?', 'Inter�s', 'H'),
(57, '�Desear�as que te regalen alg�n instrumento musical para tu cumplea�os?', 'Inter�s', 'A'),
(58, '�Aceptar�as colaborar con el cumplimiento de las normas en lugares p�blicos?', 'Inter�s', 'D'),
(59, '�Crees que tus ideas son importantes, y haces todo lo posible para ponerlas en pr�ctica?', 'Aptitud', 'I'),
(60, '�Cuando se descompone un artefacto en tu casa, te dispones prontamente a repararlo?', 'Inter�s', 'I'),
(61, '�Formar�as parte de un equipo de trabajo orientado a la preservaci�n de la flora y la fauna en extinci�n?', 'Inter�s', 'E'),
(62, '�Leer�as revistas relacionadas con los �ltimos avances cient�ficos y tecnol�gicos en el �rea de la salud?', 'Inter�s', 'S'),
(63, '�Preservar las ra�ces culturales de nuestro pa�s, te parece importante y necesario?', 'Aptitud', 'H'),
(64, '�Te gustar�a realizar una investigaci�n que contribuyera a hacer m�s justa la distribuci�n de la riqueza?', 'Inter�s', 'H'),
(65, '�Te gustar�a realizar tareas auxiliares en una nave, como por ejemplo izado y arriado de velas, pintura y conservaci�n del casco, arreglo de aver�as, conservaci�n de motores, etc.?', 'Inter�s', 'D'),
(66, '�Crees que un pa�s debe poseer la m�s alta tecnolog�a armamentista, a cualquier precio?', 'Aptitud', 'D'),
(67, '�La libertad y la justicia son valores fundamentales en tu vida?', 'Inter�s', 'D'),
(68, '�Aceptar�as hacer una pr�ctica pagadas en una industria de productos alimenticios en el sector de control de calidad?', 'Inter�s', 'E'),
(69, '�Consideras que la salud p�blica debe ser prioritaria, gratuita y eficiente para todos?', 'Aptitud', 'S'),
(70, '�Te interesar�a investigar sobre alguna nueva vacuna?', 'Inter�s', 'S'),
(71, '�En un equipo de trabajo, prefer�s el rol de coordinador?', 'Inter�s', 'C'),
(72, '�En una discusi�n entre amigos, te ofreces como mediador?', 'Aptitud', 'H'),
(73, '�Est�s de acuerdo con la formaci�n de un cuerpo de soldados profesionales?', 'Inter�s', 'D'),
(74, '�Luchar�as por una causa justa hasta las �ltimas consecuencias?', 'Inter�s', 'D'),
(75, '�Te gustar�a investigar cient�ficamente sobre cultivos agr�colas?', 'Inter�s', 'E'),
(76, '�Har�as un nuevo dise�o de una prenda pasada de moda, ante una reuni�n?', 'Aptitud', 'A'),
(77, '�Visitar�as un observatorio astron�mico para conocer en acci�n el funcionamiento de los aparatos?', 'Inter�s', 'E'),
(78, '�Dirigir�as el �rea de importaci�n y exportaci�n de una empresa?', 'Inter�s', 'C'),
(79, '�Te coh�bes/inhibes �cortas- al entrar a un lugar nuevo con gente desconocida?', 'Aptitud', 'E'),
(80, '�Te gratificar�a el trabajar con ni�os?', 'Inter�s', 'H'),
(81, '�Har�as el dise�o de un cartel o afiche para una campa�a contra el sida?', 'Inter�s', 'A'),
(82, '�Dirigir�as un grupo de teatro independiente?', 'Aptitud', 'A'),
(83, '�Enviar�as tu curriculum a una empresa automotriz que solicita gerente para su �rea de producci�n?', 'Inter�s', 'I'),
(84, '�Participar�as en un grupo de defensa internacional dentro de alguna fuerza armada?', 'Inter�s', 'D'),
(85, '�Te costear�as tus estudios trabajando en una auditor�a �revisi�n de las cuentas-?', 'Inter�s', 'C'),
(86, '�Eres de los que defiendes causas perdidas?', 'Aptitud', 'H'),
(87, '�Ante una emergencia epid�mica participar�as en una campa�a brindando tu ayuda?', 'Inter�s', 'S'),
(88, '�Sabr�as responder que significa ADN o ARN?', 'Inter�s', 'E'),
(89, '�Elegir�as una carrera cuyo instrumento de trabajo fuere la utilizaci�n de un idioma extranjero?', 'Inter�s', 'H'),
(90, '�Trabajar con objetos, m�quinas, te resulta m�s gratificante que trabajar con personas?', 'Aptitud', 'I'),
(91, '�Te resultar�a gratificante ser asesor contable en una empresa reconocida?', 'Inter�s', 'C'),
(92, '�Ante un llamado solidario, te ofrecer�as para cuidar a un enfermo?', 'Inter�s', 'S'),
(93, '�Te atrae investigar sobre los misterios del universo, por ejemplo los agujeros negros?', 'Inter�s', 'E'),
(94, '�El trabajo individual te resulta m�s r�pido y efectivo que el trabajo grupal?', 'Aptitud', 'I'),
(95, '�Dedicar�as parte de tu tiempo a ayudar a personas con carencias o necesitadas?', 'Inter�s', 'S'),
(96, '�Cuando eliges tu ropa o decoras un ambiente, tienes en cuenta la combinaci�n de los colores, las telas o el estilo de los muebles?', 'Inter�s', 'A'),
(97, '�Te gustar�a trabajar como profesional dirigiendo la construcci�n de una empresa hidroel�ctrica?', 'Inter�s', 'E'),
(98, '�Sabes qu� es el PIB? Se trata de un concepto econ�mico. �Te gusta este tipo de tema?', 'Inter�s', 'C');

