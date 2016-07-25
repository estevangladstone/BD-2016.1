--
-- Database: `trabalho`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `Escola`
--

CREATE TABLE `Escola` (
  `id` int(11) NOT NULL,
  `rede` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `municipio_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Estado`
--

CREATE TABLE `Estado` (
  `uf` varchar(255) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `regiao` varchar(255) DEFAULT NULL,
  `bandeira` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Municipio`
--

CREATE TABLE `Municipio` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `populacao` int(11) DEFAULT NULL,
  `estado_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Taxa`
--

CREATE TABLE `Taxa` (
  `id` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `serie` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `escola_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Telefone`
--

CREATE TABLE `Telefone` (
  `id` int(11) NOT NULL,
  `codigo` int(11) DEFAULT NULL,
  `numero` int(11) DEFAULT NULL,
  `escola_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `TerceirizadaEscola`
--

CREATE TABLE `TerceirizadaEscola` (
  `escola_id` int(11) NOT NULL,
  `terceirizada_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Terceirizada`
--

CREATE TABLE `Terceirizada` (
  `id` int(11) NOT NULL,
  `tipo_servico` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Escola`
--
ALTER TABLE `Escola`
  ADD PRIMARY KEY (`id`),
  ADD KEY `municipio_id` (`municipio_id`);

--
-- Indexes for table `Estado`
--
ALTER TABLE `Estado`
  ADD PRIMARY KEY (`uf`);

--
-- Indexes for table `Municipio`
--
ALTER TABLE `Municipio`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indexes for table `Taxa`
--
ALTER TABLE `Taxa`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Telefone`
--
ALTER TABLE `Telefone`
  ADD PRIMARY KEY (`id`),
  ADD KEY `escola_id` (`escola_id`);

--
-- Indexes for table `TerceirizadaEscola`
--
ALTER TABLE `TerceirizadaEscola`
  ADD PRIMARY KEY (`terceirizada_id`,`escola_id`),
  ADD KEY `escola_id` (`escola_id`);

--
-- Indexes for table `Terceirizada`
--
ALTER TABLE `Terceirizada`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

ALTER TABLE `Taxa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
ALTER TABLE `Terceirizada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
ALTER TABLE `Telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `Escola`
--
ALTER TABLE `Escola`
  ADD CONSTRAINT `Escola_ibfk_1` FOREIGN KEY (`municipio_id`) REFERENCES `Municipio` (`id`);

--
-- Limitadores para a tabela `Municipio`
--
ALTER TABLE `Municipio`
  ADD CONSTRAINT `Municipio_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `Estado` (`uf`);

--
-- Limitadores para a tabela `Telefone`
--
ALTER TABLE `Telefone`
  ADD CONSTRAINT `Telefone_ibfk_1` FOREIGN KEY (`escola_id`) REFERENCES `Escola` (`id`);

--
-- Limitadores para a tabela `TerceirizadaEscola`
--
ALTER TABLE `TerceirizadaEscola`
  ADD CONSTRAINT `terceirizadaescola_ibfk_1` FOREIGN KEY (`terceirizada_id`) REFERENCES `Terceirizada` (`id`),
  ADD CONSTRAINT `terceirizadaescola_ibfk_2` FOREIGN KEY (`escola_id`) REFERENCES `Escola` (`id`);
