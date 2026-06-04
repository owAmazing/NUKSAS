-- ========================================
-- 第十組資料庫系統 MySQL Schema
-- ========================================

-- 建立資料庫
CREATE DATABASE IF NOT EXISTS scholarship_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE scholarship_system;

-- ========================================
-- 主要實體表
-- ========================================

-- User 父表
CREATE TABLE User (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    type ENUM('Student', 'Teacher', 'Organization', 'SystemAdministrator') NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- User 電話（多值屬性）
CREATE TABLE User_Phone (
    user_id VARCHAR(50),
    phone VARCHAR(20),
    PRIMARY KEY (user_id, phone),
    FOREIGN KEY (user_id) REFERENCES User(id) ON DELETE CASCADE
);

-- Teacher 表
CREATE TABLE Teacher (
    id VARCHAR(50) PRIMARY KEY,
    faculty VARCHAR(100),
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- Student 父表
CREATE TABLE Student (
    id VARCHAR(50) PRIMARY KEY,
    identity VARCHAR(50) NOT NULL,
    major VARCHAR(100),
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- Normal Student（一般生）
CREATE TABLE Normal_Student (
    id VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Overseas Student（僑生）
CREATE TABLE Overseas_Student (
    id VARCHAR(50) PRIMARY KEY,
    overseas_id VARCHAR(50),
    chinese_certify VARCHAR(100),
    immigrate_date DATE,
    passport_number VARCHAR(50),
    FOREIGN KEY (id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Aboriginal Student（原住民）
CREATE TABLE Aboriginal_Student (
    id VARCHAR(50) PRIMARY KEY,
    aboriginal_certify VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Low Income Student（低收入戶）
CREATE TABLE Low_Income_Student (
    id VARCHAR(50) PRIMARY KEY,
    low_income_certify VARCHAR(100),
    FOREIGN KEY (id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Disabled Student（身心障礙）
CREATE TABLE Disabled_Student (
    id VARCHAR(50) PRIMARY KEY,
    disabled_certify VARCHAR(100),
    disabled_level VARCHAR(50),
    FOREIGN KEY (id) REFERENCES Student(id) ON DELETE CASCADE
);

-- Organization（捐贈機構）
CREATE TABLE Organization (
    id VARCHAR(50) PRIMARY KEY,
    contact_person VARCHAR(100),
    receiving_way VARCHAR(100),
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- System Administrator（系統管理員）
CREATE TABLE System_Administrator (
    id VARCHAR(50) PRIMARY KEY,
    FOREIGN KEY (id) REFERENCES User(id) ON DELETE CASCADE
);

-- Scholarship（獎助學金）
CREATE TABLE Scholarship (
    name VARCHAR(100) PRIMARY KEY,
    amount DECIMAL(10, 2) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Announcement 父表（公告）
CREATE TABLE Announcement (
    announce_id VARCHAR(50) PRIMARY KEY,
    type ENUM('Apply', 'Result') NOT NULL,
    admin_id VARCHAR(50) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (admin_id) REFERENCES System_Administrator(id)
);

-- Apply Announcement（申請公告）
CREATE TABLE Apply_Announcement (
    announce_id VARCHAR(50) PRIMARY KEY,
    apply_date DATE NOT NULL,
    apply_deadline DATE NOT NULL,
    apply_condition TEXT,
    FOREIGN KEY (announce_id) REFERENCES Announcement(announce_id) ON DELETE CASCADE
);

-- Result Announcement（結果公告）
CREATE TABLE Result_Announcement (
    announce_id VARCHAR(50) PRIMARY KEY,
    result TEXT,
    announce_date DATE NOT NULL,
    remark TEXT,
    FOREIGN KEY (announce_id) REFERENCES Announcement(announce_id) ON DELETE CASCADE
);

-- Recommendation（推薦信）
CREATE TABLE Recommendation (
    id VARCHAR(50) PRIMARY KEY,
    content TEXT NOT NULL,
    update_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    teacher_id VARCHAR(50) NOT NULL,
    FOREIGN KEY (teacher_id) REFERENCES Teacher(id)
);

-- ========================================
-- 關係表
-- ========================================

-- Application（申請記錄）
CREATE TABLE Application (
    id VARCHAR(50) PRIMARY KEY,
    student_id VARCHAR(50) NOT NULL,
    scholarship_name VARCHAR(100) NOT NULL,
    apply_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    apply_way VARCHAR(50),
    apply_state ENUM('Pending', 'Approved', 'Rejected', 'Under Review') NOT NULL DEFAULT 'Pending',
    rank INT,
    score DECIMAL(5, 2),
    family_income DECIMAL(12, 2),
    gpa DECIMAL(3, 2),
    recommendation_id VARCHAR(50),
    FOREIGN KEY (student_id) REFERENCES Student(id),
    FOREIGN KEY (scholarship_name) REFERENCES Scholarship(name),
    FOREIGN KEY (recommendation_id) REFERENCES Recommendation(id)
);

-- Scholarship offered by Organization（獎學金與機構關係）
CREATE TABLE Scholarship_Organization (
    scholarship_name VARCHAR(100),
    organization_id VARCHAR(50),
    PRIMARY KEY (scholarship_name, organization_id),
    FOREIGN KEY (scholarship_name) REFERENCES Scholarship(name) ON DELETE CASCADE,
    FOREIGN KEY (organization_id) REFERENCES Organization(id) ON DELETE CASCADE
);

-- Pass Result（通過結果，多對多關係）
CREATE TABLE Pass_Result (
    organization_id VARCHAR(50),
    application_id VARCHAR(50),
    result ENUM('Pass', 'Fail', 'Waiting') NOT NULL,
    result_date DATE,
    PRIMARY KEY (organization_id, application_id),
    FOREIGN KEY (organization_id) REFERENCES Organization(id),
    FOREIGN KEY (application_id) REFERENCES Application(id)
);

-- ========================================
-- 索引建立（優化查詢效能）
-- ========================================

CREATE INDEX idx_user_email ON User(email);
CREATE INDEX idx_user_type ON User(type);
CREATE INDEX idx_student_major ON Student(major);
CREATE INDEX idx_application_student ON Application(student_id);
CREATE INDEX idx_application_scholarship ON Application(scholarship_name);
CREATE INDEX idx_application_state ON Application(apply_state);
CREATE INDEX idx_recommendation_teacher ON Recommendation(teacher_id);
CREATE INDEX idx_announcement_type ON Announcement(type);
CREATE INDEX idx_announcement_admin ON Announcement(admin_id);

-- ========================================
-- 插入範例資料（可選）
-- ========================================

-- 插入系統管理員
INSERT INTO User (id, name, email, type) VALUES 
('ADMIN001', '管理員一', 'admin1@example.com', 'SystemAdministrator');

INSERT INTO System_Administrator (id) VALUES ('ADMIN001');

-- 插入教師
INSERT INTO User (id, name, email, type) VALUES 
('T001', '張教授', 'prof.chang@example.com', 'Teacher');

INSERT INTO Teacher (id, faculty) VALUES 
('T001', '資訊工程學系');

-- 插入學生
INSERT INTO User (id, name, email, type) VALUES 
('S001', '王小明', 'student1@example.com', 'Student'),
('S002', '李小華', 'student2@example.com', 'Student');

INSERT INTO Student (id, identity, major) VALUES 
('S001', '一般生', '資訊工程學系'),
('S002', '僑生', '電機工程學系');

INSERT INTO Normal_Student (id) VALUES ('S001');
INSERT INTO Overseas_Student (id, overseas_id, chinese_certify, immigrate_date, passport_number) 
VALUES ('S002', 'OS001', '華語文能力證明', '2020-08-15', 'P123456789');

-- 插入機構
INSERT INTO User (id, name, email, type) VALUES 
('ORG001', 'XX基金會', 'contact@xxfoundation.org', 'Organization');

INSERT INTO Organization (id, contact_person, receiving_way) VALUES 
('ORG001', '陳經理', '銀行轉帳');

-- 插入獎學金
INSERT INTO Scholarship (name, amount, description) VALUES 
('優秀學生獎學金', 10000.00, '獎勵學業成績優異學生'),
('清寒獎助學金', 15000.00, '協助經濟弱勢學生'),
('僑生獎學金', 12000.00, '鼓勵僑生在台就學');

-- 關聯獎學金與機構
INSERT INTO Scholarship_Organization (scholarship_name, organization_id) VALUES 
('優秀學生獎學金', 'ORG001'),
('清寒獎助學金', 'ORG001');

-- 插入公告
INSERT INTO Announcement (announce_id, type, admin_id) VALUES 
('ANN001', 'Apply', 'ADMIN001');

INSERT INTO Apply_Announcement (announce_id, apply_date, apply_deadline, apply_condition) VALUES 
('ANN001', '2026-01-01', '2026-01-31', '1. GPA >= 3.5\n2. 無記過紀錄');

-- 插入推薦信
INSERT INTO Recommendation (id, content, teacher_id) VALUES 
('REC001', '該生品學兼優，值得推薦。', 'T001');

-- 插入申請記錄
INSERT INTO Application (id, student_id, scholarship_name, apply_way, apply_state, score, gpa, recommendation_id) VALUES 
('APP001', 'S001', '優秀學生獎學金', '線上申請', 'Under Review', 85.5, 3.8, 'REC001');

-- 插入電話資料
INSERT INTO User_Phone (user_id, phone) VALUES 
('S001', '0912-345-678'),
('S001', '02-1234-5678'),
('T001', '0923-456-789');

-- ========================================
-- 檢視表（方便查詢）
-- ========================================

-- 學生完整資訊檢視
CREATE VIEW v_student_info AS
SELECT 
    u.id,
    u.name,
    u.email,
    s.identity,
    s.major,
    GROUP_CONCAT(up.phone SEPARATOR ', ') AS phones
FROM User u
JOIN Student s ON u.id = s.id
LEFT JOIN User_Phone up ON u.id = up.user_id
GROUP BY u.id, u.name, u.email, s.identity, s.major;

-- 申請記錄完整檢視
CREATE VIEW v_application_detail AS
SELECT 
    a.id AS application_id,
    a.apply_date,
    u.name AS student_name,
    st.major,
    sch.name AS scholarship_name,
    sch.amount,
    a.apply_state,
    a.score,
    a.gpa,
    r.content AS recommendation_content,
    t.name AS teacher_name
FROM Application a
JOIN Student st ON a.student_id = st.id
JOIN User u ON st.id = u.id
JOIN Scholarship sch ON a.scholarship_name = sch.name
LEFT JOIN Recommendation r ON a.recommendation_id = r.id
LEFT JOIN Teacher te ON r.teacher_id = te.id
LEFT JOIN User t ON te.id = t.id;

-- 獎學金機構檢視
CREATE VIEW v_scholarship_organization AS
SELECT 
    sch.name AS scholarship_name,
    sch.amount,
    u.name AS organization_name,
    o.contact_person,
    u.email AS organization_email
FROM Scholarship sch
JOIN Scholarship_Organization so ON sch.name = so.scholarship_name
JOIN Organization o ON so.organization_id = o.id
JOIN User u ON o.id = u.id;

-- ========================================
-- 結束
-- ========================================

SELECT 'Database created successfully!' AS Status;
