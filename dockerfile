FROM python:3.12-slim-bookworm

COPY --from=public.ecr.aws/awsguru/aws-lambda-adapter:0.8.1 /lambda-adapter /opt/extensions/lambda-adapter

WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1
ENV PYTHONPATH="./src:$PYTHONPATH"

EXPOSE 8000
ENV PORT=8000

COPY . .

RUN sed '/-e/d' requirements.lock > requirements.txt
RUN pip install -r requirements.txt

ENTRYPOINT ["python", "src/flet_sample/run_app.py"]
