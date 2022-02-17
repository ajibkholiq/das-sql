-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Waktu pembuatan: 26 Jan 2022 pada 12.23
-- Versi server: 10.4.21-MariaDB
-- Versi PHP: 7.4.24

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_dassubang`
--

DELIMITER $$
--
-- Prosedur
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `alih_fungsi` (`kd_desa` CHAR(15), `kd_sungai` CHAR(10), `kd_lhn` CHAR(10), `stts` VARCHAR(20))  begin update rekap_jns_lhn set  kode_lhn =kd_lhn,status=stts where kode_des = kd_desa and kode_sungai =kd_sungai; end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `input_ank_sngai` (`kd_indk` CHAR(6), `nm` VARCHAR(20))  begin insert into anak_sungai (kode,nama) values (kd_indk,nm); 
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `input_jns_lhn` (`kode` CHAR(10), `nm` CHAR(20))  begin insert into jenis_lahan (kode ,nama) values (kode,nm);end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `input_rkp_lahan` (`kd1` CHAR(10), `kd2` CHAR(10), `kd3` CHAR(10), `sts` CHAR(30))  begin  insert into rekap_jns_lhn (kode_lhn,kode_des,kode_sungai,status) values (kd1,kd2,kd3,sts);end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `input_sungai` (`kd_indk` CHAR(6), `nm` VARCHAR(20), `smbr` VARCHAR(20), `hilir` VARCHAR(20), `pnjng` VARCHAR(10))  begin insert into sungai (kode,nama,sumber,muara,panjang) values (kd_indk,nm,smbr,hilir,pnjng);end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `jumlah_anak_sungai` (`nama_induk` VARCHAR(20), OUT `param` INT(2))  begin select count(anak_sungai.nama) into param  from anak_sungai,sungai where sungai.nama = nama_induk and sungai.kode =anak_sungai.kode ;end$$

--
-- Fungsi
--
CREATE DEFINER=`root`@`localhost` FUNCTION `jumdes_brdsr_kec_sungai` (`nm_sg` CHAR(15), `nm_kec` CHAR(15)) RETURNS INT(11) begin declare jmlh int; select count(desa.nama) into jmlh from sungai, desa, rekap_jns_lhn, kecamatan where sungai.kode = rekap_jns_lhn.kode_sungai and desa.kode_des = rekap_jns_lhn.kode_des and desa.kode_kec = kecamatan.kode_kemdagri and sungai.nama = nm_sg and kecamatan.nama = nm_kec; return jmlh ; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumdes_lahan` (`nm` CHAR(20)) RETURNS INT(11) begin declare jumlah int; select count(rekap_jns_lhn.kode_lhn) into jumlah from rekap_jns_lhn,jenis_lahan where jenis_lahan.kode=rekap_jns_lhn.kode_lhn and jenis_lahan.nama = nm; return  jumlah ; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumdes_lahan_perkec` (`nm_kec` CHAR(20), `nm_lhn` CHAR(20)) RETURNS INT(11) begin declare jumlah int; select count(rekap_jns_lhn.kode_lhn) into jumlah from kecamatan,desa,rekap_jns_lhn,jenis_lahan where desa.kode_des =rekap_jns_lhn.kode_des and jenis_lahan.kode=rekap_jns_lhn.kode_lhn and kecamatan.kode_kemdagri = desa.kode_kec and jenis_lahan.nama = nm_lhn and kecamatan.nama = nm_kec; return  jumlah ; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumdes_skitr_sungai` (`nm_sgi` CHAR(10)) RETURNS INT(11) begin declare jumlah int ; select count( desa.kode_des ) into jumlah from desa,rekap_jns_lhn, sungai where desa.kode_des = rekap_jns_lhn.kode_des and rekap_jns_lhn.kode_sungai = sungai.kode and sungai.nama=nm_sgi ; return jumlah; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumdes_sktrsungai` (`nm` CHAR(20)) RETURNS INT(11) begin declare jumlah int; select count(desa.nama) into jumlah from desa,sungai,rekap_jns_lhn where desa.kode_des=rekap_jns_lhn.kode_des and rekap_jns_lhn.kode_sungai = sungai.kode and sungai.nama = nm; return  jumlah ; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumkec_persungai` (`nm_sg` CHAR(15)) RETURNS INT(11) begin declare jmlh int; select count(distinct kecamatan.nama) into jmlh from sungai, desa, rekap_jns_lhn, kecamatan where sungai.kode = rekap_jns_lhn.kode_sungai and desa.kode_des = rekap_jns_lhn.kode_des and desa.kode_kec = kecamatan.kode_kemdagri and sungai.nama = nm_sg ; return jmlh; end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `jumlah_anak_sungai` (`nm` CHAR(20)) RETURNS INT(3) begin declare jumlah int; select count(anak_sungai.nama) into jumlah  from sungai, anak_sungai where sungai.kode= anak_sungai.kode and sungai.nama = nm ; return jumlah; end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `anak_sungai`
--

