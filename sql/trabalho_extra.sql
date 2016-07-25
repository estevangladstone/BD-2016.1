
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
-- Indexes for table `Terceirizada`
--
ALTER TABLE `Terceirizada`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `TerceirizadaEscola`
--
ALTER TABLE `TerceirizadaEscola`
  ADD PRIMARY KEY (`terceirizada_id`,`escola_id`),
  ADD KEY `escola_id` (`escola_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `Taxa`
--
ALTER TABLE `Taxa`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=231625;
--
-- AUTO_INCREMENT for table `Telefone`
--
ALTER TABLE `Telefone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;
--
-- AUTO_INCREMENT for table `Terceirizada`
--
ALTER TABLE `Terceirizada`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1001;
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
