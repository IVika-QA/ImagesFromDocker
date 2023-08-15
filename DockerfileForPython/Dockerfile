FROM python

#Создание папки для файлов с тестами
WORKDIR /app

#Копирование  файла из текущей директории в директорию(папку) app в образе
COPY exampe_test_python.py .

# Установка модуля requests
RUN pip install requests

CMD python exampe_test_python.py
