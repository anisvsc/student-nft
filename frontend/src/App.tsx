import React from 'react';
import Navbar from './components/Navbar';
import StudentCard from './components/StudentCard';

const App: React.FC = () => {
  return (
    <div>
      <Navbar />
      <StudentCard />
    </div>
  );
};

export default App;
