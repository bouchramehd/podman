
FROM python
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt
COPY src/ .
EXPOSE 4743
CMD ["flask", "run", "--host=0.0.0.0", "--port=4743"]