CREATE TABLE `anak_sungai` (
  `kode` char(6) DEFAULT NULL,
  `nama` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `anak_sungai`
--

INSERT INTO `anak_sungai` (`kode`, `nama`) VALUES
('CPNGR', 'Sungai Cikandung'),
('CPNGR', 'Sungai Cikandung'),
('CLMY', 'Sungai Ciwaru'),
('CPNGR', 'Sungai Cigadung'),
('CLMY', 'Sungai Cilandak'),
('CPNGR', 'Sungai Cilamatan'),
('CLMY', 'Sungai Cihuni'),
('CPNGR', 'Sungai Cikaramas'),
('CLMY', 'Sungai Cikeruh'),
('CPNGR', 'Sungai Cileat'),
('CLMY', 'Sungai Cijengkol'),
('CPNGR', 'Sungai Ciburung'),
('CLMY', 'Sungai Cihalang'),
('CPNGR', 'Sungai Cicanang'),
('CLMY', 'Sungai Cijalu'),
('CASM', 'Ci Reundeu'),
('CLMY', 'SUngai Cilemper'),
('CASM', 'Ci Koneng'),
('CASM', 'Ci Juhung'),
('CASM', 'Ci Barubus'),
('CASM', 'Ci Bodas'),
('CASM', 'Ci Nangka'),
('CASM', 'Ci Jengkol'),
('CASM', 'Ci Mahpar');

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `data_anak_sungai`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `data_anak_sungai` (
`anak sungai` varchar(20)
,`induk sungai` varchar(20)
);

-- --------------------------------------------------------

--
-- Stand-in struktur untuk tampilan `data_sungai`
-- (Lihat di bawah untuk tampilan aktual)
--
CREATE TABLE `data_sungai` (
`nama sungai` varchar(20)
,`jenis lahan` varchar(20)
,`nama desa` varchar(20)
,`nama` varchar(20)
);

-- --------------------------------------------------------

--
-- Struktur dari tabel `desa`
--

CREATE TABLE `desa` (
  `kode_des` char(15) NOT NULL,
  `kode_kec` char(10) DEFAULT NULL,
  `nama` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `desa`
--

INSERT INTO `desa` (`kode_des`, `kode_kec`, `nama`) VALUES
('32.13.02.2003', '32.13.02', 'gardusayang'),
('32.13.02.2004', '32.13.02', 'mayang'),
('32.13.02.2007', '32.13.02', 'Darmaga'),
('32.13.02.2008', '32.13.02', 'cisalak'),
('32.13.10.2008', '32.13.10', 'patimban'),
('32.13.10.2015', '32.13.10', 'Mundusari'),
('32.13.11.2003', '32.13.11', 'Rancahilir'),
('32.13.11.2004', '32.13.11', 'pamanukan'),
('32.13.11.2011', '32.13.11', 'Bongas'),
('32.13.14.2006', '32.13.14', 'Cibuluh'),
('32.13.14.2010', '32.13.14', 'Gandasoli'),
('32.13.15.2007', '32.13.15', 'kiarasari'),
('32.13.17.2001', '32.13.17', 'Sumurbarang'),
('32.13.17.2005', '32.13.17', 'Sadawarna'),
('32.13.17.2009', '32.13.17', 'Cibalandong jaya'),
('32.13.18.2003', '32.13.18', 'Tanjung'),
('32.13.18.2007', '32.13.18', 'sidajaya'),
('32.13.21.2002', '32.13.21', 'bobos'),
('32.13.21.2006', '32.13.21', 'pangaregan'),
('32.13.21.2007', '32.13.21', 'Karangmulya'),
('32.13.26.2002', '32.13.26', 'Pasangrahan'),
('32.13.30.2004', '32.13.30', 'Bojongtengah');

-- --------------------------------------------------------

--
-- Struktur dari tabel `jenis_lahan`
--

CREATE TABLE `jenis_lahan` (
  `kode` char(6) NOT NULL,
  `nama` varchar(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `jenis_lahan`
--

INSERT INTO `jenis_lahan` (`kode`, `nama`) VALUES
('HTN', 'hutan'),
('KBN', 'kebun'),
('PBRK', 'pabrik'),
('PMKN', 'pemukiman'),
('SWH', 'pesawahan');

-- --------------------------------------------------------

--
-- Struktur dari tabel `kecamatan`
--

CREATE TABLE `kecamatan` (
  `kode_kemdagri` char(10) NOT NULL,
  `nama` varchar(20) DEFAULT NULL,
  `jumlah_desa` int(2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `kecamatan`
--

INSERT INTO `kecamatan` (`kode_kemdagri`, `nama`, `jumlah_desa`) VALUES
('32.13.02', 'Cisalak', 9),
('32.13.10', 'pusakanagara', 7),
('32.13.11', 'Pamanukan', 8),
('32.13.14', 'Tanjungsiang', 10),
('32.13.15', 'Compreng', 8),
('32.13.17', 'Cibogo', 9),
('32.13.18', 'Cipunagara', 10),
('32.13.21', 'Legon kulon', 7),
('32.13.26', 'Kasomalang', 8),
('32.13.30', 'Pusakajaya', 8);

-- --------------------------------------------------------

--
-- Struktur dari tabel `log_alihfunsi_lahan`
--

CREATE TABLE `log_alihfunsi_lahan` (
  `kode_desa` char(15) DEFAULT NULL,
  `kode_sungai` char(10) DEFAULT NULL,
  `kode_lahan` char(10) DEFAULT NULL,
  `status` char(20) DEFAULT NULL,
  `kode_lahan_baru` char(10) DEFAULT NULL,
  `tgl` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `log_alihfunsi_lahan`
--

INSERT INTO `log_alihfunsi_lahan` (`kode_desa`, `kode_sungai`, `kode_lahan`, `status`, `kode_lahan_baru`, `tgl`) VALUES
('32.13.10.2015', 'CPNGR', 'SWH', 'Milik UMUM', 'PMKN', '2022-01-26');

-- --------------------------------------------------------

--
-- Struktur dari tabel `rekap_jns_lhn`
--

CREATE TABLE `rekap_jns_lhn` (
  `kode_lhn` char(6) DEFAULT NULL,
  `kode_des` char(15) DEFAULT NULL,
  `kode_sungai` char(10) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `rekap_jns_lhn`
--

INSERT INTO `rekap_jns_lhn` (`kode_lhn`, `kode_des`, `kode_sungai`, `status`) VALUES
('HTN', '32.13.26.2002', 'CPNGR', 'Milik rakyat'),
('HTN', '32.13.02.2007', 'CPNGR', 'Milik rakyat'),
('HTN', '32.13.14.2006', 'CPNGR', 'Milik rakyat'),
('HTN', '32.13.14.2010', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.17.2009', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.17.2005', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.17.2001', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.18.2007', 'CPNGR', 'Milik rakyat'),
('KBN', '32.13.18.2007', 'CPNGR', 'Milik rakyat'),
('KBN', '32.13.18.2003', 'CPNGR', 'Milik rakyat'),
('PMKN', '32.13.15.2007', 'CPNGR', 'Milik umum'),
('SWH', '32.13.30.2004', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.11.2011', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.11.2003', 'CPNGR', 'Milik rakyat'),
('PMKN', '32.13.10.2015', 'CPNGR', 'Milik UMUM'),
('PMKN', '32.13.11.2004', 'CPNGR', 'Milik umum'),
('SWH', '32.13.21.2007', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.21.2002', 'CPNGR', 'Milik rakyat'),
('SWH', '32.13.21.2006', 'CPNGR', 'Milik rakyat'),
('HTN', '32.13.10.2008', 'CPNGR', 'pesisir');

--
-- Trigger `rekap_jns_lhn`
--
DELIMITER $$
CREATE TRIGGER `alih_fungsi` AFTER UPDATE ON `rekap_jns_lhn` FOR EACH ROW begin insert into log_alihfunsi_lahan values (old.kode_des,old.kode_sungai,old.kode_lhn,new.status,new.kode_lhn,now()); end
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struktur dari tabel `sungai`
--

CREATE TABLE `sungai` (
  `kode` char(6) NOT NULL,
  `nama` varchar(20) DEFAULT NULL,
  `sumber` varchar(20) DEFAULT NULL,
  `muara` varchar(20) DEFAULT NULL,
  `panjang` varchar(8) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data untuk tabel `sungai`
--

INSERT INTO `sungai` (`kode`, `nama`, `sumber`, `muara`, `panjang`) VALUES
('CASM', 'Ci asem', 'tangkuban parahu', 'Laut jawa', '60 Km'),
('CLMY', 'Ci lamaya', 'Gunung sunda', 'Laut jawa', '97 km'),
('CPNGR', 'Cipunegara', 'Gunung bukit tunggal', 'Laut jawa', '147,3 Km');

-- --------------------------------------------------------

--
-- Struktur untuk view `data_anak_sungai`
--
DROP TABLE IF EXISTS `data_anak_sungai`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `data_anak_sungai`  AS SELECT `anak_sungai`.`nama` AS `anak sungai`, `sungai`.`nama` AS `induk sungai` FROM (`sungai` join `anak_sungai`) WHERE `sungai`.`kode` = `anak_sungai`.`kode` ;

-- --------------------------------------------------------

--
-- Struktur untuk view `data_sungai`
--
DROP TABLE IF EXISTS `data_sungai`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `data_sungai`  AS SELECT `sungai`.`nama` AS `nama sungai`, `jenis_lahan`.`nama` AS `jenis lahan`, `desa`.`nama` AS `nama desa`, `kecamatan`.`nama` AS `nama` FROM ((((`desa` join `sungai`) join `jenis_lahan`) join `rekap_jns_lhn`) join `kecamatan`) WHERE `sungai`.`kode` = `rekap_jns_lhn`.`kode_sungai` AND `jenis_lahan`.`kode` = `rekap_jns_lhn`.`kode_lhn` AND `desa`.`kode_des` = `rekap_jns_lhn`.`kode_des` AND `kecamatan`.`kode_kemdagri` = `desa`.`kode_kec` ;

--
-- Indexes for dumped tables
--

--
-- Indeks untuk tabel `anak_sungai`
--
ALTER TABLE `anak_sungai`
  ADD KEY `fk_anksngi` (`kode`);

--
-- Indeks untuk tabel `desa`
--
ALTER TABLE `desa`
  ADD PRIMARY KEY (`kode_des`),
  ADD KEY `fk_kec` (`kode_kec`);

--
-- Indeks untuk tabel `jenis_lahan`
--
ALTER TABLE `jenis_lahan`
  ADD PRIMARY KEY (`kode`);

--
-- Indeks untuk tabel `kecamatan`
--
ALTER TABLE `kecamatan`
  ADD PRIMARY KEY (`kode_kemdagri`);

--
-- Indeks untuk tabel `rekap_jns_lhn`
--
ALTER TABLE `rekap_jns_lhn`
  ADD KEY `fk_lhn` (`kode_lhn`),
  ADD KEY `fk_des` (`kode_des`),
  ADD KEY `fk_sng` (`kode_sungai`);

--
-- Indeks untuk tabel `sungai`
--
ALTER TABLE `sungai`
  ADD PRIMARY KEY (`kode`);

--
-- Ketidakleluasaan untuk tabel pelimpahan (Dumped Tables)
--

--
-- Ketidakleluasaan untuk tabel `anak_sungai`
--
ALTER TABLE `anak_sungai`
  ADD CONSTRAINT `fk_anksngi` FOREIGN KEY (`kode`) REFERENCES `sungai` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `desa`
--
ALTER TABLE `desa`
  ADD CONSTRAINT `fk_kec` FOREIGN KEY (`kode_kec`) REFERENCES `kecamatan` (`kode_kemdagri`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Ketidakleluasaan untuk tabel `rekap_jns_lhn`
--
ALTER TABLE `rekap_jns_lhn`
  ADD CONSTRAINT `fk_des` FOREIGN KEY (`kode_des`) REFERENCES `desa` (`kode_des`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_lhn` FOREIGN KEY (`kode_lhn`) REFERENCES `jenis_lahan` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `fk_sng` FOREIGN KEY (`kode_sungai`) REFERENCES `sungai` (`kode`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
