# FROM python:3.9-slim
# WORKDIR /app
# COPY requirements.txt .
# RUN pip install --no-cache-dir -r requirements.txt
# COPY . .
# CMD ["uvicorn","main:app","--host","0.0.0.0","--port","8000"]

FROM public.ecr.aws/docker/library/nginx:stable-perl
RUN echo "CI/CD SUCCESS!!!" > /usr/share/nginx/html/index.html