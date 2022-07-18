FROM python:3.7-alpine
RUN mkdir /app
WORKDIR /app
ADD requirements.txt /app
ADD app.py /app
RUN pip3 install -r requirements.txt
CMD ["python", "app.py"]