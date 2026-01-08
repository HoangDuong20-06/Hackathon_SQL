SET SQL_SAFE_UPDATES = 0;
DROP DATABASE IF EXISTS HN_CNTT1_VuNguyenHoangDuong_03;
CREATE DATABASE HN_CNTT1_VuNguyenHoangDuong_03;
USE HN_CNTT1_VuNguyenHoangDuong_03;
-- Bảng Patient
CREATE TABLE Patients(
  patient_id VARCHAR(5) PRIMARY KEY NOT NULL,
  patient_full_name VARCHAR(100),
  patient_dob DATE,
  patient_gender VARCHAR(10),
  patient_phone VARCHAR(15) UNIQUE
);
-- Bảng Doctor
CREATE TABLE Doctors (
  doctor_id VARCHAR(5) PRIMARY KEY NOT NULL,
  doctor_full_name VARCHAR(100),
  doctor_specialty VARCHAR(100),
  doctor_phone VARCHAR(15) UNIQUE
);
-- Bảng Departments
CREATE TABLE Departments (
  department_id VARCHAR(5) PRIMARY KEY NOT NULL,
  department_name VARCHAR(100) UNIQUE,
  department_location VARCHAR(100)
);
-- Bảng Appointments
CREATE TABLE Appointments (
  appointment_id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
  patient_id VARCHAR(5),
  doctor_id VARCHAR(5),
  department_id VARCHAR(5),
  appointment_date DATE,
  appointment_status VARCHAR(20),
  FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
  FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id),
  FOREIGN KEY (department_id) REFERENCES departments(department_id)
);
-- Dữ liệu patients
INSERT INTO patients (patient_id ,patient_full_name, patient_dob, patient_gender, patient_phone) VALUES
("P001","Nguyễn Văn An","1995-03-15","Nam","0912345678"),
("P002","Trần Thị Bích","1998-07-22","Nữ","0923456789"),
("P003","Lê Hoàng Minh","1987-11-05","Nam","0934567890"),
("P004","Phạm Thu Hà","2000-01-18","Nữ","0945678901"),
("P005","Võ Quốc Huy","1992-09-30","Nam","0956789012");
-- Dữ liệu doctors
INSERT INTO doctors (doctor_id, doctor_full_name, doctor_specialty, doctor_phone) VALUES
("D001","BS. Nguyễn Thanh Tùng","Nội khoa","0901112222"),
("D002","BS. Trần Minh Đức","Ngoại khoa","0902223333"),
("D003","BS. Lê Thị Lan","Nhi khoa","0903334444"),
("D004","BS. Phạm Quốc Bảo","Tim mạch","0904445555"),
("D005","BS. Võ Hoàng Yến","Da liễu","0905556666");
-- Dữ liệu departments
INSERT INTO departments (department_id, department_name, department_location) VALUES
("DP01","Khoa Nội","Tầng 1"),
("DP02","Khoa Ngoại","Tầng 2"),
("DP03","Khoa Nhi","Tầng 3"),
("DP04","Khoa Tim mạch","Tầng 4"),
("DP05","Khoa Da liễu","Tầng 5");
-- Dữ liệu appointments
INSERT INTO appointments (appointment_id, patient_id, doctor_id, department_id, appointment_date, appointment_status) VALUES
("1","P001","D001","DP01","2025-10-01","Completed"),
("2","P002","D002","DP02","2025-10-02","Completed"),
("3","P003","D003","DP03","2025-10-03","Pending"),
("4","P004","D004","DP04","2025-10-04","Cancelled"),
("5","P005","D005","DP05","2025-10-05","Completed");
-- Cập nhật thông tin bệnh nhân
UPDATE patients SET patient_phone = "096536868" WHERE patient_id = "P003";
-- Cập nhật thông tin bệnh nhân
UPDATE appointments SET appointment_status = "Cancelled" WHERE appointment_id = "3";
--  Xóa dữ liệu có điều kiện
DELETE FROM appointments WHERE appointment_status = "Cancelled" AND appointment_date < "2025-10-04";
--  Liệt kê danh sách lịch hẹn
SELECT * FROM appointments WHERE appointment_status = "Completed" AND appointment_date > "2025-10-01";
-- Lấy thông tin 
SELECT * FROM patients WHERE patient_phone HAVING "09";
-- Hiển thị danh sách tất cả các lịch hẹn giảm dần
SELECT appointment_id,patient_id,appointment_date FROM appointments ORDER BY appointment_date DESC;
-- Lấy 3 bản ghi đầu tiên
SELECT * FROM appointments WHERE appointment_status = "Completed" LIMIT 3 OFFSET 0;
-- Hiển thị thông tin  bỏ qua 2 bản ghi đầu tiên và lấy 3 bản ghi tiếp theo
SELECT patient_id,patient_full_name FROM patients LIMIT 3 OFFSET 2;
-- Truy vấn nâng cao
-- Hiển thị danh sách lịch
SELECT a.appointment_id, a.doctor_id, a.appointment_date, p.patient_full_name 
FROM  appointments a
JOIN patients p ON a.patient_id = p.patient_id
WHERE a.appointment_status = "Completed";
-- Liệt kê tất cả các bác sĩ trong hệ thống
SELECT d.doctor_id, d.doctor_full_name ,a.appointment_id 
FROM appointments a
JOIN doctors d ON a.doctor_id = d.doctor_id;
-- Tính tổng số lịch hẹn
SELECT appointment_status

-- Thống kê số lượng lịch hẹn của mỗi bệnh nhân

-- Lấy thông tin các lịch hẹn muộn hơn ngày hẹn trung bình của tất cả các lịch hẹn

-- Hiển thị patient_full_name và patient_phone của những bệnh nhân đã từng khám tại khoa có department_name là “Khoa nội”
SELECT patient_full_name ,patient_phone,department_name
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN departments de ON a.department_id = de.department_id
WHERE de.department_name = "Khoa nội";
-- Hiển thị thông tin tổng hợp gồm: appointment_id, patient_full_name, doctor_full_name, department_name và appointment_status.
SELECT a.appointment_id, p.patient_full_name, d.doctor_full_name, de.department_name , a.appointment_status
FROM appointments a
JOIN patients p ON a.patient_id = p.patient_id
JOIN doctors d ON a.doctor_id = d.doctor_id
JOIn departments de ON a.department_id = de.department_id;
SET SQL_SAFE_UPDATES = 1;