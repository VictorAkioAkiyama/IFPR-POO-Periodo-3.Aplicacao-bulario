DROP SCHEMA IF EXISTS bularioapp_db;
CREATE SCHEMA bularioapp_db;
USE bularioapp_db;

DROP USER IF EXISTS 'appuser'@'localhost';
CREATE USER 'appuser'@'localhost' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON *.* TO 'appuser'@'localhost' WITH GRANT OPTION;
FLUSH PRIVILEGES;

CREATE TABLE PRESCRICOES
(
 ID_PRESCRICAO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 RESTRICAO VARCHAR(250) NOT NULL,  
 CONTRA_INDICACOES VARCHAR(2000) NOT NULL, 
 EFEITOS VARCHAR(1000) NOT NULL,
 VALIDADE VARCHAR(250) NOT NULL,
 CONSERVACAO VARCHAR(250) NOT NULL
);
CREATE TABLE SUBSTANCIAS
(
 ID_SUBSTANCIA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 NOME VARCHAR(200) NOT NULL,
 TIPO VARCHAR(100) NOT NULL
 );
 
 CREATE TABLE PUBLICO_ALVO (
    ID_PUBLICO_ALVO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(50) NOT NULL
);

CREATE TABLE TARJAS (
    ID_TARJA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    NOME VARCHAR(30) NOT NULL
);

CREATE TABLE CIDADES
(
 ID_CIDADE INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 NOME VARCHAR(200) NOT NULL,
 UF CHAR(2)
);

CREATE TABLE EMPRESAS
(
 ID_EMPRESA INT NOT NULL PRIMARY KEY AUTO_INCREMENT,  
 NOME VARCHAR(100) NOT NULL,  
 CNPJ CHAR(14) UNIQUE,
 ID_CIDADE INT,
 FOREIGN KEY (ID_CIDADE) REFERENCES CIDADES(ID_CIDADE)
);

CREATE TABLE REMEDIOS
(
 ID_REMEDIO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
 NOME VARCHAR(100) NOT NULL,
 BULA VARCHAR(255) NOT NULL, -- a bula será uma URL, porque BLOB fica muito pesado
 TIPO VARCHAR(20) NOT NULL,
 ID_PRESCRICAO INT,
 ID_TARJA INT,
 ID_SUBSTANCIA INT,
 ID_EMPRESA INT,
 FOREIGN KEY (ID_PRESCRICAO) REFERENCES PRESCRICOES(ID_PRESCRICAO),
 FOREIGN KEY (ID_TARJA) REFERENCES TARJAS(ID_TARJA),
 FOREIGN KEY (ID_SUBSTANCIA) REFERENCES SUBSTANCIAS(ID_SUBSTANCIA),
 FOREIGN KEY (ID_EMPRESA) REFERENCES EMPRESAS(ID_EMPRESA)
);

CREATE TABLE REMEDIOS_PUBLICO_ALVO (
    ID_REMEDIO_PUBLICO INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ID_REMEDIO INT NOT NULL,
    ID_PUBLICO_ALVO INT NOT NULL,
    FOREIGN KEY (ID_REMEDIO) REFERENCES REMEDIOS(ID_REMEDIO) ON DELETE CASCADE,
    FOREIGN KEY (ID_PUBLICO_ALVO) REFERENCES PUBLICO_ALVO(ID_PUBLICO_ALVO) ON DELETE CASCADE,
    UNIQUE (ID_REMEDIO, ID_PUBLICO_ALVO)
);

INSERT INTO TARJAS (NOME) VALUES
('Sem tarja'),
('Vermelha'),
('Preta');

INSERT INTO PUBLICO_ALVO (NOME) VALUES
('Crianças'),
('Adultos'),
('Idosos'),
('Gestantes');

