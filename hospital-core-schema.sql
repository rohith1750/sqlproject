-- 1. Patients table - Core table for patient information
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    gender CHAR(1),
    blood_group VARCHAR(5),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    address TEXT,
    emergency_contact VARCHAR(100),
    emergency_contact_number VARCHAR(15),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Staff table - Manages doctors and other medical staff
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    department VARCHAR(50),
    specialization VARCHAR(100),
    contact_number VARCHAR(15),
    email VARCHAR(100),
    status VARCHAR(20) DEFAULT 'Active'
);

-- 3. Appointments table - Manages patient appointments
CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    appointment_date DATE,
    appointment_time TIME,
    purpose VARCHAR(200),
    status VARCHAR(20) DEFAULT 'Scheduled',
    notes TEXT,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- 4. Medical_Records table - Stores patient medical history
CREATE TABLE Medical_Records (
    record_id INT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    visit_date DATE,
    diagnosis TEXT,
    prescription TEXT,
    notes TEXT,
    follow_up_date DATE,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- 5. Admissions table - Manages patient admissions
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT,
    staff_id INT,
    room_number VARCHAR(10),
    admission_date DATETIME,
    discharge_date DATETIME,
    diagnosis TEXT,
    status VARCHAR(20) DEFAULT 'Admitted',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (staff_id) REFERENCES Staff(staff_id)
);

-- 6. Billing table - Handles payment records
CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    patient_id INT,
    admission_id INT NULL,
    appointment_id INT NULL,
    amount DECIMAL(10,2),
    payment_status VARCHAR(20) DEFAULT 'Pending',
    payment_date DATETIME,
    payment_method VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id),
    FOREIGN KEY (appointment_id) REFERENCES Appointments(appointment_id)
);

-- Creating essential indexes for better performance
CREATE INDEX idx_patient_name ON Patients(last_name, first_name);
CREATE INDEX idx_staff_name ON Staff(last_name, first_name);
CREATE INDEX idx_appointment_date ON Appointments(appointment_date);
CREATE INDEX idx_admission_date ON Admissions(admission_date);
CREATE INDEX idx_billing_status ON Billing(payment_status);
