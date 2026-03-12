from fastapi import FastAPI, UploadFile, File, Form  # Añadimos Form
import whisper
from whisper.utils import get_writer
import shutil
import os

app = FastAPI()
model = whisper.load_model("tiny")


def get_whisper_output(result, format_type, output_dir, max_line_width, max_line_count):
    writer = get_writer(format_type, output_dir)
    temp_base = "result"

    # Parámetros dinámicos recibidos desde la API
    writer_args = {
        "max_line_width": max_line_width,
        "max_line_count": max_line_count,
        "highlight_words": False,
    }

    writer(result, temp_base, **writer_args)

    file_path = os.path.join(output_dir, f"{temp_base}.{format_type}")
    with open(file_path, "r", encoding="utf-8") as f:
        content = f.read()

    if os.path.exists(file_path):
        os.remove(file_path)
    return content


@app.post("/transcribe")
async def transcribe(
    file: UploadFile = File(...),
    max_line_width: int = Form(30),  # Parámetro opcional con default 30
    max_line_count: int = Form(1),  # Parámetro opcional con default 1
):
    file_location = f"/tmp/{file.filename}"
    with open(file_location, "wb") as f:
        shutil.copyfileobj(file.file, f)

    result = model.transcribe(file_location, word_timestamps=True, verbose=False)

    output_dir = "/tmp"
    # Pasamos los parámetros a la función de salida
    srt_content = get_whisper_output(
        result, "srt", output_dir, max_line_width, max_line_count
    )
    vtt_content = get_whisper_output(
        result, "vtt", output_dir, max_line_width, max_line_count
    )
    txt_content = result["text"]

    os.remove(file_location)

    return {
        "filename": file.filename,
        "text_plain": txt_content,
        "srt": srt_content,
        "vtt": vtt_content,
        "language": result.get("language"),
        "settings": {
            "max_line_width": max_line_width,
            "max_line_count": max_line_count,
        },
    }
