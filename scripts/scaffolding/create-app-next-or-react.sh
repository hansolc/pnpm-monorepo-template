#!/bin/bash

# 첫 번째 인자(프로젝트 이름) 저장
PROJECT_PATH=""

# 옵션 변수
FRAMEWORK_NAME=""
CSS_LIBRARY=""

# apps폴더 내에 생성
BASE_PROJECT_PATH="apps/"

# 인자가 없는 경우 기본 에러 메시지
if [ $# -lt 1 ]; then
  echo "❌ 오류: 프로젝트 이름을 입력해야 합니다."
  echo "사용법: pnpm create-app <project_name> [-f <framework_name>] [-s <css_library>]"
  exit 1
fi

# 첫 번째 인자를 PROJECT_PATH로 저장 (옵션과 구분)
if [[ ! "$1" =~ ^- ]]; then
  PROJECT_PATH="$1"
  shift
fi

REQUIRED_F=0
REQUIRED_S=0

# 옵션 처리
while [[ $# -gt 0 ]]; do
  case "$1" in
    -f|--framework)
      if [ -z "$2" ] || [[ "$2" =~ ^- ]]; then
        echo "❌ 오류: '-f' 옵션에는 'next' 또는 'react' 값을 입력해야 합니다."
        exit 1
      fi
      if [[ "$2" == "next" || "$2" == "react" ]]; then
        FRAMEWORK_NAME="$2"
        REQUIRED_F=1
      else
        echo "❌ 오류: '-f' 옵션은 'next' 또는 'react'만 입력할 수 있습니다."
        exit 1
      fi
      shift 2
      ;;
    -s|--style)
      if [ -z "$2" ] || [[ "$2" =~ ^- ]]; then
        echo "❌ 오류: '-s' 옵션에는 'styled' 또는 'vanilla' 값을 입력해야 합니다."
        exit 1
      fi
      if [[ "$2" == "styled" || "$2" == "vanilla" ]]; then
        CSS_LIBRARY="$2"
        REQUIRED_S=1
      else
        echo "❌ 오류: '-s' 옵션은 'styled' 또는 'vanilla'만 입력할 수 있습니다."
        exit 1
      fi
      shift 2
      ;;
    *)
      echo "❌ 오류: 올바른 옵션을 입력하세요."
      echo "사용법: pnpm create-app <project_name> [-f <framework_name>] [-s <css_library>]"
      exit 1
      ;;
  esac
done

# PROJECT_PATH가 비어있는 경우 다시 체크
if [ -z "$PROJECT_PATH" ]; then
  echo "❌ 오류: 프로젝트 이름을 입력해야 합니다."
  echo "사용법: pnpm create-app <project_name> [-f <framework_name>]"
  exit 1
fi

if [ "$REQUIRED_F" -eq 0 ] || [ "$REQUIRED_S" -eq 0 ]; then
  echo "❌ 오류: '-f' 및 '-s' 옵션은 필수입니다."
  echo "사용법: create-app <project_name> -f <framework_name> -s <style_type>"
  exit 1
fi

echo "📁 프로젝트 경로: $BASE_PROJECT_PATH$PROJECT_PATH"
echo "🎨 프레임워크: $FRAMEWORK_NAME"
echo "🖌 CSS 라이브러리: $CSS_LIBRARY"

# exit 1

# -p: 부모 디렉토리가 없을 경우 자동 생성, 이미 존재하는 경우 에러없이 넘어감.
mkdir -p "$BASE_PROJECT_PATH$PROJECT_PATH" 
echo "✅ 새로운 프로젝트 디렉토리를 생성했습니다 : "$BASE_PROJECT_PATH$PROJECT_PATH""

TEMPLATE_DIR="packages/frontend-template/"
PROJECT_FULL_PATH="apps/$PROJECT_PATH"

cp -R $TEMPLATE_DIR/$FRAMEWORK_NAME-with-$CSS_LIBRARY/. $PROJECT_FULL_PATH/.
cp -R $TEMPLATE_DIR/$FRAMEWORK_NAME-with-$CSS_LIBRARY/.gitignore $PROJECT_FULL_PATH

PACKAGE_NAME="@${PROJECT_PATH}"

PACKAGE_JSON_PATH=$PROJECT_FULL_PATH/package.json
jq --arg name "$PACKAGE_NAME" '.name = $name' $PACKAGE_JSON_PATH > tmp.$$.json && mv tmp.$$.json $PACKAGE_JSON_PATH

echo "✅ package.json의 name 필드를 수정했습니다: $PACKAGE_NAME"
TSCONFIG_PATH=$PROJECT_FULL_PATH/tsconfig.json
extends="../../tsconfig.base.json"

jq '.extends = $extends' --arg extends "$extends" "$TSCONFIG_PATH" > tmp.$$.json && mv tmp.$$.json "$TSCONFIG_PATH"

pnpm install

echo "🎉 HAPPY CODING!"