INSERT INTO PRESCRICOES(RESTRICAO, CONTRA_INDICACOES, EFEITOS, VALIDADE, CONSERVACAO) VALUES 
	("Venda sob prescrição médica com retenção de receita", "Este medicamento não pode ser usado por pessoas alérgicas à amoxicilina, 
    a outros antibióticos penicilínicos ou antibióticos similares, chamados cefalosporinas. Se você já teve uma reação alérgica 
    (como erupções da pele) ao tomar um antibiótico, deve conversar com seu médico antes de usar amoxicilina. Este medicamento 
    não deve ser usado por pessoas com síndrome de má-absorção de glicose-galactose e/ou com insuficiência de sacarose-isomaltase.",
    "Amoxicilina, um antibiótico eficaz contra grande variedade de bactérias, é indicado para tratamento de infecções bacterianas 
    causadas por germes sensíveis à ação da amoxicilina. Entretanto, seu médico pode receitar este medicamento para outro uso. 
    Se desejar mais informações, pergunte ao seu médico. ", "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM 
    TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
	("Venda sem Prescrição Médica", "Você não deve tomar paracetamol Gotas se tiver alergia ao paracetamol ou a qualquer outro 
    componente de sua fórmula.", "paracetamol Gotas reduz a febre atuando no centro regulador da temperatura no Sistema Nervoso 
    Central (SNC) e diminui a sensibilidade para a dor. Seu efeito tem início 15 a 30 minutos após a administração oral e permanece 
    por um período de 4 a 6 horas.", "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC)
	PROTEGER DA LUZ E UMIDADE"),
    ("Venda sem Prescrição Médica", "Se você alguma vez já apresentou reação alérgica ao alprazolam, a outros benzodiazepínicos, 
    ou a qualquer componente da fórmula do produto, não use este medicamento. O alprazolam também não deve ser usado caso você tenha
    miastenia gravis (uma doença de nervos e músculos que resulta em fraqueza muscular) ou glaucoma de ângulo estreito agudo 
    (aumento da pressão dentro dos olhos). Este medicamento é contraindicado para menores de 18 anos de idade. Este medicamento 
    não deve ser usado por pessoas com síndrome de má-absorção de glicose-galactose.", "alprazolam é um medicamento que causa uma 
    diminuição em várias funções do sistema nervoso central, que pode ir desde um comprometimento leve dos reflexos e desempenho 
    diário até o sono provocado ou quadro de sedação.", "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA 
    ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob prescrição médica com retenção de receita", "A ampicilina é contraindicada para pacientes com história de reações 
    de hipersensibilidade (alergia) às penicilinas (classe de antibióticos onde a ampicilina se enquadra) e/ou demais componentes
    da formulação. Também não deve ser administrado a pacientes sensíveis às cefalosporinas (outra classe de antibióticos) devido 
    à ocorrência de reação alérgica cruzada.", "A ampicilina é um antibiótico derivado das penicilinas que provoca a morte dos 
    microrganismos sensíveis. Sua ação inicia-se minutos após a administração de uma dose, mantendo-se adequada por 6 horas ou mais. 
    A ampicilina está indicada no tratamento de diversas infecções causadas por microrganismos sensíveis a este medicamento.", 
    "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob Prescrição Médica", "Contraindicado a pacientes que apresentam hipersensibilidade ao ibuprofeno, a qualquer
	componente da fórmula ou a outros anti-inflamatórios não esteroides (AINEs) tais como ácido acetilsalicílico, nimesulida e 
    diclofenaco sódico. Existe potencial de sensibilidade cruzada com ácido acetilsalicílico e outros AINEs. Contraindicado também 
    para pacientes que apresentam a tríade do ácido acetilsalicílico (asma brônquica, rinite e intolerância ao ácido acetilsalicílico). 
    Nesses pacientes foram registradas reações anafilactóides e reações asmáticas fatais. No tratamento da dor perioperatória de 
    cirurgia de revascularização do miocárdio (by-pass). Em pacientes com insuficiência renal grave. Em pacientes com insuficiência 
    hepática grave. Em pacientes com insuficiência cardíaca grave. Este medicamento não deve ser utilizado por mulheres grávidas sem 
    orientação médica ou do cirurgião-dentista. Informe imediatamente seu médico em caso de suspeita de gravidez. Este medicamento é 
    contraindicado durante o terceiro trimestre de gravidez. Este medicamento é contraindicado em caso de suspeita de dengue, pois 
    pode aumentar o risco de sangramentos. Não use este medicamento caso tenha problemas no estômago. Não tome este medicamento por 
    período maior do que está recomendado na bula ou recomendado pelo médico, pois pode causar problemas nos rins, estômago, intestino, 
    coração e vasos sanguíneos.", "Medicamento com ação anti-inflamatória, analgésica e antipirética", "24 meses", 
    "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob Prescrição Médica", "Não use piroxicam se: (1) já apresentou úlcera gastrointestinal (ferida no estômago e/ou na parte 
    inicial do intestino), hemorragia ou perfuração gastrintestinal (no estômago e intestino observados através de sangue vivo ou 
    “pisado” – com coloração marrom escura - no vômito e/ou fezes); (2) apresenta úlcera péptica ativa (ferida atual no estômago e/ou 
    na parte inicial do intestino); (3) apresenta hipersensibilidade (alergia) conhecida ao piroxicam ou a outros componentes da fórmula. 
    (4) usando ácido acetilsalicílico ou outro anti-inflamatório não hormonal (que não é derivado de hormônio) e desenvolveram sintomas 
    de asma (doença respiratória onde a respiração é difícil, curta e ofegante), pólipo nasal (massa de tecido mucoso dentro do nariz), 
    angioedema (inchaço das partes mais profundas da pele ou da mucosa, geralmente de origem alérgica) ou urticária (alergia da pele); 
    (5) para tratar a dor da cirurgia para revascularização do miocárdio (cirurgia que corrige obstruções das coronárias – vasos que 
    levam sangue para o músculo do coração – através de ponte de veia safena ou de artéria mamária); (6) insuficiência renal 
    (diminuição da função dos rins), hepática (diminuição da função do fígado) ou cardíaca (diminuição da capacidade de bombeamento 
    do coração) graves.", "O piroxicam é um anti-inflamatório não esteroide (AINE, medicamento que bloqueia a inflamação e que não é 
    derivado de hormônios) que possui também propriedades analgésicas (que reduz ou elimina a dor) e antipiréticas (reduz a febre).",
    "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob Prescrição Médica", "Este medicamento não deve ser usado por pessoas alérgicas a qualquer um dos componentes da fórmula.
    Este medicamento é contraindicado para uso por mulheres e crianças. Este medicamento não deve ser utilizado por mulheres grávidas 
    ou que possam ficar grávidas durante o tratamento. A doação de sangue é contraindicada durante o tratamento com finasterida e até 
    1 mês após o seu término, devido ao dano que ele pode causar à pessoa que receber o sangue.", "No couro cabeludo, a finasterida reduz 
    especificamente os níveis de di-hidrotestosterona (DHT), a causa principal de queda de cabelo de padrão masculino. Desta maneira, a 
    finasterida ajuda a reverter o processo da calvície, levando ao aumento do crescimento capilar e à prevenção de perdas adicionais de cabelo.", 
    "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob prescrição médica com retenção de receita", "A azitromicina di-hidratada é contraindicada se você tem hipersensibilidade 
    (reações alérgicas) à azitromicina, à eritromicina, a qualquer antibiótico macrolídeo (classe de antibióticos a qual pertence a azitromicina), 
    cetolídeo (como telitromicina e cetromicina) ou a qualquer componente da fórmula.", "A azitromicina di-hidratada é um antibiótico que age 
    impedindo que as bactérias sensíveis à azitromicina produzam proteínas, que são a base do seu crescimento e reprodução. Não é conhecido 
    o tempo exato do início de ação por administração oral ou intravenosa (dentro da veia).", "24 meses", 
    "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sob prescrição médica com retenção de receita", "Não use Teucipharm nas seguintes situações: alergia (hipersensibilidade) à substância 
    ativa ciprofloxacino, aos medicamentos contendo outro derivado quinolônico ou a qualquer componente da fórmula (veja o item “Composição”). 
    Sinais de alergia podem incluir coceira, vermelhidão na pele, dificuldade para respirar ou inchaço das mãos, garganta, boca ou pálpebra;
	Uso concomitante de tizanidina (um relaxante muscular) porque isso pode causar efeitos adversos como queda da pressão arterial e sonolência.", 
    "O ciprofloxacino, componente ativo de Teucipharm, pertence ao grupo das fluoroquinolonas. As fluoroquinolonas bloqueiam determinadas enzimas 
    de bactérias que têm um papel fundamental no metabolismo e na reprodução bacteriana, matando as bactérias causadoras da doença.", "24 meses", 
    "CONSERVAR EM TEMPERATURA AMBIENTE ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE"),
    ("Venda sem Prescrição Médica", "Contraindicado para uso por pacientes alérgicos à guaifenesina ou aos demais componentes do medicamento.
	A guaifenesina é considerada insegura para pacientes com porfiria, pois apresentou-se porfirogênica em animais. Este medicamento é 
    contraindicado para menores de 2 anos de idade.", "Xarope Resolvtosse é um expectorante que ajuda na eliminação do catarro em tosses produtivas. 
    A guaifenesina fluidifica o catarro, tornando-o menos viscoso e mais “solto”. Dessa forma, o catarro é expelido de maneira mais fácil.
	O início da ação é rápido e em 1 hora pode-se sentir o efeito da eliminação do catarro.", "24 meses", "CONSERVAR EM TEMPERATURA AMBIENTE 
    ( AMBIENTE COM TEMPERATURA ENTRE 15 E 30ºC) PROTEGER DA LUZ E UMIDADE");

INSERT INTO SUBSTANCIAS (NOME, TIPO) VALUES 
	("Amoxicilina", "Semi-sintético"),
	("Paracetamol", "Sintético"),
    ("Alprazolam", "Sintético"),
    ("Ampicilina", "Semi-sintético"),
    ("Ibuprofeno", "Sintético"), 
    ("Piroxicam", "Sintético"),
    ("Finasterida", "Sintético"),
    ("Azitromicina di-hidratada", "Semi-sintético"),
    ("Cloridrato de ciprofloxacino monoidratado", "Sintético"),
    ("Guaifenesina", "Sintético");

INSERT INTO CIDADES(NOME, UF) VALUES
	("Londrina", "PR"), ("Maringá", "PR"), ("Cambé", "PR"), ("Washington", null), ("Curitiba", "PR"),
    ("São Paulo", "SP"), ("Rio de Janeiro", "RJ"), ("Porto Alegre", "RS"), ("Buenos Aires", null), ("Salvador", "BA");

INSERT INTO EMPRESAS(NOME, CNPJ, ID_CIDADE) VALUES
    ("Nova Farmácia", "12345678901234", 1),
    ("New Pharmacy", null, 4),
    ("Nova Farmácia 2", "12345678901231", 2),
    ("IndustriFarma", "234567890123", 3),
    ("CantoFarma", "34568901234", 5),
    ("IndustriLab", "45679012345", 6),
    ("LaboratorioFarma", "567890123456", 7),
    ("Novo Laboratorio", "678901234567", 8),
    ("Nueva Industria Farma", null, 9),
    ("LabFarma", "789012345678", 10);

INSERT INTO REMEDIOS(NOME, BULA, TIPO, ID_PRESCRICAO, ID_TARJA, ID_SUBSTANCIA, ID_EMPRESA) VALUES 
	("Amoxicilina", "C:/Bulario/PDF_Remedios/Amoxicilina_0001.pdf", "G", "1", "2", "1", "1"),
	("Paracetamol", "C:/Bulario/PDF_Remedios/Paracetamol_0001.pdf", "G", "2", "1", "2", "2"),
    ("Alprazolam", "C:/Bulario/PDF_Remedios/Alprazolam_0001.pdf", "G", "3", "2", "3", "3"),
    ("Ampicilina", "C:/Bulario/PDF_Remedios/Ampicilina_0001.pdf", "G", "4", "2", "4", "4"),
    ("Ibuprofeno", "C:/Bulario/PDF_Remedios/Ibuprofeno_0001.pdf", "G", "5", "2", "5", "5"),
    ("Piroxicam", "C:/Bulario/PDF_Remedios/Piroxicam_0001.pdf", "G", "6", "2", "6", "6"),
    ("Finasterida", "C:/Bulario/PDF_Remedios/Finasterida_0001.pdf", "G", "7", "2", "7", "7"),
    ("Azitromicina di-hidratada", "C:/Bulario/PDF_Remedios/AzitromicinaDi-hidratada_0001.pdf", "G", "8", "2", "8", "8"),
    ("TEUCIPHARM", "C:/Bulario/PDF_Remedios/Teucipharm_0001.pdf", "S", "9", "2", "9", "9"),
    ("XAROPE RESOLVTOSSE", "C:/Bulario/PDF_Remedios/XaropeResolvtosse_0001.pdf", "S", "10", "1", "10", "10");

INSERT INTO REMEDIOS_PUBLICO_ALVO(ID_REMEDIO, ID_PUBLICO_ALVO) VALUES
	(1, 2), (2, 1), (3, 2), (3, 1), (4, 2), (5, 2), (6, 2), (7, 2), (8, 2), (9, 2), (10, 1), (10, 2), (10, 3);
