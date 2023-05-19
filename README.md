# fastchat_docker

Vicunaによる推論や再学習/追加学習が可能な環境を構築します。

## 開発環境要件

|パッケージ|バージョン|環境|
|-|-|-|
|PyTorch|>= 2.0|コンテナ|
|CUDA Toolkit|>= 11.7|コンテナ|
|NVIDIA driver|>= 515.1|マシン|

## 導入手順

### ディレクトリ構成

```
fastchat_docker
├── docker
│   ├── build.sh
│   ├── Dockerfile
│   ├── launch.sh
│   └── Makefile
├── FastChat
├── .gitignore
├── LICENSE
├── llama-13b-hf
├── llama-7b-hf
├── README.md
├── scripts
│   ├── model_apply_delta_vicuna.sh
│   ├── pip_install_FastChat.sh
│   └── serve_vicuna.sh
├── vicuna-13b
├── vicuna-13b-delta-v1.1
├── vicuna-7b
└── vicuna-7b-delta-v1.1
```

```terminal:terminal
git clone https://github.com/cpx0/fastchat_docker.git
cd fastchat_docker
```

```terminal:terminal
git clone https://github.com/cpx0/FastChat.git
```

```terminal:terminal
git clone https://huggingface.co/decapoda-research/llama-7b-hf
git clone https://huggingface.co/lmsys/vicuna-7b-delta-v1.1
```

```terminal:terminal
git clone https://huggingface.co/decapoda-research/llama-13b-hf
git clone https://huggingface.co/lmsys/vicuna-13b-delta-v1.1
```

```terminal:terminal
./docker/build.sh
```

```terminal:terminal
./docker/launch.sh
```

```terminal:terminal
cd FastChat
pip install --upgrade pip
pip install -e .
cd ..
```

```terminal:terminal
python -m fastchat.model.apply_delta \
    --base-model-path ./llama-7b-hf \
    --target-model-path ./vicuna-7b \
    --delta-path ./vicuna-7b-delta-v1.1
```

```terminal:terminal
python -m fastchat.serve.cli \
    --model-path ./vicuna-7b \
    --load-8bit
```

vicuna-7b/13bの推論を確認できたPython環境のインストール済みパッケージ情報（`pip freeze`）を以下に残しておく。

```terminal:pip freeze
accelerate==0.19.0
aiofiles==23.1.0
aiohttp==3.8.4
aiosignal==1.3.1
altair==5.0.0
anyio==3.6.2
appdirs==1.4.4
async-timeout==4.0.2
attrs==23.1.0
bitsandbytes==0.38.1
blinker==1.4
certifi==2023.5.7
charset-normalizer==3.1.0
click==8.1.3
cmake==3.25.0
contourpy==1.0.7
cryptography==3.4.8
cycler==0.11.0
dbus-python==1.2.18
distro==1.7.0
docker-pycreds==0.4.0
fastapi==0.95.1
ffmpy==0.3.0
filelock==3.9.0
fonttools==4.39.4
frozenlist==1.3.3
-e git+https://github.com/cpx0/FastChat.git@7b19ce82aee58131f0e89a4cda5cff035717fb58#egg=fschat
fsspec==2023.5.0
gitdb==4.0.10
GitPython==3.1.31
gradio==3.23.0
h11==0.14.0
httpcore==0.17.0
httplib2==0.20.2
httpx==0.24.0
huggingface-hub==0.14.1
idna==3.4
importlib-metadata==4.6.4
jeepney==0.7.1
Jinja2==3.1.2
jsonschema==4.17.3
keyring==23.5.0
kiwisolver==1.4.4
launchpadlib==1.10.16
lazr.restfulclient==0.14.4
lazr.uri==1.0.6
linkify-it-py==2.0.2
lit==15.0.7
markdown-it-py==2.2.0
markdown2==2.4.8
MarkupSafe==2.1.2
matplotlib==3.7.1
mdit-py-plugins==0.3.3
mdurl==0.1.2
more-itertools==8.10.0
mpmath==1.2.1
multidict==6.0.4
networkx==3.0
nh3==0.2.11
numpy==1.24.3
oauthlib==3.2.0
orjson==3.8.12
packaging==23.1
pandas==2.0.1
pathtools==0.1.2
Pillow==9.5.0
prompt-toolkit==3.0.38
protobuf==4.23.0
psutil==5.9.5
pydantic==1.10.7
pydub==0.25.1
Pygments==2.15.1
PyGObject==3.42.1
PyJWT==2.3.0
pyparsing==2.4.7
pyrsistent==0.19.3
python-apt==2.4.0+ubuntu1
python-dateutil==2.8.2
python-multipart==0.0.6
pytz==2023.3
PyYAML==6.0
regex==2023.5.5
requests==2.30.0
rich==13.3.5
SecretStorage==3.3.1
semantic-version==2.10.0
sentencepiece==0.1.99
sentry-sdk==1.22.2
setproctitle==1.3.2
shortuuid==1.0.11
six==1.16.0
smmap==5.0.0
sniffio==1.3.0
starlette==0.26.1
svgwrite==1.4.3
sympy==1.11.1
tokenizers==0.13.3
toolz==0.12.0
torch==2.0.1+cu117
tqdm==4.65.0
transformers==4.28.1
triton==2.0.0
typing_extensions==4.4.0
tzdata==2023.3
uc-micro-py==1.0.2
urllib3==1.26.15
uvicorn==0.22.0
wadllib==1.3.6
wandb==0.15.2
wavedrom==2.0.3.post3
wcwidth==0.2.6
websockets==11.0.3
yarl==1.9.2
zipp==1.0.0
```
