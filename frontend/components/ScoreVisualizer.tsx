'use client';

import { motion } from 'framer-motion';

interface Props {
  score: number;
  categories: Record<string, number>;
}

export default function ScoreVisualizer({ score, categories }: Props) {
  const percentage = Math.min(Math.max(score, 0), 1000) / 10; // 0-100%

  return (
    <div className="bg-gray-900 p-8 rounded-3xl">
      <h3 className="text-xl mb-6">Reputation Gauge</h3>
      
      <div className="relative w-48 h-48 mx-auto">
        <svg className="w-full h-full -rotate-90" viewBox="0 0 120 120">
          <circle cx="60" cy="60" r="52" fill="none" stroke="#333" strokeWidth="12" />
          <motion.circle
            cx="60" cy="60" r="52"
            fill="none"
            stroke="#22c55e"
            strokeWidth="12"
            strokeDasharray={Math.PI * 104}
            strokeDashoffset={Math.PI * 104 * (1 - percentage / 100)}
            initial={{ strokeDashoffset: Math.PI * 104 }}
            animate={{ strokeDashoffset: Math.PI * 104 * (1 - percentage / 100) }}
            transition={{ duration: 1.5 }}
          />
        </svg>
        <div className="absolute inset-0 flex items-center justify-center text-6xl font-bold">
          {score}
        </div>
      </div>

      <div className="grid grid-cols-2 gap-4 mt-8">
        {Object.entries(categories).map(([cat, val]) => (
          <div key={cat} className="bg-black/50 p-4 rounded-2xl">
            <p className="capitalize text-sm text-gray-400">{cat}</p>
            <p className="text-3xl font-mono">{val}</p>
          </div>
        ))}
      </div>
    </div>
  );
}