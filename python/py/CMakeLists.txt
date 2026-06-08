cmake_minimum_required(VERSION 3.24.0)
project( python_test VERSION 1.0 )

find_package(Python 3.8
  COMPONENTS
  # these are needed for WarpX:
  Interpreter Development.Module
  REQUIRED)
