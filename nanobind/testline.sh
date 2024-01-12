( cd cxx && cmake -S . -B build -D PROJECTNAME=bind  && cmake --build build && cd build && python3 -c "import bind; bind.add(1,2)"  )
