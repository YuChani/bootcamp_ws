# bootcamp_ws

## build Dockerfile
```bash
cd docker
- if don't have authority
chmod +x build.sh
./build.sh
```

## build Dockerfile
```bash
cd docker
- if don't have authority
chmod +x run.sh
./run.sh
```

## cmake g2o
```bash
cd src/g2o
mkdir build && cd build
cmake ..
make
```

## cmake ceres
```bash
cd src/ceres-solver
git submodule update --init --recursive
mkdir build && cd build
cmake .. -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=ON -DBUILD_EXAMPLES=ON
make -j"$(nproc)"
```
