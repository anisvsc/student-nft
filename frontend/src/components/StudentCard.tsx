import React, { useEffect, useState } from 'react';
import { getStudent } from '../services/api';

const StudentCard: React.FC = () => {
  const [student, setStudent] = useState<{ id: number; name: string; enrolled: boolean }>({
    id: 0,
    name: '',
    enrolled: false,
  });

  useEffect(() => {
    async function fetchStudent() {
      const fetchedStudent = await getStudent(1); // Fetch student with ID 1
      setStudent(fetchedStudent);
    }
    fetchStudent();
  }, []);

  return (
    <div className="student-card">
      <h2>Student ID: {student.id}</h2>
      <p>Name: {student.name}</p>
      <p>Enrolled: {student.enrolled ? 'Yes' : 'No'}</p>
    </div>
  );
};

export default StudentCard;
