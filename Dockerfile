FROM tuttelikz/opencv-cuda:4.10.0-cuda12.6.3-arch8.9-ubuntu22.04

# stop debian asking user questions
ARG DEBIAN_FRONTEND=noninteractive

#RUN apt install tzdata
#RUN echo "Europe/London" > /etc/timezone

RUN ln -snf /usr/share/zoneinfo/$CONTAINER_TIMEZONE /etc/localtime && echo $CONTAINER_TIMEZONE > /etc/timezone

WORKDIR /app/

# allow deb sources to work for this container
RUN DEBIAN_SAME_AS=True
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-updates focal-security" >> /etc/apt/sources.list.d/extra-sources.list
RUN echo "deb http://archive.ubuntu.com/ubuntu/ focal-proposed focal-updates focal-security" >> tee /etc/apt/sources.list

COPY requirements.txt .

RUN apt update
RUN apt install python3-tk ffmpeg -y

RUN pip install --upgrade pip
RUN pip install -r requirements.txt

COPY . .

ENV DISPLAY=localhost:0

CMD ["python3", "run.py --execution-provider cuda"]
