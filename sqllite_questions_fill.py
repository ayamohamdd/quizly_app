import sqlite3
import csv
from pathlib import Path

CSV_PATH = '/home/moustafa/workspaces/git/most-pythons-helper-github/dl-course/math_questions_with_mcq.csv'
DB_PATH = '/home/moustafa/workspaces/git/most-pythons-helper-github/dl-course/math_quiz.db'

def init_db(conn):
    cursor = conn.cursor()

    cursor.executescript('''
    DROP TABLE IF EXISTS mcq_options;
    DROP TABLE IF EXISTS questions;
    DROP TABLE IF EXISTS skills;
    DROP TABLE IF EXISTS units;

    CREATE TABLE units (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT UNIQUE NOT NULL
    );

    CREATE TABLE skills (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        unit_id INTEGER NOT NULL,
        name TEXT NOT NULL,
        FOREIGN KEY (unit_id) REFERENCES units(id) ON DELETE CASCADE,
        UNIQUE (unit_id, name)
    );

    CREATE TABLE questions (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        skill_id INTEGER NOT NULL,
        question_text TEXT NOT NULL,
        level TEXT CHECK (level IN ('easy', 'medium', 'hard')) NOT NULL,
        type TEXT CHECK (type IN ('mcq', 'fill_blank')) NOT NULL,
        correct_answer TEXT NOT NULL,
        explanation TEXT,
        FOREIGN KEY (skill_id) REFERENCES skills(id) ON DELETE CASCADE
    );

    CREATE TABLE mcq_options (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        question_id INTEGER NOT NULL,
        option_text TEXT NOT NULL,
        is_correct INTEGER CHECK (is_correct IN (0, 1)) NOT NULL,
        FOREIGN KEY (question_id) REFERENCES questions(id) ON DELETE CASCADE
    );
    ''')
    conn.commit()

def get_or_create_unit(conn, name):
    cursor = conn.cursor()
    cursor.execute("INSERT OR IGNORE INTO units (name) VALUES (?)", (name,))
    conn.commit()
    cursor.execute("SELECT id FROM units WHERE name = ?", (name,))
    return cursor.fetchone()[0]

def get_or_create_skill(conn, unit_id, name):
    cursor = conn.cursor()
    cursor.execute("INSERT OR IGNORE INTO skills (unit_id, name) VALUES (?, ?)", (unit_id, name))
    conn.commit()
    cursor.execute("SELECT id FROM skills WHERE unit_id = ? AND name = ?", (unit_id, name))
    return cursor.fetchone()[0]

def insert_question_and_options(conn, row, skill_id):
    cursor = conn.cursor()
    cursor.execute('''
        INSERT INTO questions (skill_id, question_text, level, type, correct_answer, explanation)
        VALUES (?, ?, ?, ?, ?, ?)
    ''', (
        skill_id,
        row['question_text'],
        row['level'],
        row['type'],
        row['correct_answer'],
        row['explanation']
    ))
    question_id = cursor.lastrowid

    if row['type'] == 'mcq':
        options = row['options'].split('|')
        for opt in options:
            is_correct = 1 if opt.strip() == row['correct_answer'].strip() else 0
            cursor.execute('''
                INSERT INTO mcq_options (question_id, option_text, is_correct)
                VALUES (?, ?, ?)
            ''', (question_id, opt.strip(), is_correct))
    conn.commit()

def load_csv_to_sqlite(csv_path, db_path):
    conn = sqlite3.connect(db_path)
    init_db(conn)

    with open(csv_path, newline='') as csvfile:
        reader = csv.DictReader(csvfile)
        unit_cache = {}
        skill_cache = {}

        for row in reader:
            unit = row['unit']
            skill = row['skill']

            if unit not in unit_cache:
                unit_id = get_or_create_unit(conn, unit)
                unit_cache[unit] = unit_id
            else:
                unit_id = unit_cache[unit]

            skill_key = (unit_id, skill)
            if skill_key not in skill_cache:
                skill_id = get_or_create_skill(conn, unit_id, skill)
                skill_cache[skill_key] = skill_id
            else:
                skill_id = skill_cache[skill_key]

            insert_question_and_options(conn, row, skill_id)

    conn.close()
    print(f"✅ Data imported to {db_path}")

if __name__ == '__main__':
    if not Path(CSV_PATH).exists():
        print(f"❌ CSV file not found: {CSV_PATH}")
    else:
        load_csv_to_sqlite(CSV_PATH, DB_PATH)
