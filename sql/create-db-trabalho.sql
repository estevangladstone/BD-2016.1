--
-- Database: `trabalho`
--

-- --------------------------------------------------------

--
-- Estrutura da tabela `Escolas`
--

CREATE TABLE `Escolas` (
  `id` int(11) NOT NULL,
  `rede` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `localizacao` varchar(255) DEFAULT NULL,
  `municipio_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Estados`
--

CREATE TABLE `Estados` (
  `uf` varchar(255) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `regiao` varchar(255) DEFAULT NULL,
  `bandeira` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Municipios`
--

CREATE TABLE `Municipios` (
  `id` int(11) NOT NULL,
  `nome` varchar(255) DEFAULT NULL,
  `populacao` int(11) DEFAULT NULL,
  `estado_id` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Taxas`
--

CREATE TABLE `Taxas` (
  `id` int(11) NOT NULL,
  `ano` int(11) DEFAULT NULL,
  `serie` varchar(255) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `tipo` varchar(255) DEFAULT NULL,
  `escola_id` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Telefones`
--

CREATE TABLE `Telefones` (
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
  `terceirazada_id` int(11) NOT NULL,
  `escola_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Estrutura da tabela `Terceirizadas`
--

CREATE TABLE `Terceirizadas` (
  `id` int(11) NOT NULL,
  `tipo_servico` varchar(255) DEFAULT NULL,
  `nome` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Escolas`
--
ALTER TABLE `Escolas`
  ADD PRIMARY KEY (`id`),
  ADD KEY `municipio_id` (`municipio_id`);

--
-- Indexes for table `Estados`
--
ALTER TABLE `Estados`
  ADD PRIMARY KEY (`uf`);

--
-- Indexes for table `Municipios`
--
ALTER TABLE `Municipios`
  ADD PRIMARY KEY (`id`),
  ADD KEY `estado_id` (`estado_id`);

--
-- Indexes for table `Taxas`
--
ALTER TABLE `Taxas`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `Telefones`
--
ALTER TABLE `Telefones`
  ADD PRIMARY KEY (`id`),
  ADD KEY `escola_id` (`escola_id`);

--
-- Indexes for table `TerceirizadaEscola`
--
ALTER TABLE `TerceirizadaEscola`
  ADD PRIMARY KEY (`terceirazada_id`,`escola_id`),
  ADD KEY `escola_id` (`escola_id`);

--
-- Indexes for table `Terceirizadas`
--
ALTER TABLE `Terceirizadas`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Taxas`
--
ALTER TABLE `Taxas`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=154417;
--
-- Constraints for dumped tables
--

--
-- Limitadores para a tabela `Escolas`
--
ALTER TABLE `Escolas`
  ADD CONSTRAINT `escolas_ibfk_1` FOREIGN KEY (`municipio_id`) REFERENCES `Municipios` (`id`);

--
-- Limitadores para a tabela `Municipios`
--
ALTER TABLE `Municipios`
  ADD CONSTRAINT `municipios_ibfk_1` FOREIGN KEY (`estado_id`) REFERENCES `Estados` (`uf`);

--
-- Limitadores para a tabela `Telefones`
--
ALTER TABLE `Telefones`
  ADD CONSTRAINT `telefones_ibfk_1` FOREIGN KEY (`escola_id`) REFERENCES `Escolas` (`id`);

--
-- Limitadores para a tabela `TerceirizadaEscola`
--
ALTER TABLE `TerceirizadaEscola`
  ADD CONSTRAINT `terceirizadaescola_ibfk_1` FOREIGN KEY (`terceirazada_id`) REFERENCES `Terceirizadas` (`id`),
  ADD CONSTRAINT `terceirizadaescola_ibfk_2` FOREIGN KEY (`escola_id`) REFERENCES `Escolas` (`id`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
