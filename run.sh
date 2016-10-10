#!/bin/sh
jupyter nbconvert --to markdown main.ipynb
npm run build
service nginx start
python -m http.server 8000 &
jupyter notebook --NotebookApp.allow_origin='*' --no-browser --port 8888 --ip=*
