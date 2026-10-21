-- members --
CREATE TABLE members (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    full_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    joined_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

-- courses --
CREATE TABLE courses (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    capacity INT NOT NULL CHECK (capacity > 0)
);

-- registrations --
CREATE TABLE registrations (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    member_id INT NOT NULL REFERENCES members (id),
    course_id INT NOT NULL REFERENCES courses (id),
    status VARCHAR(20) NOT NULL DEFAULT 'pending',
    registered_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    UNIQUE (member_id, course_id)
);

INSERT INTO members (full_name, email) VALUES
('Nguyễn An', 'an@dthu.edu.vn'),
('Trần Bình', 'binh@dthu.edu.vn'),
('Lê Chi', 'chi@dthu.edu.vn');

INSERT INTO courses (title, capacity) VALUES
('Lập trình Web', 2),
('Cơ sở dữ liệu', 40);

INSERT INTO registrations (member_id, course_id) VALUES
(1, 1),
(1, 2),
(2, 1);

SELECT * FROM members;
SELECT * FROM courses;
SELECT * FROM registrations;

-- câu 1 --
SELECT c.title AS ten_khoa_hoc
FROM members m
JOIN registrations r ON m.id = r.member_id
JOIN courses c ON c.id = r.course_id
WHERE m.full_name = 'Nguyễn An';

-- câu 2 --
SELECT c.title AS ten_khoa_hoc, 
       COUNT(r.id) AS so_luong_thanh_vien
FROM courses c
LEFT JOIN registrations r ON c.id = r.course_id
GROUP BY c.id, c.title
ORDER BY so_luong_thanh_vien DESC;

-- câu 3 --
BEGIN;

INSERT INTO registrations (member_id, course_id)
VALUES (
    (SELECT id FROM members WHERE full_name = 'Lê Chi'),
    (SELECT id FROM courses WHERE title = 'Cơ sở dữ liệu')
);

COMMIT;