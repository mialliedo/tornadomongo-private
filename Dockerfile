FROM --platform=linux/amd64 python:3.9

EXPOSE 9000/tcp

RUN apt-get update && apt-get install -y \
    build-essential \
    git \
    curl \
    pip \
    python3-cffi \
    libcairo2 \
    libpango-1.0-0 \
    libpangocairo-1.0-0 \
    libgdk-pixbuf2.0-0 \
    libffi-dev \
    shared-mime-info \
    fonts-noto

RUN curl -sL https://deb.nodesource.com/setup_18.x -o nodesource_setup.sh
RUN bash nodesource_setup.sh
RUN apt install -y nodejs
RUN npm install -g newman

COPY . /app
WORKDIR /app
RUN ls
RUN pip install --trusted-host pypi.python.org -r requirements.txt

ADD entrypoint.sh /app
RUN chmod +x /app/entrypoint.sh


CMD ["/app/entrypoint.sh"]