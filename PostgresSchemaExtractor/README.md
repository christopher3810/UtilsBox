### 설명
이 프로젝트는 Python을 사용하여 PostgreSQL 데이터베이스 스키마를 덤프하는 도구를 포함하고 있습니다.

프로그램은 JSON 구성 파일에서 데이터베이스 연결 정보와 PostgreSQL pg_dump 실행 파일 경로를 읽고, 

지정된 PostgreSQL 데이터베이스에 연결한 다음 주어진 접두사가 있는 모든 테이블의 스키마를 덤프합니다.

### 필요사항

Python 3.8 이상

PostgreSQL 14.0 이상

psycopg2

PyInstaller (실행 파일을 만드는 경우)


### 설치 방법

clone

```shell
git clone https://github.com/your_username/postgresql-schema-dumper.git
```

clone 경로로 이동

```shell
cd postgresql-schema-dumper
```

필요한 Python 패키지를 설치

```shell
pip install -r requirements.txt
```

### 설정

main.py 파일이 위치한 동일한 디렉토리에 JSON 구성 파일 (info.json)을 생성해야 합니다. 

info.json 파일은 다음과 같은 구조를 가져야 합니다.

```json
{
    "DATABASE_NAME": "데이터베이스 이름",
    "PGUSER": "사용자 이름",
    "PGPASSWORD": "비밀번호",
    "PGHOST": "호스트명",
    "PG_PORT": "postgres port",
    "NEW_PG_DUMP": "pg_dump 경로",
    "dump_dir": "덤프 디렉토리 경로",
    "TABLE_PREFIX": "테이블 접두사"
}
```
위의 예시에 실제 PostgreSQL 상세 정보와 경로를 적어야 됩니다.

main.py와 같은 디렉토리에 데이터베이스에서 테이블 이름을 가져오는 SQL 명령어가 들어있는 extract.sql 파일이 있어야 합니다.


### 사용 방법

파이썬 스크립트 실행

```shell
python main.py --info info.json
```
실행 파일 생성 및 실행

PyInstaller를 사용하여 실행 파일을 빌드합니다

```shell
pyinstaller --onefile --add-data "extract.sql;." main.py
```

위와 같이 add-data 옵션을 활용해줍니다.

생성된 main.exe를 실행

```shell
dist\main.exe --info info.json
```

각 테이블을 별도의 SQL 파일로 덤프 뜨기

`--mode 옵션`을 활용

파이썬 스크립트 실행

```shell
python main.py --info info.json --mode multi
```

생성된 main.exe를 실행

```shell
dist\main.exe --info info.json --mode multi
```

실행 파일과 같은 디렉토리에 info.json 파일이 없는 경우, 실제 JSON 구성 파일 경로로 info.json를 바꿔주세요.

덤프된 스키마들은 JSON 구성 파일의 dump_dir 필드에 지정된 디렉토리에 저장됩니다.



