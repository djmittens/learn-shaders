docker run -it -p 8888:8888 -v "${PWD}":/home/jovyan/work --platform linux/arm64 --name jupyter jupyter/scipy-notebook:lab-3.4.0