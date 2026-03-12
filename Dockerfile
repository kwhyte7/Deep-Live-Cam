FROM tuttelikz/opencv-cuda:4.10.0-cuda12.6.3-arch8.9-ubuntu22.04

ENV Tzdata=False

WORKDIR /app/

RUN DEBIAN_SAME_AS=True
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates focal-security" >> /etc/apt/sources.list.d/extra-sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-proposed focal-updates focal-security" >> tee /etc/apt/sources.list

COPY requirements.txt .

RUN apt update
RUN apt install python3-tk -y

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

CMD ["python3", "run.py"]
