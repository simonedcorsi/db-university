CREATE DATABASE db_university;
USE db_university;

/*Selezionare tutti gli studenti nati nel 1990 (160)*/
SELECT *
FROM students
WHERE YEAR(date_of_birth) = 1990;

/*Selezionare tutti i corsi che valgono più di 10 crediti (479)*/
SELECT *
FROM courses
WHERE cfu > 10;

/*Selezionare tutti gli studenti che hanno più di 30 anni*/
SELECT *
FROM students
WHERE timestampdiff(YEAR, `date_of_birth`, CURDATE()) > 30;

/*Selezionare tutti i corsi del primo semestre del primo anno di un qualsiasi corso di laurea (286)*/
SELECT *
FROM courses
WHERE period = 'I semestre'
AND YEAR = 1;

/*Selezionare tutti gli appelli d'esame che avvengono nel pomeriggio (dopo le 14) del 20/06/2020 (21)*/
SELECT *
FROM exams
WHERE date = '2020-06-20'
AND HOUR(hour) >= 14;

/*Selezionare tutti i corsi di laurea magistrale (38)*/
SELECT *
FROM degrees
WHERE level = 'magistrale';

/*Da quanti dipartimenti è composta l'università?*/
SELECT *
FROM departments;

/*Quanti sono gli insegnanti che non hanno un numero di telefono?*/
SELECT *
FROM teachers
WHERE phone IS NULL;

/*---------------------------------------------------------------------------------*/

/*Contare quanti iscritti ci sono stati ogni anno*/
SELECT COUNT(*) AS `numero_inscritti`, YEAR(`enrolment_date`) AS `anno`
FROM students
GROUP BY anno;

/*Contare gli insegnanti che hanno l'ufficio nello stesso edificio*/
SELECT COUNT(*) AS `numero_insegnanti`, `office_address`
FROM teachers
GROUP BY office_address;

/*Calcolare la media dei voti di ogni appello d'esame*/
SELECT AVG(`vote`), `exam_id`
FROM `exam_student`
GROUP BY `exam_id`;

/*Contare quanti corsi di laurea ci sono per ogni dipartimento*/
SELECT count(*) AS `numero_corsi_laurea`, `department_id`
FROM `degrees`
GROUP BY `department_id`;

/*---------------------JOIN-----------------------*/

/*1. Selezionare tutti gli studenti iscritti al Corso di Laurea in Economia*/
SELECT*
FROM students
JOIN degrees ON students.degree_id = degrees.id
WHERE degrees.name = 'Corso di Laurea in Economia';

/*2. Selezionare tutti i Corsi di Laurea Magistrale del Dipartimento di Neuroscienze*/
SELECT*
FROM degrees
JOIN departments ON degrees.department_id = departments.id
WHERE degrees.level = 'magistrale'
AND departments.name LIKE '%Neuroscienze%';

/*3. Selezionare tutti i corsi in cui insegna Fulvio Amato (id=44)*/
SELECT*
FROM courses
JOIN course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON course_teacher.teacher_id = teachers.id
WHERE teachers.name = 'Fulvio' AND surname = 'Amato';

/*4. Selezionare tutti gli studenti con i dati relativi al corso di laurea a cui
sono iscritti e il relativo dipartimento, in ordine alfabetico per cognome e
nome*/
SELECT students.*, departments.*
FROM students
JOIN degrees ON students.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
ORDER BY students.surname, students.name;

/*5. Selezionare tutti i corsi di laurea con i relativi corsi e insegnanti*/
SELECT*
FROM degrees
JOIN courses ON degrees.id = courses.degree_id
JOIN Course_teacher ON courses.id = course_teacher.course_id
JOIN teachers ON teachers.id = course_teacher.teacher_id;

/*6. Selezionare tutti i docenti che insegnano nel Dipartimento di
Matematica (54)*/
SELECT DISTINCT teachers.name, teachers.surname
FROM teachers
JOIN course_teacher ON teachers.id = course_teacher.teacher_id
JOIN courses ON courses.id = course_teacher.course_id
JOIN degrees ON courses.degree_id = degrees.id
JOIN departments ON degrees.department_id = departments.id
WHERE departments.name = 'Dipartimento di Matematica';




