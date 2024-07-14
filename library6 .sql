-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jun 24, 2024 at 08:51 PM
-- Server version: 10.4.17-MariaDB
-- PHP Version: 8.0.2

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `library5`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `account_proc` (IN `acc_no_sp` INT, IN `acc_name` VARCHAR(50), IN `institution` VARCHAR(50), IN `balance` DECIMAL, IN `oper` VARCHAR(50))  begin
CASE
when oper='update' then
if exists(select * from account where acc_no=acc_no_sp) then
update account set acc_name=acc_name_sp, institution=institution, balance=balances where acc_no=acc_no_sp;
select 'updated success' as msg;
else
select concat(acc_no_sp,' this accounts number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from accounts where acc_no=acc_no_sp) then
delete from account where acc_no=acc_no_sp ;
select 'deleted success' as msg;
else
select concat(acc_no_sp,' this accounts number is not exist') as msg;
end if;

when oper='insert' then
if EXISTS(SELECT * from account WHERE balance<0) THEN
SELECT concat(balance,' wax kaweyn soogeli') as msg;
elseif EXISTS(SELECT * from account WHERE balance=0) THEN
SELECT concat(balance,'  wax kaweyn soogeli') as msg;
else
insert into account values(null, acc_name,institution,balance);
select 'inserted success' as msg;
end if;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `account_view` ()  BEGIN
SELECT acc_no,acc_name,institution,balance from account ORDER by acc_no asc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `address_proc` (IN `add_no_sp` INT, IN `district_sp` VARCHAR(50), IN `village_sp` VARCHAR(50), IN `zone_sp` VARCHAR(50), IN `oper` VARCHAR(50))  begin
CASE
when oper='update' then
if exists(select * from address where add_no=add_no_sp) then
update address set district=district_sp, village=village_sp, zone=zone_sp where add_no=add_no_sp;
select 'updated success' as msg;
else
select concat(add_no_sp, 'this address number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from address where add_no=add_no_sp) then
delete from address where add_no=add_no_sp ;
select 'deleted success' as msg;
else
select concat(add_no_sp,' this address number is not exist') as msg;
end if;

when oper='insert' then
if exists(select * from address where district=district_sp and village=village_sp and zone=zone_sp) then
select concat(district_sp,village_sp,zone_sp, ' already exists') as msg;
else
insert into address values(null, district_sp,village_sp,zone_sp);
select 'inserted success' as msg;
end if;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `address_view` ()  BEGIN
SELECT * from address_view;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `all_book` ()  BEGIN
SELECT book_no,cat_name,title 'book-name',auth_name 'magaca-qoraaga',ISB from books b,author a,catagories c WHERE b.cat_no=c.cat_no and b.auth_no=a.auth_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `amaah_proc` (IN `book_no_sp` INT, IN `id_sp` INT, IN `price` DECIMAL, IN `first_date_sp` DATE, IN `last_date_sp` DATE, IN `oper` VARCHAR(50), IN `am_no_sp` INT)  begin
CASE
when oper='update' then
if exists(select * from amaah where am_no=am_no_sp) then
update amaah set book_no=book_no_sp, id=id_sp, price=price_sp,first_date=first_date_sp,last_date=last_date_sp where am_no=am_no_sp;
select 'updated success' as msg;
else
select concat(acc_no_sp,' this amaah number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from amaah where am_no=am_no_sp) then
delete from amaah where am_no=am_no_sp ;
select 'deleted success' as msg;
else
select concat(am_no_sp,' this amaah number is not exist') as msg;
end if;

when oper='insert' then
insert into amaah values(null, book_no_sp,id_sp,price_sp,first_date_sp,last_date_sp);
select 'inserted success' as msg;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `Author_proc` (IN `id` INT, IN `magac` VARCHAR(50), IN `jinsi` ENUM('female','male'), IN `faahfahin` TEXT, IN `oper` VARCHAR(50))  BEGIN
  CASE oper
    WHEN 'delete' THEN
      IF EXISTS (SELECT auth_no FROM author WHERE auth_no = id) THEN
        IF EXISTS (SELECT auth_no FROM books WHERE auth_no = id) THEN
          SELECT CONCAT(auth_no, '  Outhors cannot be deleted as it is referenced by books.') AS msg FROM books WHERE auth_no = id;
        ELSE
          DELETE FROM author WHERE auth_no = id;
          SELECT 'Deleted successfully' AS msg;
        END IF;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN 'update' THEN
      IF EXISTS (SELECT auth_no FROM author WHERE auth_no = id) THEN
        UPDATE author SET auth_name = magac,sex = jinsi, description = faahfahin WHERE auth_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN 'insert' THEN
      IF EXISTS (SELECT * FROM author WHERE auth_name = magac AND sex=jinsi AND description = faahfahin) THEN
        SELECT CONCAT(auth_no, ' already exists') AS msg;
      ELSE
        INSERT INTO author (auth_name,sex, description) VALUES (magac,jinsi, faahfahin);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `author_view` ()  BEGIN
SELECT auth_no,auth_name,sex,Description FROM author ORDER by auth_no asc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `books_pro` (IN `id` INT, IN `catNo_pro` INT, IN `cinwan` VARCHAR(50), IN `ISB_pro` INT, IN `authNo_pro` INT, IN `faahfahin` TEXT, IN `oper` VARCHAR(50))  BEGIN
  CASE oper
    WHEN 'delete' THEN
      IF EXISTS (SELECT book_no FROM books WHERE book_no = id) THEN
        IF EXISTS (SELECT book_no FROM charges WHERE book_no = id) THEN
          SELECT CONCAT(book_no, '  this book cannot be deleted because of charge.') AS msg FROM charges WHERE book_no = id;
        ELSE
          DELETE FROM books WHERE book_no = id;
          SELECT 'Deleted successfully' AS msg;
        END IF;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN 'update' THEN
      IF EXISTS (SELECT book_no FROM books WHERE book_no = id) THEN
        UPDATE books SET cat_no = catNo_pro, title = cinwan, ISB = ISB_pro, auth_no = authNo_pro, description = faahfahin WHERE book_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN 'insert' THEN
      IF EXISTS (SELECT * FROM books WHERE cat_no = catNo_pro AND title = cinwan AND ISB = ISB_pro AND auth_no = authNo_pro AND description = faahfahin) THEN
        SELECT CONCAT(cinwan, ' already exists') AS msg;
      ELSE
        INSERT INTO books (cat_no, title, ISB, auth_no, description) VALUES (catNo_pro, cinwan, ISB_pro, authNo_pro, faahfahin);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `book_view` ()  BEGIN
SELECT book_no,cat_name,title,ISB,auth_name,b.Description from books b,catagories c,author a WHERE b.cat_no=c.cat_no and b.auth_no=a.auth_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `category_view` ()  BEGIN
SELECT cat_no,cat_name,Description from catagories;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `cat_pro` (IN `id` INT, IN `magac` VARCHAR(50), IN `fahfahin` TEXT, IN `oper` VARCHAR(50))  BEGIN
  CASE oper
    WHEN 'delete' THEN
      IF EXISTS (SELECT cat_no FROM catagories WHERE cat_no = id) THEN
        IF EXISTS (SELECT cat_no FROM books WHERE cat_no = id) THEN
          SELECT CONCAT(cat_no, '  Categories cannot be deleted as it is referenced by books.') AS msg FROM books WHERE cat_no = id;
        ELSE
          DELETE FROM catagories WHERE cat_no = id;
          SELECT 'Deleted successfully' AS msg;
        END IF;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN 'update' THEN
      IF EXISTS (SELECT cat_no FROM catagories WHERE cat_no = id) THEN
        UPDATE catagories SET cat_name = magac, description = fahfahin WHERE cat_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN 'insert' THEN
      IF EXISTS (SELECT * FROM catagories WHERE cat_name = magac AND description = fahfahin) THEN
        SELECT CONCAT(magac, ' already exists') AS msg;
      ELSE
        INSERT INTO catagories (cat_name, description) VALUES (magac, fahfahin);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `charges_pro` (IN `bookNo_pro` INT, IN `id_pro` INT, IN `amount_pro` DECIMAL, `dateCh_pro` DATE, IN `oper` VARCHAR(50), IN `id` INT)  BEGIN
  CASE oper
    WHEN 'delete' THEN
      IF EXISTS (SELECT ch_no FROM charges WHERE ch_no = id) THEN
        IF EXISTS (SELECT ch_no FROM receipt WHERE ch_no = id) THEN
          SELECT CONCAT(ch_no, '  this book cannot be deleted because of receipts.') AS msg FROM receipt WHERE ch_no = id;
        ELSE
          DELETE FROM charges WHERE ch_no = id;
          SELECT 'Deleted successfully' AS msg;
        END IF;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN 'update' THEN
      IF EXISTS (SELECT ch_no FROM charges WHERE ch_no = id) THEN
        UPDATE charges SET book_no = bookNo_pro, id = id_pro, amount = amount_pro, date_ch = dateCh_pro WHERE ch_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN 'insert' THEN
      IF EXISTS (SELECT * FROM charges WHERE book_no = bookNo_pro AND id = id_pro AND amount = amount_pro AND date_ch = dateCh_pro) THEN
        SELECT CONCAT(ch_no, ' already exists') AS msg;
      ELSE
        INSERT INTO charges (book_no, id, amount, date_ch) VALUES (bookNo_pro, id_pro, amount_pro, dateCh_pro);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dalaacad_view` ()  BEGIN
SELECT ch_no,name'magaca-qofka',title'book-name',q.price'qiimaha-buuga',wc.price 'weakly-charged',sum(q.price+wc.price)'Total',date_charge 'taariikhda-dalacad' from registration r,books b,qaadasho q,dalacaad d ,weeklly_charged wc WHERE q.id=r.id and q.book_no=b.book_no and d.am_no=q.am_no and d.week_no=wc.week_no GROUP by ch_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dalacaad1` (IN `am_no_pro` INT, IN `id` INT, IN `amount_pro` DECIMAL, IN `dateDal_pro` DATE, IN `oper` VARCHAR(50))  BEGIN
  DECLARE msg VARCHAR(100);

  IF oper = 'delete' THEN
    IF EXISTS (SELECT ch_no FROM dalacaad WHERE ch_no = id) THEN
      IF EXISTS (SELECT ch_no FROM qabasho WHERE ch_no = id) THEN
        SET msg = CONCAT(id, ' - This charge number cannot be deleted because of associated receipts or payments.');
      ELSE
        DELETE FROM dalacaad WHERE ch_no = id;
        SET msg = CONCAT(id, ' - Deleted successfully.');
      END IF;
    ELSE
      SET msg = CONCAT(id, ' - Does not exist, so we cannot delete.');
    END IF;
  ELSEIF oper = 'update' THEN
    IF EXISTS (SELECT ch_no FROM dalacaad WHERE ch_no = id) THEN
      UPDATE dalacaad SET am_no = am_no_pro, amount = amount_pro, date_charge = dateDal_pro WHERE ch_no = id;
      SET msg = CONCAT(id, ' - Updated successfully.');
    ELSE
      SET msg = CONCAT(id, ' - Does not exist, so we cannot update.');
    END IF;
  ELSEIF oper = 'insert' THEN
    IF EXISTS (SELECT * FROM dalacaad WHERE am_no = am_no_pro AND amount = amount_pro AND date_charge = dateDal_pro) THEN
      SET msg = CONCAT(id, ' - Already exists.');
    ELSE
      INSERT INTO dalacaad (am_no, amount, date_charge) VALUES (am_no_pro, amount_pro, dateDal_pro);
      SET msg = CONCAT(id, ' - Inserted successfully.');
    END IF;
  END IF;

  SELECT msg AS msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dalacaad_proc` (IN `num` INT, IN `am` INT, IN `lacag` DOUBLE, IN `taariikh` DATE, IN `oper` VARCHAR(40))  BEGIN
CASE
when oper='update' then
if exists(select * from dalacaad where num=ch_no) then
update dalacaad set am_no=am, Amount=lacag, date_charge=taariikh  where num=ch_no;
select 'updated success' as msg;
else
select concat(num, ' this charges number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from dalacaad where num=ch_no) then
delete from dalacaad where num=ch_no ;
select 'deleted success' as msg;
else
select concat(ch_no,' this charges number is not exist') as msg;
end if;
when oper='insert' then
insert into dalacaad values(null, am,lacag,taariikh);
select 'inserted success' as msg;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dalacaad_view` ()  BEGIN
SELECT ch_no,name,amount,date_charge 'taariikhda' from registration r,qaadasho a,dalacaad ch WHERE r.id=a.id and ch.am_no=a.am_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dl` (IN `num` INT, IN `am_no` INT, IN `Amount_c` DOUBLE, IN `date_charge` DATE, IN `oper` VARCHAR(60))  begin
CASE
when oper='update' then
if exists(select * from dalacaad where num=ch_no) then
update dalacaad set am_no=am_no, Amount=Amount, date_charge=date_charge where num=ch_no;
select 'updated success' as msg;
else
select concat(num, 'this charge number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from dalacaad where ch_no=num) then
delete from dalacaad where ch_no=num ;
select 'deleted success' as msg;
else
select concat(ch_no,' this dalacaad number is not exist') as msg;
end if;
when oper='insert' then
SELECT (qty)*(price)*datediff(last_date,first_date)'sub_total' into @x from qaadasho where am_no=num;
select d.Amount into @y from dalacaad d WHERE d.am_no=num;
if(@x=@y) then
insert into dalacaad values(null, am_no,Amount_c,date_charge);
select 'inserted success' as msg;
ELSE
SELECT 'failed';
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `dl_proc` (IN `num` INT, IN `am_no` INT, IN `weak_no` INT, IN `date_charge` DATE, IN `oper` VARCHAR(40))  begin
CASE
when oper='update' then
if exists(select * from dalacaad where num=ch_no) then
update dalacaad set am_no=am_no, week_no=weak_no, date_charge=date_charge where num=ch_no;
select 'updated success' as msg;
else
select concat(num, 'this charge number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from dalacaad where ch_no=num) then
delete from dalacaad where ch_no=num ;
select 'deleted success' as msg;
else
select concat(ch_no,' this dalacaad number is not exist') as msg;
end if;
when oper='insert' then
if EXISTS(SELECT * from dalacaad WHERE date_charge>CURRENT_DATE) THEN
SELECT 'taariikhda aad soo gelisay lama gaarin' as msg;
else
insert into dalacaad values(null, am_no,weak_no,date_charge);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `ex` (IN `num` INT)  BEGIN
SELECT (qty)*(price)*datediff(last_date,first_date)'sub_total' into @x  from qaadasho q WHERE am_no=num;
if @x<12 then
SELECT 'failed' as msg;
end if;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expence_charge` (IN `expenNO` INT, IN `qimaha` DOUBLE, IN `fahfahin` TEXT, IN `oper` VARCHAR(50), IN `id` INT)  BEGIN
CASE
WHEN oper = 'delete' THEN
if exists(SELECT ch_no FROM expense_charge where ch_no=id) then
if exists(SELECT ch_no FROM expense_peyment where ch_no = id) then
select concat(id ,'  waxaa lagu dalacay kharashaad,Marka hore tir kharashaadka!.') as msg from expense_peyment where ch_no =id;
else
delete from expense_charge where ch_no = id;
select ' deleted sucessfully' as msg;
end if;
else
select concat(id,' is not exist, so we can not delete') as msg;
end if;
WHEN oper='update' THEN
IF EXISTS (SELECT ch_no FROM expense_charge WHERE ch_no = id) THEN
UPDATE expense_charge SET exp_no = expenNO, amount= qimaha, description = fahfahin WHERE ch_no = id;
SELECT 'Updated successfully' AS msg;
ELSE
SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
END IF;
WHEN oper='insert' THEN
IF EXISTS (SELECT * FROM expense_charge WHERE exp_no = expenNO AND amount = qimaha AND description = fahfahin) THEN
SELECT CONCAT(id, ' already exists') AS msg;
ELSE
INSERT INTO expense_charge VALUES (NULL, expenNO,qimaha,fahfahin);
SELECT 'Inserted successfully' AS msg;
END IF;
END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expence_proc` (IN `num` INT, IN `qarash` VARCHAR(80), IN `oper` VARCHAR(20))  begin
CASE
when oper='update' then
if exists(select * from expenses where exp_no=num) then
update expenses set exp_name=qarash where exp_no=num;
select 'updated success' as msg;
else
select concat(exp_no,' this exo_no number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from expenses where exp_no=num) then
delete from expenses where exp_no=num ;
select 'deleted success' as msg;
else
select concat(num,' this exp_no number is not exist') as msg;
end if;

when oper='insert' then
if exists(select * from expenses where exp_name=qarash) then

select concat(qarash, ' already exists') as msg;
else
insert into expenses values(null, qarash);
select 'inserted success' as msg;
end if;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expenses_view` ()  BEGIN
SELECT exp_no,exp_name FROM expenses;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_charge_p` (IN `num` INT, IN `exp_no` INT, IN `qiimaha` DOUBLE, IN `fahfahin` VARCHAR(20), IN `oper` VARCHAR(30))  begin
CASE
when oper='update' then
if exists(select * from expense_charge where num=ch_no) then
update expense_charge set exp_no=exp_no, qiimaha=amount, fahfahin=description where num=ch_no;
select 'updated success' as msg;
else
select concat(ch_no, 'this expence_charge  number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from expense_charge where num=ch_no) then
delete from expense_charge where num=ch_no ;
select 'deleted success' as msg;
else
select concat(num,' this expence_charge number is not exist') as msg;
end if;
when oper='insert' then
if EXISTS(SELECT * from expense_charge WHERE qiimaha<0) THEN
SELECT concat(qiimaha,' aad sogelisay waxuu ka yaryahay 0') as msg;
ELSEIF EXISTS(SELECT * from expense_charge WHERE qiimaha=0) THEN
SELECT concat(qiimaha,' aad sogelisay waxuu la egyahay 0 fadlan kabadan soo geli') as msg;
else
insert into expense_charge values(null, exp_no,qiimaha,fahfahin);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expense_charge_view` ()  BEGIN
SELECT ec.ch_no,exp_name,amount,description from expense_charge ec,expenses e WHERE ec.exp_no=e.exp_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `expPyment_pro` (IN `charNum` INT, IN `qimaha` DOUBLE, IN `accNom` VARCHAR(50), IN `oper` VARCHAR(50), IN `id` INT)  BEGIN
  CASE
    WHEN oper = 'delete' THEN
      if exists(SELECT exp_py_no FROM expense_peyment where exp_py_no=id) then
    delete from expense_peyment where exp_py_no = id;
    select ' deleted sucessfully' as msg;
    else
    select concat(id,' is not exist, so we can not delete') as msg;
    end if;

    WHEN oper = 'update' THEN
      IF EXISTS (SELECT exp_py_no FROM expense_peyment WHERE exp_py_no = id) THEN
        UPDATE expense_peyment SET ch_no = charNum, amount= qimaha, acc_no = accNom WHERE exp_py_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN oper = 'insert' THEN
      IF EXISTS (SELECT * FROM expense_peyment WHERE ch_no = charNum AND amount = qimaha AND acc_no = accNom) THEN
        SELECT CONCAT(id, ' already exists') AS msg;
      ELSE
        INSERT INTO expense_peyment VALUES (NULL, charNum, qimaha,accNom);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `inventory` ()  BEGIN
create TEMPORARY table inv as SELECT concat(book_no,'-',title) 'Inventory-books'  from books ORDER by book_no asc  ;
insert into inv SELECT lpad(concat('amaah-books'),20,'-');
insert into inv SELECT concat(am_no,'-',title)'inta-maqan' from qaadasho a,books b WHERE a.book_no=b.book_no;
insert into inv select lpad(concat('calculations-books'),25,'-');
SELECT COUNT(book_no) into @x from books;
insert into inv select concat('total-books','----',@x);
SELECT count(am_no) into @y from qaadasho;
insert into inv select concat('inta-maqan','-----',@y);
insert into inv SELECT concat('inta-taaalo is: ',@x-@y)'total';
SELECT * from inv;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lacag_bixin_pro` (IN `id` INT, IN `pur_no_pro` INT, IN `qimaha` DECIMAL(10,2), IN `accNo_pro` INT, IN `tarikh` DATE, IN `oper` VARCHAR(50))  BEGIN
  CASE
    WHEN oper = 'delete' THEN
      IF EXISTS (SELECT pay_no FROM lacag_bixin WHERE pay_no = id) THEN
        DELETE FROM lacag_bixin WHERE pay_no = id;
        SELECT 'Deleted successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN oper = 'update' THEN
      IF EXISTS (SELECT pay_no FROM lacag_bixin WHERE pay_no = id) THEN
        UPDATE lacag_bixin SET por_no=pur_no_pro,amount = qimaha,acc_no = accNo_pro, pay_date = tarikh WHERE pay_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN oper = 'insert' THEN
      IF EXISTS (SELECT * FROM lacag_bixin WHERE por_no=pur_no_pro AND amount = qimaha AND acc_no = accNo_pro AND pay_date = tarikh) THEN
        SELECT CONCAT(id, ' already exists') AS msg;
      ELSE
        INSERT INTO lacag_bixin VALUES (NULL,pur_no_pro,qimaha,accNo_pro,tarikh);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `lacag_view` ()  BEGIN
SELECT pay_no,title 'book-name',Quantity,cost,discount,(Quantity*cost)-(discount/100)*(Quantity*cost)'total',amount 'laga-bixiyay',acc_name from lacag_bixin l,books b,account a,purchase p WHERE l.por_no=p.por_no and l.acc_no=a.acc_no and p.book_no=b.book_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `net` ()  BEGIN
CREATE TEMPORARY table ex_name as SELECT concat('Revenue  ',sum(r.Amount))'Income-Statement' from qabasho r;
 insert into ex_name select lpad('Expences',14,'-');
INSERT into ex_name SELECT concat(exp_name) 'qarashadka-labixiyay'  from expenses e;
insert into ex_name SELECT concat('total-expence',lpad(format(sum(amount),2),20,'-'))  from expense_charge;
SELECT sum(r.Amount) 'revenue' into @'faaiido' from qabasho r;
select sum(amount)'expence' into @'bixis' from expense_charge;
set @bal=@faaiido-@bixis;
insert into ex_name SELECT concat('Net-Income',lpad(format(@bal,2),20,'-'));
select * from ex_name;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `options_proc` (IN `option_name_sp` VARCHAR(50), IN `faahfaahin_sp` VARCHAR(50), IN `oper` VARCHAR(50), IN `op_id_sp` INT)  begin
CASE
when oper='update' then
if exists(select * from options where op_id=op_id_sp) then
update options set option_name=option_name_sp, faahfaahin=faahfaahin_sp where op_id=op_id_sp;
select 'updated success' as msg;
else
select concat(op_id_sp, 'this options number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from options where op_id=op_id_sp) then
delete from options where op_id=op_id_sp ;
select 'deleted success' as msg;
else
select concat(op_id_sp,' this optoins number is not exist') as msg;
end if;

when oper='insert' then
if exists(select * from options where option_name=option_name_sp and faahfaahin=faahfaahin_sp) then
select concat(option_name_sp,faahfaahin_sp, ' already exists') as msg;
else
insert into options values(null, option_name_sp,faahfaahin_sp);
select 'inserted success' as msg;
end if;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payments_pro` (IN `id` INT, IN `chNo_pro` INT, IN `qimaha` DECIMAL(10,2), IN `accNo_pro` INT, IN `tarikh` DATE, IN `oper` VARCHAR(50))  BEGIN
  CASE
    WHEN oper = 'delete' THEN
      IF EXISTS (SELECT pay_no FROM payments WHERE pay_no = id) THEN
        DELETE FROM payments WHERE pay_no = id;
        SELECT 'Deleted successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN oper = 'update' THEN
      IF EXISTS (SELECT pay_no FROM payments WHERE pay_no = id) THEN
        UPDATE payments SET ch_no=chNo_pro,amount = qimaha,acc_no = accNo_pro, pay_date = tarikh WHERE pay_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN oper = 'insert' THEN
      IF EXISTS (SELECT * FROM payments WHERE ch_no=chNo_pro AND amount = qimaha AND acc_no = accNo_pro AND pay_date = tarikh) THEN
        SELECT CONCAT(id, ' already exists') AS msg;
      ELSE
        INSERT INTO payments VALUES (NULL,chNo_pro,qimaha,accNo_pro,tarikh);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `payment_view` ()  BEGIN
SELECT pay_no,concat(title,'--',ch.amount )'lagu-dalacay' ,p.amount 'laga-qabtay',pay_date from payments p,books b,charges ch WHERE p.ch_no=ch.ch_no and ch.book_no=b.book_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pr_view` ()  BEGIN
SELECT pur_ret_no,title 'Book-Name',qty,reason,return_Date from purchase_return pr,purchase p, books b WHERE p.book_no=b.book_no and p.por_no = pr.por_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_proc` (IN `book_no_sp` INT, IN `qtys` DECIMAL, IN `costs` DOUBLE, IN `discounts` DOUBLE, IN `taariikh_sp` DATE, IN `oper` VARCHAR(50), IN `por_no_sp` INT)  begin
CASE
when oper='update' then
if exists(select * from purchase where por_no=por_no_sp) then
update purchase set book_no=book_no_sp, Quantity=qtys, cost=costs, discount=discounts, taariikh=taariikh_sp where por_no=por_no_sp;
select 'updated success' as msg;
else
select concat(por_no_sp, 'this purchase  number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from purchase where por_no=por_no_sp) then
delete from purchase where por_no=por_no_sp ;
select 'deleted success' as msg;
else
select concat(por_no_sp,' this purchase number is not exist') as msg;
end if;
when oper='insert' then
insert into purchase values(null, book_no_sp,qtys,costs,discounts,taariikh_sp);
select 'inserted success' as msg;

end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_return_proc` (IN `por_no_sp` INT, IN `qtys` DECIMAL, IN `reasons` VARCHAR(50), IN `return_date_sp` DATE, IN `oper` VARCHAR(50), IN `pur_ret_no_sp` INT)  begin
CASE
when oper='update' then
if exists(select * from purchase_return where pur_ret_no=pur_ret_no_sp) then
update purchase_return set por_no=por_no_sp, qty=qtys, reason=reasons, return_date=return_dates where pur_ret_no=pur_ret_no_sp;
select 'updated success' as msg;
else
select concat(pur_ret_no_sp, 'this purchase return number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from purchase_return where pur_ret_no=pur_ret_no_sp) then
delete from purchase_return where pur_ret_no=pur_ret_no_sp ;
select 'deleted success' as msg;
else
select concat(pur_ret_no_sp,' this purchase_return number is not exist') as msg;
end if;
when oper='insert' then

insert into purchase_return values(null, por_no_sp,qtys,reasons,return_date_sp);
select 'inserted success' as msg;

end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `purchase_view` ()  BEGIN
SELECT por_no,title 'Book-Name',Quantity,cost,discount,taariikh from purchase p,books b WHERE p.book_no=b.book_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pur_proc` (IN `num` INT, IN `buug` INT, IN `tiro` INT, IN `qiimo` DOUBLE, IN `discount` DOUBLE, IN `taariikh` DATE, IN `oper` VARCHAR(40))  BEGIN
CASE
when oper='update' then
if exists(select * from purchase where por_no=num) then
update purchase set book_no=buug, Quantity=tiro, cost=qiimo where por_no=num;
select 'updated success' as msg;
else
select concat(num, 'this address number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from purchase where por_no=num) then
delete from purchase where por_no=num ;
select 'deleted success' as msg;
else
select concat(num,' this address number is not exist') as msg;
end if;
when oper='insert' then
if exists(select * from purchase where book_no=buug and Quantity=tiro and cost=qiimo and discount=discount) then
select concat(buug,tiro,qiimo,discount, ' already exists') as msg;
else
insert into purchase values(null, buug,tiro,qiimo,discount,taariikh);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `pur_r_proc` (IN `num` INT, IN `buug` INT, IN `tiro` INT, IN `sabab` VARCHAR(40), IN `taariikh` DATE, IN `oper` VARCHAR(20))  BEGIN
CASE
when oper='update' then
if exists(select * from purchase_return where pur_ret_no=num) then
update purchase_return set por_no=buug, qty=tiro, reason=sabab,return_Date=taariikh where num=pur_ret_no;
select 'updated success' as msg;
else
select concat(num, 'this address number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from purchase_return where pur_ret_no=num) then
delete from purchase_return where pur_ret_no=num ;
select 'deleted success' as msg;
else
select concat(num,' this address number is not exist') as msg;
end if;
when oper='insert' then
if exists(select * from purchase_return where por_no=buug and qty=tiro and reason=sabab) then
select concat(buug,tiro,sabab, ' already exists') as msg;
else
insert into purchase_return values(null, buug,tiro,sabab,taariikh);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qaadasho` (IN `num` INT, IN `book_no` INT, IN `id` INT, IN `qty` INT, IN `price` INT, IN `first_date` DATE, IN `last_date` DATE, IN `oper` VARCHAR(40))  begin
CASE
when oper='update' then
if exists(select * from qaadasho where am_no = num) then
update qaadasho set book_no=book_no, id=id, qty=qty, price=price, first_date=first_date,last_date=last_date  where am_no=num;
select 'updated success' as msg;
else
select concat(num, ' this ammah number is not exist') as msg;
end if;
when oper='delete' then
if exists(SELECT am_no FROM qaadasho where am_no=num) then
      if exists(SELECT am_no FROM dalacaad where am_no = num) then
      select concat(num ,' kharashkaan waa ladalacay marka hore tir dalcaada!.') as msg from qaadasho where am_no =num;
    else
    delete from qaadasho where am_no = num;
    select ' deleted sucessfully' as msg;
    end if;
    else
    select concat(id,' is not exist, so we can not delete') as msg;
    end if;
when oper='insert' then
insert into qaadasho values(null, book_no,id,qty,price,first_date,last_date);
select 'inserted success' as msg;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qaadasho_book` (IN `num` INT, IN `book_no` INT, IN `id` INT, IN `qty` INT, IN `price` DOUBLE, IN `first_date` DATE, IN `last_date` DATE, IN `oper` VARCHAR(50))  begin
CASE
when oper='update' then
if exists(select * from qaadasho where am_no=num) then
update qaadasho set book_no=book_no, id=id, qty=qty, price=price, first_date=first_date ,last_date=last_date  where am_no=num;
select 'updated success' as msg;
else
select concat(num, 'this amaah  number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from qaadasho where am_no=num) then
delete from qabasho where num=am_no ;
select 'deleted success' as msg;
else
select concat(num,' this amaah number is not exist') as msg;
end if;
when oper='insert' then
if EXISTS(SELECT * from qaadasho WHERE qty<0) THEN
SELECT 'qty aad soo gelisay waxuu ka yaryahay 0' as msg;
elseif EXISTS(SELECT * from qaadasho WHERE qty=0) THEN
SELECT 'qty aad soo gelisay waxuu ka la egyahay 0' as msg;
elseif EXISTS(SELECT * from qaadasho WHERE price<0) THEN
SELECT 'price aad soo gelisay waxuu ka yaryahay 0' as msg;
ELSEIF EXISTS(SELECT * from qaadasho WHERE price=0) THEN
SELECT 'price aad soo gelisay waxuu ka la egyahay 0' as msg;
ELSEIF EXISTS(SELECT * from qaadasho WHERE first_date>CURRENT_DATE) THEN
SELECT 'taariikhda aad soo gelisay lama gaarin' as msg;
ELSEIF EXISTS(SELECT * from qaadasho WHERE last_date<first_date) THEN
SELECT 'taariikhda aad soo gelisay waa lasoo dhafay' as msg;
ELSE
insert into qaadasho values(null, book_no,id,qty,price,first_date,last_date);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qaadasho_rep` ()  BEGIN
SELECT am_no ID,title 'book-name',name 'qofka-qaatay',qty 'inta-maqan' from books b,qaadasho a,registration r WHERE b.book_no=a.book_no and r.id=a.id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qaadasho_vw` ()  BEGIN
SELECT am_no ID,name, title, qty, price, first_date, last_date,DATEDIFF(last_date, first_date)as days FROM books b, registration r, qaadasho q WHERE r.id = q.id and q.book_no = b.book_no ORDER by am_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qabasho1` (IN `ch_no_pro` INT, IN `amount_pro` DOUBLE, IN `acc_no_pro` INT, IN `recQab_pro` DATE, IN `oper` VARCHAR(50), IN `id` INT)  BEGIN
  DECLARE msg VARCHAR(100);

  IF oper = 'delete' THEN
    IF EXISTS (SELECT rec_no FROM qabasho WHERE rec_no = id) THEN
      DELETE FROM qabasho WHERE rec_no = id;
      SET msg = 'Deleted successfully.';
    ELSE
      SET msg = CONCAT(id, ' does not exist, so we cannot delete.');
    END IF;
  ELSEIF oper = 'update' THEN
    IF EXISTS (SELECT rec_no FROM qabasho WHERE rec_no = id) THEN
      UPDATE qabasho SET ch_no = ch_no_pro, amount = amount_pro, acc_no = acc_no_pro, rec_date = recQab_pro WHERE rec_no = id;
      SET msg = 'Updated successfully.';
    ELSE
      SET msg = CONCAT(id, ' does not exist, so we cannot update.');
    END IF;
  ELSEIF oper = 'insert' THEN
    IF EXISTS (SELECT * FROM qabasho WHERE ch_no = ch_no_pro AND amount = amount_pro AND acc_no = acc_no_pro AND rec_date = recQab_pro) THEN
      SET msg = CONCAT(id, ' already exists.');
    ELSE
      INSERT INTO qabasho (ch_no, amount, acc_no, rec_date) VALUES (ch_no_pro, amount_pro, acc_no_pro, recQab_pro);
      SET msg = 'Inserted successfully.';
    END IF;
  END IF;

  SELECT msg AS msg;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qabasho_proc` (IN `num` INT, IN `ch_no` INT, IN `amount` DOUBLE, IN `acc_no` INT, IN `rec_date` DATE, IN `oper` VARCHAR(30))  begin
CASE
when oper='update' then
if exists(select * from qabasho where num=rec_no) then
update qabasho set ch_no=ch_no, Amount=amount, acc_no=acc_no, rec_date=rec_date where num=rec_no;
select 'updated success' as msg;
else
select concat(num, 'this receipts number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from qabasho where rec_no=num) then
delete from qabasho where rec_no=num ;
select 'deleted success' as msg;
else
select concat(rec_no,' this receipts number is not exist') as msg;
end if;
when oper='insert' then
if EXISTS(SELECT * from qabasho WHERE rec_date>CURRENT_DATE) THEN
SELECT 'taariikhda hada soo geli' as msg;
else
insert into qabasho values(null, ch_no,amount,acc_no,rec_date);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qabasho_view` ()  BEGIN
SELECT name, title 'book-name',a.qty,wk.price, a.qty * wk.price as Total, first_date 'taariikhda-qaadashada',last_date 'taariikhda-soocelinta' from qaadasho a,books b,registration r,weeklly_price wk  WHERE a.book_no=b.book_no and a.id=r.id and wk.week_no = a.price ORDER by am_no asc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qabasho_views` ()  BEGIN
SELECT  r.name, tell,get_charged(r.id) as Dr, get_rec(r.id) as Cr ,get_bal(r.id) as balance FROM dalacaad d, 
registration r,qabasho q,qaadasho qq where r.id = qq.id  and d.am_no = qq.am_no
GROUP by qq.id;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qab_proc` (IN `num` INT, IN `ch_no` INT, IN `Amount` DOUBLE, IN `acc_no` INT, IN `rec_date` DATE, IN `oper` VARCHAR(40))  begin
CASE
when oper='update' then
if exists(select * from qabasho where num=rec_no) then
update qabasho set ch_no=ch_no, Amount=amount, acc_no=acc_no, rec_date=rec_date where num=rec_no;
select 'updated success' as msg;
else
select concat(num, 'this receipts number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from qabasho where rec_no=num) then
delete from qabasho where rec_no=num ;
select 'deleted success' as msg;
else
select concat(rec_no,' this receipts number is not exist') as msg;
end if;
when oper='insert' then
if EXISTS(SELECT * from qabasho WHERE rec_date>CURRENT_DATE ) THEN
SELECT 'taariikhda hada soo geli ' as msg;
elseif EXISTS(SELECT * from qabasho WHERE Amount<0) THEN
SELECT concat(Amount,' waxuu ka yaryahay 0 ') as msg;
elseif EXISTS(SELECT * from qabasho WHERE  Amount=0) THEN
SELECT concat(Amount,' Amountikaga waxuu la egyahay 0 fadlan kabadan soo geli') as msg;
else
insert into qabasho values(null, ch_no,Amount,acc_no,rec_date);
select 'inserted success' as msg;
end if;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `qab_view` ()  BEGIN
SELECT rec_no,name,rr.amount,acc_name from registration re,qaadasho a,dalacaad ch,account ac,qabasho rr WHERE re.id=a.id and ch.am_no=a.am_no and rr.ch_no=ch.ch_no and rr.acc_no=ac.acc_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `receipt_proc` (IN `num` INT, IN `am_no` INT, IN `ch_no` INT, IN `lacag_amaah` DOUBLE, IN `lacag_charge` DOUBLE, IN `acc_no` INT, IN `taariikh` DATE, IN `oper` VARCHAR(20))  begin
CASE
when oper='update' then
if exists(select * from receipt where rec_no=num) then
update receipt set rec_no=num, am_no=am_no, ch_no=ch_no, lacag_amaah=amah_amount, lacag_charge=charge_amount ,acc_no=acc_no ,taariikh=rec_date where rec_no=num;
select 'updated success' as msg;
else
select concat(num, 'this receipts number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from receipt where rec_no=num) then
delete from receipt where rec_no=num ;
select 'deleted success' as msg;
else
select concat(rec_no,' this receipts number is not exist') as msg;
end if;
when oper='insert' then
insert into receipt values(null, am_no,ch_no,lacag_amaah,lacag_charge,acc_no,taariikh);
select 'inserted success' as msg;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `receipt_view` ()  BEGIN
SELECT rec_no,concat(title,'--',ch.amount )'lagu-dalacay',sum((amah_amount)+(charge_amount))'laga-qabtay',acc_name from receipt r,amaah ah,charges ch,account a,books b WHERE r.am_no=ah.am_no and r.ch_no=ch.ch_no and r.acc_no=a.acc_no and ch.book_no=b.book_no and ah.book_no=b.book_no;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `recip_pro` (IN `amah_no` INT, IN `chNo_pro` INT, IN `a_qimaha` DECIMAL(10,2), IN `c_qimaha` DECIMAL(10,2), IN `accNo_pro` INT, IN `tarikh` DATE, IN `oper` VARCHAR(50), IN `id` INT)  BEGIN
  CASE
    WHEN oper = 'delete' THEN
      IF EXISTS (SELECT rec_no FROM receipt WHERE rec_no = id) THEN
        DELETE FROM receipt WHERE rec_no = id;
        SELECT 'Deleted successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot delete') AS msg;
      END IF;

    WHEN oper = 'update' THEN
      IF EXISTS (SELECT rec_no FROM receipt WHERE rec_no = id) THEN
        UPDATE receipt SET am_no = amah_no,ch_no=chNo_pro,amah_amount = a_qimaha,charge_amount = c_qimaha,acc_no = accNo_pro, rec_date = tarikh WHERE rec_no = id;
        SELECT 'Updated successfully' AS msg;
      ELSE
        SELECT CONCAT(id, ' does not exist, so we cannot update') AS msg;
      END IF;

    WHEN oper = 'insert' THEN
      IF EXISTS (SELECT * FROM receipt WHERE am_no = amah_no AND ch_no=chNo_pro AND amah_amount = a_qimaha AND charge_amount = c_qimaha AND acc_no = accNo_pro AND rec_date = tarikh) THEN
        SELECT CONCAT(id, ' already exists') AS msg;
      ELSE
        INSERT INTO receipt VALUES (NULL, amah_no,chNo_pro,qimaha,accNo_pro, tarikh);
        SELECT 'Inserted successfully' AS msg;
      END IF;
  END CASE;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registration_proc` (IN `id_sp` INT, IN `name_sp` VARCHAR(40), IN `tell_sp` VARCHAR(50), IN `add_no_sp` INT, IN `option_id_sp` INT, IN `oper` VARCHAR(50))  begin
case 
when oper='update' then
if exists(select * from registration where id=id_sp) then
update registration set name=name_sp, tell=tell_sp, add_no=add_no_sp where id=id_sp;
select 'updated success' as msg;
else
select concat(id_sp,' this registeration number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from registration where id=id_sp) then
delete from registration where id=id_sp ;
select 'deleted success' as msg;
else
select concat(id_sp,' this registration number is not exist') as msg;
end if;
when oper='insert' then

insert into registration values(null,name_sp,tell_sp,add_no_sp,option_id_sp);
select 'inserted success' as msg;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `registration_view` ()  begin
select id, name, tell, concat(a.district,' - ',a.village,' - ',a.zone) address, o.option_name 'Option Name' from registration r join address a on a.add_no=r.add_no join options o on o.op_id=r.option_id ORDER by id asc;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `rr` (IN `num` INT, IN `am_no` INT, IN `Amount` DOUBLE, IN `date_charge` DATE, IN `oper` VARCHAR(20))  BEGIN 
case
when oper='insert' THEN
SELECT (qty)*(price)*datediff(last_date,first_date)'sub_total' into @x  from qaadasho q where q.am_no=am_no;
if EXISTS( SELECT @x=Amount) THEN
INSERT into dalacaad VALUES(null,am_no,Amount,date_charge);
ELSE
SELECT 'failed';
END if;
end CASe;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `users_proc` (IN `usernames` VARCHAR(50), IN `passwords` VARCHAR(50), IN `user_type_sp` VARCHAR(50), IN `emails` VARCHAR(50), IN `oper` VARCHAR(50), IN `userid_sp` INT)  begin
CASE
when oper='update' then
if exists(select * from users where userid = userid_sp ) then
update users set username=usernames, password=passwords, user_type=user_type_sp,email=emails where userid=userid_sp;
select 'updated success' as msg;
else
select concat(userid_sp, 'this users number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from users where userid=userid_sp) then
delete from users where userid=userid_sp ;
select 'deleted success' as msg;
else
select concat(userid_sp,' this user number is not exist') as msg;
end if;

when oper='insert' then
if exists(select * from users where username=usernames and password=passwords) then
select concat(usernames,passwords, ' already exists') as msg;
else
insert into users values(null, usernames,sha1(passwords),user_type,emails);
select 'inserted success' as msg;
end if;
end case;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_proc` (IN `num` INT, IN `username` VARCHAR(40), IN `password` VARCHAR(30), IN `email` VARCHAR(30), IN `user_id` INT, IN `oper` VARCHAR(50))  BEGIN
CASE
when oper='update' then
if exists(select * from users where id=num) then
update users set username=username, password=password, email=email, user_id=user_id where id=num;
select 'updated success' as msg;
else
select concat(num, 'this user  number is not exist') as msg;
end if;
when oper='delete' then
if exists(select * from users where id=num) then
delete from users where id=num ;
select 'deleted success' as msg;
else
select concat(id,' this user number is not exist') as msg;
end if;
when oper='insert' then
insert into users values(null, username,password,email,user_id);
select 'inserted success' as msg;
end case;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_view` ()  BEGIN
SELECT id,username,password,email,type from users u,user_type ut WHERE u.user_id=ut.user_id;
end$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `user_view1` ()  BEGIN
SELECT id,username,email,type from users u,user_type ut WHERE ut.user_id=u.user_id;
end$$

--
-- Functions
--
CREATE DEFINER=`root`@`localhost` FUNCTION `get_bal` (`num` INT) RETURNS DOUBLE BEGIN
SELECT sum(Amount)'qab' into @y from qabasho q,dalacaad d,qaadasho qq,registration r WHERE d.ch_no=q.ch_no and d.am_no=qq.am_no and r.id=qq.id and qq.id=num GROUP by qq.id; 

SELECT sum((qty*qq.price)+(wc.price))'dalacd' into @x from qaadasho qq ,dalacaad d,weeklly_charged wc,registration r WHERE qq.am_no=d.am_no and wc.week_no=d.week_no and r.id=qq.id and qq.id=num  GROUP by qq.id;
SET @bal=@x-@y;
RETURN @bal;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_balance` (`id` DECIMAL(10,2)) RETURNS DECIMAL(10,2) BEGIN

SELECT sum(Amount)'total' into @y from qabasho q,dalacaad d,qaadasho qq,registration r WHERE d.ch_no=q.ch_no and d.am_no=qq.am_no and r.id=qq.id and qq.id=num GROUP by qq.id; 

SELECT sum((qty*q.price)+(wc.price))'total' into @x from qaadasho qq ,dalacaad d,weeklly_charged wc,registration r WHERE qq.am_no=d.am_no and wc.week_no=d.week_no and r.id=qq.id and qq.id=num  GROUP by qq.id;
SET @bal=@y-@x;
RETURN @bal;
END$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_charged` (`num` INT) RETURNS DOUBLE BEGIN
SELECT sum((qq.qty*qq.price)+(wc.price))'total' into @x from qaadasho qq ,dalacaad d,weeklly_charged wc,registration r WHERE qq.am_no=d.am_no and wc.week_no=d.week_no and r.id=qq.id and qq.id=num  GROUP by qq.id;
RETURN @x;
end$$

CREATE DEFINER=`root`@`localhost` FUNCTION `get_rec` (`num` INT) RETURNS DOUBLE BEGIN
SELECT sum(Amount)'total' into @y from qabasho q,dalacaad d,qaadasho qq,registration r WHERE d.ch_no=q.ch_no and d.am_no=qq.am_no and r.id=qq.id and qq.id=num GROUP by qq.id;
RETURN @y;
end$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `account`
--

CREATE TABLE `account` (
  `acc_no` int(11) NOT NULL,
  `acc_name` varchar(50) NOT NULL,
  `institution` varchar(50) NOT NULL,
  `balance` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `account`
--

INSERT INTO `account` (`acc_no`, `acc_name`, `institution`, `balance`) VALUES
(1, '5678', 'hormuud', '4776.00'),
(2, 'cumar', 'fghj', '12345.00'),
(3, 'ghjk', 'fghjk', '0.00'),
(4, 'ghj', 'rtyu', '45678.00'),
(5, '45678', 'dahabshiil', '3897.00'),
(6, '34567', 'salaam-bank', '6000.00'),
(7, '7890', 'zaad', '801.00'),
(8, '777', 'premier', '4500.00');

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE `address` (
  `add_no` int(11) NOT NULL,
  `district` varchar(50) NOT NULL,
  `village` varchar(40) NOT NULL,
  `zone` varchar(40) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`add_no`, `district`, `village`, `zone`) VALUES
(12, '', '', ''),
(9, 'cvvnm', 'hbjk', 'hgjk'),
(5, 'dfhj', 'cvbn', 'vbnm'),
(6, 'DSAD', 'ASDADS', 'SADSA'),
(10, 'gggg', 'ggg', 'gg'),
(7, 'hodon', 'bakaaro', 'wadda'),
(3, 'juungale', 'jeera', 'masaajidka ali mahdi'),
(8, 'karan', 'qoob', 'laami'),
(4, 'sdjhbdjs', 'dfhjdj', 'bjdfvjd'),
(13, 'tyu', 'ftyui', 'tyui'),
(1, 'yaqshid', 'sinay', 'laamiga'),
(2, 'yaqshid', 'towfiq', 'shakti');

-- --------------------------------------------------------

--
-- Stand-in structure for view `address_view`
-- (See below for the actual view)
--
CREATE TABLE `address_view` (
`add_no` int(11)
,`district` varchar(50)
,`village` varchar(40)
,`zone` varchar(40)
);

-- --------------------------------------------------------

--
-- Table structure for table `amaah`
--

CREATE TABLE `amaah` (
  `am_no` int(11) NOT NULL,
  `book_no` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `price` decimal(10,2) NOT NULL,
  `first_date` date NOT NULL,
  `last_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `amaah`
--

INSERT INTO `amaah` (`am_no`, `book_no`, `id`, `price`, `first_date`, `last_date`) VALUES
(1, 1, 1, '12.00', '2024-05-12', '2024-05-31'),
(2, 2, 2, '100.00', '2024-06-03', '2024-06-30');

-- --------------------------------------------------------

--
-- Table structure for table `author`
--

CREATE TABLE `author` (
  `auth_no` int(11) NOT NULL,
  `auth_name` varchar(50) NOT NULL,
  `sex` enum('Male','Female') DEFAULT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `author`
--

INSERT INTO `author` (`auth_no`, `auth_name`, `sex`, `Description`) VALUES
(1, 'logrihum', 'Male', 'Qoraa iyo fayla suuf'),
(2, 'dheere', 'Male', 'qoraa'),
(3, 'Omar-bashir', 'Male', 'waa qoraa'),
(4, 'Dhooye', 'Male', 'Qoraa buugta somaliga ');

-- --------------------------------------------------------

--
-- Table structure for table `books`
--

CREATE TABLE `books` (
  `book_no` int(11) NOT NULL,
  `cat_no` int(11) NOT NULL,
  `title` varchar(40) NOT NULL,
  `ISB` int(11) NOT NULL,
  `auth_no` int(11) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `books`
--

INSERT INTO `books` (`book_no`, `cat_no`, `title`, `ISB`, `auth_no`, `Description`) VALUES
(1, 1, 'speins', 129, 1, 'sheeko faneed'),
(2, 3, 'linear-algebra', 567, 1, 'hhh'),
(3, 3, 'descrete', 4567, 3, 'fghj'),
(4, 1, 'computer_architecture', 678, 2, 'fghjk'),
(5, 1, 'python', 2345, 3, 'fghj'),
(6, 3, 'defferianl-equation', 1234, 1, 'bvn'),
(7, 4, 'pys', 4567, 3, 'sdfghj'),
(8, 5, 'Kobciye', 23459, 2, 'Boog afsomali'),
(9, 2, 'Taariikhda somalia', 1297, 3, 'Taariikhda somalia oo dhamaystiran'),
(10, 5, 'Fun iyo Fagaaro', 23457, 4, 'Taariikhda funka somalida');

-- --------------------------------------------------------

--
-- Table structure for table `catagories`
--

CREATE TABLE `catagories` (
  `cat_no` int(11) NOT NULL,
  `cat_name` varchar(50) NOT NULL,
  `Description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `catagories`
--

INSERT INTO `catagories` (`cat_no`, `cat_name`, `Description`) VALUES
(1, 'Noval', 'sheeko faneedyo'),
(2, 'History', 'Taariikh'),
(3, 'math', 'xisabaad'),
(4, 'physics', 'fghjkl'),
(5, 'somali', 'sheeko-xarir'),
(6, 'fghj', 'ghj'),
(7, 'dheere', 'ghjkl'),
(8, 'cumR', 'TYUI'),
(9, 'faarah', 'dfghj'),
(10, 'arts', 'fghj');

-- --------------------------------------------------------

--
-- Table structure for table `charges`
--

CREATE TABLE `charges` (
  `ch_no` int(11) NOT NULL,
  `book_no` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `date_ch` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `charges`
--

INSERT INTO `charges` (`ch_no`, `book_no`, `id`, `amount`, `date_ch`) VALUES
(1, 1, 1, '12.00', '2024-05-08'),
(3, 5, 2, '100.00', '2024-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `dalacaad`
--

CREATE TABLE `dalacaad` (
  `ch_no` int(11) NOT NULL,
  `am_no` int(11) NOT NULL,
  `week_no` int(11) NOT NULL,
  `date_charge` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `dalacaad`
--

INSERT INTO `dalacaad` (`ch_no`, `am_no`, `week_no`, `date_charge`) VALUES
(1, 1, 2, '2024-05-27'),
(6, 5, 2, '2024-05-26'),
(15, 6, 1, '2024-06-12'),
(16, 3, 3, '2024-06-12'),
(18, 5, 1, '2024-06-12'),
(19, 6, 4, '2024-06-13'),
(20, 12, 1, '2024-06-22'),
(21, 6, 2, '2024-06-22'),
(22, 11, 4, '2024-06-22'),
(25, 9, 2, '2024-06-24');

-- --------------------------------------------------------

--
-- Table structure for table `expence_payment`
--

CREATE TABLE `expence_payment` (
  `exp_pay` int(11) NOT NULL,
  `ex_ch` int(11) NOT NULL,
  `amount` double NOT NULL,
  `acc_no` int(11) NOT NULL,
  `ex_pay_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expence_payment`
--

INSERT INTO `expence_payment` (`exp_pay`, `ex_ch`, `amount`, `acc_no`, `ex_pay_date`) VALUES
(1, 1, 100, 1, '2024-06-09');

--
-- Triggers `expence_payment`
--
DELIMITER $$
CREATE TRIGGER `exp_pay_trig` AFTER INSERT ON `expence_payment` FOR EACH ROW BEGIN
UPDATE account SET balance = balance - new.amount where acc_no = new.acc_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `expenses`
--

CREATE TABLE `expenses` (
  `exp_no` int(11) NOT NULL,
  `exp_name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expenses`
--

INSERT INTO `expenses` (`exp_no`, `exp_name`) VALUES
(4, 'Canshuur'),
(3, 'koronto'),
(2, 'Salary'),
(1, 'utilities');

-- --------------------------------------------------------

--
-- Table structure for table `expense_charge`
--

CREATE TABLE `expense_charge` (
  `ch_no` int(11) NOT NULL,
  `exp_no` int(11) NOT NULL,
  `amount` double NOT NULL,
  `description` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `expense_charge`
--

INSERT INTO `expense_charge` (`ch_no`, `exp_no`, `amount`, `description`) VALUES
(1, 3, 100, 'alaaab aan soo gatay'),
(2, 1, 23, 'EWWE'),
(3, 1, 233, 'sadsa'),
(4, 2, 11, 'EWWE'),
(5, 2, 1113, 'fghjkl'),
(6, 4, 50, 'dfghj');

-- --------------------------------------------------------

--
-- Table structure for table `lacag_bixin`
--

CREATE TABLE `lacag_bixin` (
  `pay_no` int(11) NOT NULL,
  `por_no` int(11) NOT NULL,
  `amount` decimal(10,0) NOT NULL,
  `acc_no` int(11) NOT NULL,
  `pay_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `lacag_bixin`
--

INSERT INTO `lacag_bixin` (`pay_no`, `por_no`, `amount`, `acc_no`, `pay_date`) VALUES
(2, 1, '15', 5, '2024-06-03'),
(4, 2, '199', 7, '2024-06-03'),
(5, 3, '398', 1, '2024-06-02'),
(6, 3, '80', 1, '2024-06-03'),
(7, 8, '50', 1, '2024-06-12');

--
-- Triggers `lacag_bixin`
--
DELIMITER $$
CREATE TRIGGER `exp_payment` AFTER INSERT ON `lacag_bixin` FOR EACH ROW BEGIN
UPDATE account SET balance = balance - new.amount where acc_no = new.acc_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `options`
--

CREATE TABLE `options` (
  `op_id` int(11) NOT NULL,
  `option_name` varchar(50) NOT NULL,
  `faahfaahin` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `options`
--

INSERT INTO `options` (`op_id`, `option_name`, `faahfaahin`) VALUES
(1, 'student', 'ardaynimo'),
(2, 'teacher', 'macalin'),
(3, 'others', 'Midna');

-- --------------------------------------------------------

--
-- Table structure for table `payments`
--

CREATE TABLE `payments` (
  `pay_no` int(11) NOT NULL,
  `ch_no` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `acc_no` int(11) NOT NULL,
  `pay_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `payments`
--

INSERT INTO `payments` (`pay_no`, `ch_no`, `amount`, `acc_no`, `pay_date`) VALUES
(1, 1, '100.00', 1, '2024-05-14'),
(2, 1, '23.00', 1, '2024-09-09'),
(3, 3, '80.00', 1, '2024-05-19'),
(4, 3, '200.00', 1, '2024-06-03');

--
-- Triggers `payments`
--
DELIMITER $$
CREATE TRIGGER `pay_trig` AFTER INSERT ON `payments` FOR EACH ROW BEGIN
UPDATE account SET balance = balance - new.amount where acc_no = new.acc_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `purchase`
--

CREATE TABLE `purchase` (
  `por_no` int(11) NOT NULL,
  `book_no` int(11) NOT NULL,
  `Quantity` int(11) NOT NULL,
  `cost` double NOT NULL,
  `discount` double NOT NULL,
  `taariikh` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase`
--

INSERT INTO `purchase` (`por_no`, `book_no`, `Quantity`, `cost`, `discount`, `taariikh`) VALUES
(1, 2, 90, 3, 0, '2024-05-01'),
(2, 3, 1, 4, 1, '2024-02-02'),
(3, 3, 1, 4, 2, '2024-01-03'),
(4, 4, 1, 2, 1, '2023-01-01'),
(5, 5, 2, 5, 0, '2024-05-18'),
(6, 7, 15, 8, 0, '2024-06-12'),
(7, 8, 5, 6, 0, '2024-06-12'),
(8, 9, 10, 5, 0, '2024-06-12');

-- --------------------------------------------------------

--
-- Table structure for table `purchase_return`
--

CREATE TABLE `purchase_return` (
  `pur_ret_no` int(11) NOT NULL,
  `por_no` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `reason` varchar(40) DEFAULT NULL,
  `return_Date` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `purchase_return`
--

INSERT INTO `purchase_return` (`pur_ret_no`, `por_no`, `qty`, `reason`, `return_Date`) VALUES
(6, 5, 1, 'Failled', '2024-06-12'),
(7, 4, 1, 'Failled', '2024-06-12'),
(8, 6, 4, 'Loss', '2024-06-12'),
(9, 7, 5, 'Not needed', '2024-06-12'),
(10, 8, 5, 'Failled', '2024-06-12'),
(13, 1, 3, 'Not needed', '2024-06-13');

--
-- Triggers `purchase_return`
--
DELIMITER $$
CREATE TRIGGER `purch_return_trig` AFTER INSERT ON `purchase_return` FOR EACH ROW BEGIN
    UPDATE purchase SET Quantity = Quantity - NEW.qty WHERE por_no = NEW.por_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `qaadasho`
--

CREATE TABLE `qaadasho` (
  `am_no` int(11) NOT NULL,
  `book_no` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `price` int(11) NOT NULL,
  `first_date` date NOT NULL,
  `last_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qaadasho`
--

INSERT INTO `qaadasho` (`am_no`, `book_no`, `id`, `qty`, `price`, `first_date`, `last_date`) VALUES
(1, 3, 1, 1, 1, '2024-05-27', '2024-05-28'),
(3, 5, 4, 3, 3, '2024-05-27', '2024-05-30'),
(5, 2, 2, 4, 3, '2024-05-27', '2024-05-28'),
(6, 7, 5, 3, 4, '2024-06-04', '2024-06-05'),
(9, 10, 1, 1, 2, '2024-06-20', '2024-06-27'),
(10, 2, 6, 3, 5, '2024-05-27', '2024-05-30'),
(11, 1, 4, 1, 2, '2024-06-20', '2024-06-27'),
(12, 9, 2, 1, 12, '2024-05-27', '2024-05-30');

-- --------------------------------------------------------

--
-- Table structure for table `qabasho`
--

CREATE TABLE `qabasho` (
  `rec_no` int(11) NOT NULL,
  `ch_no` int(11) NOT NULL,
  `Amount` double NOT NULL,
  `acc_no` int(11) NOT NULL,
  `rec_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `qabasho`
--

INSERT INTO `qabasho` (`rec_no`, `ch_no`, `Amount`, `acc_no`, `rec_date`) VALUES
(7, 1, 15, 2, '2024-06-03'),
(8, 6, 199, 1, '2024-06-03'),
(9, 16, 1, 1, '2024-02-01'),
(10, 18, 1, 5, '2024-06-22'),
(11, 1, 3, 5, '2024-06-22'),
(12, 19, 3, 5, '2024-06-22'),
(13, 25, 5, 1, '2024-06-24');

--
-- Triggers `qabasho`
--
DELIMITER $$
CREATE TRIGGER `recip_trig` AFTER INSERT ON `qabasho` FOR EACH ROW BEGIN
UPDATE account SET balance = balance + new.amount where acc_no = new.acc_no;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `receipt`
--

CREATE TABLE `receipt` (
  `rec_no` int(11) NOT NULL,
  `am_no` int(11) NOT NULL,
  `ch_no` int(11) NOT NULL,
  `amah_amount` decimal(10,2) NOT NULL,
  `charge_amount` decimal(10,2) NOT NULL,
  `acc_no` int(11) NOT NULL,
  `rec_date` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `receipt`
--

INSERT INTO `receipt` (`rec_no`, `am_no`, `ch_no`, `amah_amount`, `charge_amount`, `acc_no`, `rec_date`) VALUES
(1, 1, 1, '12.00', '12.00', 1, '2024-05-14'),
(3, 1, 1, '2.00', '3.00', 1, '2024-01-03'),
(4, 1, 3, '50.00', '30.00', 5, '2024-05-19');

-- --------------------------------------------------------

--
-- Table structure for table `registration`
--

CREATE TABLE `registration` (
  `id` int(11) NOT NULL,
  `name` varchar(60) NOT NULL,
  `tell` varchar(30) NOT NULL,
  `add_no` int(11) NOT NULL,
  `option_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `registration`
--

INSERT INTO `registration` (`id`, `name`, `tell`, `add_no`, `option_id`) VALUES
(1, 'dheere', '09877656545', 1, 1),
(2, 'ayub', '615401784', 3, 1),
(4, 'omar-bashir', '345678', 1, 1),
(5, 'faarah', '987654', 3, 1),
(6, 'axmed', '87888', 2, 1),
(7, 'cali', '37238', 3, 2),
(8, 'qwdasasd', '9876655', 1, 1),
(9, 'geedi', '37238', 3, 3),
(13, 'Saido', '56789098', 3, 3);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `username`, `password`, `email`, `user_id`) VALUES
(1, 'groupe', 'c3a91d', 'nabadoonka221@gmail.com', 1),
(2, 'dfghj', '444', 'dfgh', 1),
(3, 'mb', '34567', 'fghj', 1),
(4, 'bashka', 'zayid', 'maahirzein06@gmail.com', 2),
(5, 'dayax', '12345678', 'maahirzein06@gmail.com', 3),
(6, 'prof', '3322', 'saakuut@gmail.com', 1),
(7, 'apdala', '1235', 'fghjkl', 2),
(8, 'Eng-ximaani', '1211', 'maahirzein06@gmail.com', 2),
(9, 'faaa', '12345', 'fghjk', 3);

-- --------------------------------------------------------

--
-- Table structure for table `user_type`
--

CREATE TABLE `user_type` (
  `user_id` int(11) NOT NULL,
  `type` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user_type`
--

INSERT INTO `user_type` (`user_id`, `type`) VALUES
(1, 'teacher'),
(2, 'student'),
(3, 'midna');

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_view`
-- (See below for the actual view)
--
CREATE TABLE `user_view` (
`user_id` int(11)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `user_views`
-- (See below for the actual view)
--
CREATE TABLE `user_views` (
`user_id` int(11)
,`username` varchar(50)
,`type` varchar(50)
);

-- --------------------------------------------------------

--
-- Stand-in structure for view `u_view`
-- (See below for the actual view)
--
CREATE TABLE `u_view` (
`user_id` int(11)
,`type` varchar(50)
);

-- --------------------------------------------------------

--
-- Table structure for table `weeklly_charged`
--

CREATE TABLE `weeklly_charged` (
  `week_no` int(11) NOT NULL,
  `week_name` varchar(50) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `weeklly_charged`
--

INSERT INTO `weeklly_charged` (`week_no`, `week_name`, `price`) VALUES
(1, 'on time', 0),
(2, 'week one', 2.5),
(3, 'week two', 5),
(4, 'week three', 7.5),
(5, 'week four', 10);

-- --------------------------------------------------------

--
-- Table structure for table `weeklly_price`
--

CREATE TABLE `weeklly_price` (
  `week_no` int(11) NOT NULL,
  `week_name` varchar(40) NOT NULL,
  `price` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `weeklly_price`
--

INSERT INTO `weeklly_price` (`week_no`, `week_name`, `price`) VALUES
(1, 'One week', 5),
(2, 'Two week', 10),
(3, 'Three week', 15),
(4, 'Four week', 20);

-- --------------------------------------------------------

--
-- Structure for view `address_view`
--
DROP TABLE IF EXISTS `address_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `address_view`  AS SELECT `address`.`add_no` AS `add_no`, `address`.`district` AS `district`, `address`.`village` AS `village`, `address`.`zone` AS `zone` FROM `address` ;

-- --------------------------------------------------------

--
-- Structure for view `user_view`
--
DROP TABLE IF EXISTS `user_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_view`  AS SELECT `ut`.`user_id` AS `user_id` FROM (`users` `u` join `user_type` `ut` on(`ut`.`user_id` = `u`.`user_id`)) WHERE `u`.`user_id` <> 0 ;

-- --------------------------------------------------------

--
-- Structure for view `user_views`
--
DROP TABLE IF EXISTS `user_views`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `user_views`  AS SELECT `ut`.`user_id` AS `user_id`, `u`.`username` AS `username`, `ut`.`type` AS `type` FROM (`users` `u` join `user_type` `ut`) WHERE `ut`.`user_id` = `u`.`user_id` ;

-- --------------------------------------------------------

--
-- Structure for view `u_view`
--
DROP TABLE IF EXISTS `u_view`;

CREATE ALGORITHM=UNDEFINED DEFINER=`root`@`localhost` SQL SECURITY DEFINER VIEW `u_view`  AS SELECT `ut`.`user_id` AS `user_id`, `ut`.`type` AS `type` FROM (`user_type` `ut` join `users` `u`) WHERE `u`.`user_id` = `ut`.`user_id` ;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `account`
--
ALTER TABLE `account`
  ADD PRIMARY KEY (`acc_no`);

--
-- Indexes for table `address`
--
ALTER TABLE `address`
  ADD PRIMARY KEY (`add_no`),
  ADD KEY `add_index` (`district`,`village`,`zone`);

--
-- Indexes for table `amaah`
--
ALTER TABLE `amaah`
  ADD PRIMARY KEY (`am_no`),
  ADD KEY `cons_fk2_am` (`book_no`),
  ADD KEY `cons_fk5_am` (`id`);

--
-- Indexes for table `author`
--
ALTER TABLE `author`
  ADD PRIMARY KEY (`auth_no`),
  ADD KEY `auth_index` (`auth_no`,`auth_name`);

--
-- Indexes for table `books`
--
ALTER TABLE `books`
  ADD PRIMARY KEY (`book_no`),
  ADD KEY `index_b` (`ISB`,`title`),
  ADD KEY `con_fk1_b` (`cat_no`),
  ADD KEY `con_fk2_b` (`auth_no`);

--
-- Indexes for table `catagories`
--
ALTER TABLE `catagories`
  ADD PRIMARY KEY (`cat_no`),
  ADD KEY `cat_index` (`cat_no`,`cat_name`);

--
-- Indexes for table `charges`
--
ALTER TABLE `charges`
  ADD PRIMARY KEY (`ch_no`),
  ADD KEY `cons_fk2_ch` (`book_no`),
  ADD KEY `cons_fk5_ch` (`id`);

--
-- Indexes for table `dalacaad`
--
ALTER TABLE `dalacaad`
  ADD PRIMARY KEY (`ch_no`),
  ADD KEY `cons_fk1_dal` (`am_no`),
  ADD KEY `dal_cons_fk` (`week_no`);

--
-- Indexes for table `expence_payment`
--
ALTER TABLE `expence_payment`
  ADD PRIMARY KEY (`exp_pay`),
  ADD KEY `cons_fk1_exp` (`ex_ch`),
  ADD KEY `cons_fk2_exp` (`acc_no`);

--
-- Indexes for table `expenses`
--
ALTER TABLE `expenses`
  ADD PRIMARY KEY (`exp_no`),
  ADD KEY `exp_index` (`exp_name`);

--
-- Indexes for table `expense_charge`
--
ALTER TABLE `expense_charge`
  ADD PRIMARY KEY (`ch_no`),
  ADD KEY `con_fk1_exp` (`exp_no`);

--
-- Indexes for table `lacag_bixin`
--
ALTER TABLE `lacag_bixin`
  ADD PRIMARY KEY (`pay_no`),
  ADD KEY `fk1_pur` (`por_no`),
  ADD KEY `fk1_acc` (`acc_no`);

--
-- Indexes for table `options`
--
ALTER TABLE `options`
  ADD PRIMARY KEY (`op_id`);

--
-- Indexes for table `payments`
--
ALTER TABLE `payments`
  ADD PRIMARY KEY (`pay_no`),
  ADD KEY `cons_fk2_pay` (`ch_no`),
  ADD KEY `cons_fk3_pay` (`acc_no`);

--
-- Indexes for table `purchase`
--
ALTER TABLE `purchase`
  ADD PRIMARY KEY (`por_no`),
  ADD KEY `cons_fk1_pur` (`book_no`);

--
-- Indexes for table `purchase_return`
--
ALTER TABLE `purchase_return`
  ADD PRIMARY KEY (`pur_ret_no`),
  ADD KEY `cons_fk1_pr` (`por_no`);

--
-- Indexes for table `qaadasho`
--
ALTER TABLE `qaadasho`
  ADD PRIMARY KEY (`am_no`),
  ADD KEY `cons_fk1_qa` (`book_no`),
  ADD KEY `cons_fk2_qa` (`id`),
  ADD KEY `con_fk_pri` (`price`);

--
-- Indexes for table `qabasho`
--
ALTER TABLE `qabasho`
  ADD PRIMARY KEY (`rec_no`),
  ADD KEY `cons_fk1_qq` (`acc_no`),
  ADD KEY `cons_fk3_qq` (`ch_no`);

--
-- Indexes for table `receipt`
--
ALTER TABLE `receipt`
  ADD PRIMARY KEY (`rec_no`),
  ADD KEY `cons_fk1_rec` (`am_no`),
  ADD KEY `cons_fk2_rec` (`ch_no`),
  ADD KEY `cons_fk3_rec` (`acc_no`);

--
-- Indexes for table `registration`
--
ALTER TABLE `registration`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fk1_r` (`add_no`),
  ADD KEY `cons_fk2_r` (`option_id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD KEY `cons_fk1_us` (`user_id`);

--
-- Indexes for table `user_type`
--
ALTER TABLE `user_type`
  ADD PRIMARY KEY (`user_id`);

--
-- Indexes for table `weeklly_charged`
--
ALTER TABLE `weeklly_charged`
  ADD PRIMARY KEY (`week_no`);

--
-- Indexes for table `weeklly_price`
--
ALTER TABLE `weeklly_price`
  ADD PRIMARY KEY (`week_no`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `account`
--
ALTER TABLE `account`
  MODIFY `acc_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `address`
--
ALTER TABLE `address`
  MODIFY `add_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `amaah`
--
ALTER TABLE `amaah`
  MODIFY `am_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `author`
--
ALTER TABLE `author`
  MODIFY `auth_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `books`
--
ALTER TABLE `books`
  MODIFY `book_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `catagories`
--
ALTER TABLE `catagories`
  MODIFY `cat_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- AUTO_INCREMENT for table `charges`
--
ALTER TABLE `charges`
  MODIFY `ch_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `dalacaad`
--
ALTER TABLE `dalacaad`
  MODIFY `ch_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `expence_payment`
--
ALTER TABLE `expence_payment`
  MODIFY `exp_pay` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `expenses`
--
ALTER TABLE `expenses`
  MODIFY `exp_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `expense_charge`
--
ALTER TABLE `expense_charge`
  MODIFY `ch_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `lacag_bixin`
--
ALTER TABLE `lacag_bixin`
  MODIFY `pay_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `options`
--
ALTER TABLE `options`
  MODIFY `op_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `payments`
--
ALTER TABLE `payments`
  MODIFY `pay_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `purchase`
--
ALTER TABLE `purchase`
  MODIFY `por_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `purchase_return`
--
ALTER TABLE `purchase_return`
  MODIFY `pur_ret_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `qaadasho`
--
ALTER TABLE `qaadasho`
  MODIFY `am_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- AUTO_INCREMENT for table `qabasho`
--
ALTER TABLE `qabasho`
  MODIFY `rec_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `receipt`
--
ALTER TABLE `receipt`
  MODIFY `rec_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `registration`
--
ALTER TABLE `registration`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `user_type`
--
ALTER TABLE `user_type`
  MODIFY `user_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `weeklly_charged`
--
ALTER TABLE `weeklly_charged`
  MODIFY `week_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `weeklly_price`
--
ALTER TABLE `weeklly_price`
  MODIFY `week_no` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `amaah`
--
ALTER TABLE `amaah`
  ADD CONSTRAINT `cons_fk2_am` FOREIGN KEY (`book_no`) REFERENCES `books` (`book_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk5_am` FOREIGN KEY (`id`) REFERENCES `registration` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `books`
--
ALTER TABLE `books`
  ADD CONSTRAINT `con_fk1_b` FOREIGN KEY (`cat_no`) REFERENCES `catagories` (`cat_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `con_fk2_b` FOREIGN KEY (`auth_no`) REFERENCES `author` (`auth_no`) ON UPDATE CASCADE;

--
-- Constraints for table `charges`
--
ALTER TABLE `charges`
  ADD CONSTRAINT `cons_fk2_ch` FOREIGN KEY (`book_no`) REFERENCES `books` (`book_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk5_ch` FOREIGN KEY (`id`) REFERENCES `registration` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `dalacaad`
--
ALTER TABLE `dalacaad`
  ADD CONSTRAINT `cons_fk1_dal` FOREIGN KEY (`am_no`) REFERENCES `qaadasho` (`am_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `dal_cons_fk` FOREIGN KEY (`week_no`) REFERENCES `weeklly_charged` (`week_no`) ON UPDATE CASCADE;

--
-- Constraints for table `expence_payment`
--
ALTER TABLE `expence_payment`
  ADD CONSTRAINT `cons_fk1_exp` FOREIGN KEY (`ex_ch`) REFERENCES `expense_charge` (`ch_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk2_exp` FOREIGN KEY (`acc_no`) REFERENCES `account` (`acc_no`) ON UPDATE CASCADE;

--
-- Constraints for table `expense_charge`
--
ALTER TABLE `expense_charge`
  ADD CONSTRAINT `con_fk1_exp` FOREIGN KEY (`exp_no`) REFERENCES `expenses` (`exp_no`) ON UPDATE CASCADE;

--
-- Constraints for table `lacag_bixin`
--
ALTER TABLE `lacag_bixin`
  ADD CONSTRAINT `fk1_acc` FOREIGN KEY (`acc_no`) REFERENCES `account` (`acc_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `fk1_pur` FOREIGN KEY (`por_no`) REFERENCES `purchase` (`por_no`) ON UPDATE CASCADE;

--
-- Constraints for table `payments`
--
ALTER TABLE `payments`
  ADD CONSTRAINT `cons_fk2_pay` FOREIGN KEY (`ch_no`) REFERENCES `expense_charge` (`ch_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk3_pay` FOREIGN KEY (`acc_no`) REFERENCES `account` (`acc_no`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase`
--
ALTER TABLE `purchase`
  ADD CONSTRAINT `cons_fk1_pur` FOREIGN KEY (`book_no`) REFERENCES `books` (`book_no`) ON UPDATE CASCADE;

--
-- Constraints for table `purchase_return`
--
ALTER TABLE `purchase_return`
  ADD CONSTRAINT `cons_fk1_pr` FOREIGN KEY (`por_no`) REFERENCES `purchase` (`por_no`) ON UPDATE CASCADE;

--
-- Constraints for table `qaadasho`
--
ALTER TABLE `qaadasho`
  ADD CONSTRAINT `cons_fk1_qa` FOREIGN KEY (`book_no`) REFERENCES `books` (`book_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk2_qa` FOREIGN KEY (`id`) REFERENCES `registration` (`id`) ON UPDATE CASCADE;

--
-- Constraints for table `qabasho`
--
ALTER TABLE `qabasho`
  ADD CONSTRAINT `cons_fk1_qq` FOREIGN KEY (`acc_no`) REFERENCES `account` (`acc_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk3_qq` FOREIGN KEY (`ch_no`) REFERENCES `dalacaad` (`ch_no`) ON UPDATE CASCADE;

--
-- Constraints for table `receipt`
--
ALTER TABLE `receipt`
  ADD CONSTRAINT `cons_fk1_rec` FOREIGN KEY (`am_no`) REFERENCES `amaah` (`am_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk2_rec` FOREIGN KEY (`ch_no`) REFERENCES `charges` (`ch_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk3_rec` FOREIGN KEY (`acc_no`) REFERENCES `account` (`acc_no`) ON UPDATE CASCADE;

--
-- Constraints for table `registration`
--
ALTER TABLE `registration`
  ADD CONSTRAINT `cons_fk1_r` FOREIGN KEY (`add_no`) REFERENCES `address` (`add_no`) ON UPDATE CASCADE,
  ADD CONSTRAINT `cons_fk2_r` FOREIGN KEY (`option_id`) REFERENCES `options` (`op_id`) ON UPDATE CASCADE;

--
-- Constraints for table `users`
--
ALTER TABLE `users`
  ADD CONSTRAINT `cons_fk1_us` FOREIGN KEY (`user_id`) REFERENCES `user_type` (`user_id`) ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
