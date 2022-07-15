import { pathsToModuleNameMapper } from 'ts-jest';

import type { Config } from '@jest/types';

import { compilerOptions } from './tsconfig.json';

const config: Config.InitialOptions = {
  preset: 'ts-jest',
  testEnvironment: 'node',
  roots: ['<rootDir>/tests'],
  coverageDirectory: '<rootDir>/.coverage',
  coverageProvider: 'v8',
  passWithNoTests: true,
  moduleNameMapper: pathsToModuleNameMapper(compilerOptions.paths, {
    prefix: '<rootDir>',
  }),
  testMatch: ['**/*.{spec,test}.ts'],
  transform: {
    '^.+\\.(t|j)sx?$': '@swc/jest',
  },
};
export default config;
