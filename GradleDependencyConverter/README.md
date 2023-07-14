### Dependency Extract Helper

이 파이썬 프로젝트는 의존성 파일을 조작하고 정리하는데 사용됩니다.

이 프로젝트는 주로 두 가지 기능을 제공합니다

제공된 파일에서 의존성 트리를 펼치고, 내림차순으로 정렬하여 결과를 .txt 또는 .xlsx 파일로 출력합니다.

zip 파일 내부의 여러 엑셀 파일을 하나의 엑셀 파일로 병합하며, 각 시트가 zip 파일 내부의 파일을 대표합니다.

### 요구 사항
---
Python 3.6 이상이 필요합니다. 

그 외 필요한 라이브러리는 requirements.txt 파일에 명시되어 있습니다.

### 설치
---

저장소를 clone 한뒤 clone 한 dir로 이동합니다

```bash
cd your_repository
```

pip를 이용해서 패키지를 설치해줍니다.

## 필요한 라이브러리 설치하기

이 프로젝트를 실행하려면 `openpyxl`, `pandas`, `argparse` 라이브러리가 필요합니다.

이 라이브러리들은 `requirements.txt` 파일에 명시되어 있습니다. 이 파일을 사용해 필요한 라이브러리를 설치하려면:

1. 새로운 Python 가상 환경을 만드는 것이 좋습니다. 

이렇게 하면 프로젝트에 필요한 라이브러리가 시스템의 다른 파이썬 환경에 영향을 미치지 않습니다. 

2가상 환경을 만드는 방법은 다음과 같습니다

```bash
python -m venv venv
```
Windows
```bash
.\venv\Scripts\activate
```

Unix or MacOS
```bash
source venv/bin/activate
```

필요한 라이브러리를 설치합니다

```bash
pip install -r requirements.txt
```


### 사용 방법
스크립트는 몇 가지 명령 줄 인수를 받습니다.

-f, --file

의존성 파일의 경로입니다. 
이 인수 또는 -mzip 중 하나를 제공해야 합니다.

-mzip, --merge_zip: 병합할 엑셀 파일이 포함된 zip 파일의 입력 경로입니다. 이 인수 또는 -f 중 하나를 제공해야 합니다.

-txt: 출력 txt 파일의 경로입니다. 이 인수는 의존성을 펼친 후 내림차순으로 정렬하여 txt 파일로 출력합니다. -mzip/-ozip와 함께 사용할 수 없습니다.

-exc: 출력 엑셀 파일의 경로입니다. 이 인수는 의존성을 펼친 후 내림차순으로 정렬하여 "dependencies" 헤더 아래 엑셀 파일로 출력합니다. -mzip/-ozip와 함께 사용할 수 없습니다.

-ozip: 입력 zip 파일에서 엑셀 파일을 병합한 후의 출력 엑셀 파일 경로입니다. 이 인수는 zip 파일 내의 모든 엑셀 파일을 하나의 엑셀 파일로 병합하며, 각 파일의 이름으로 작성된 별도의 시트에 저장합니다. -mzip와만 사용할 수 있습니다.

-dd: 이 인수가 있으면, 출력 파일의 의존성은 중복 제거하여 출력됩니다.



### 예시
---

의존성 트리를 txt 파일 또는 excel 파일로 펼쳐서 저장하려면.

```bash
python main.py -f dependencies_file_path -txt output_txt_file_path
python main.py -f dependencies_file_path -exc output_excel_file_path
```

zip파일에 내부에 있는 excel 파일을 하나의 excel 파일로 병합하려면

```bash
python main.py -mzip zip_file_path -ozip output_excel_file_path
```

> dist 내부에 exe를 활용해서 바로 사용도 가능합니다.

