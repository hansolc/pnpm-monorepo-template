PROJECT_PATH=$1

depth=$(tr -cd '/' <<< "$PROJECT_PATH" | wc -c)

if [ -z "$PROJECT_PATH" ]; then
  echo "🚫 프로젝트 경로를 입력해주세요. Usage: $0 <project-path/project-name>"
  exit 1
fi

if [ $depth -le 0 ]; then
  echo "🚫 유효하지 않은 프로젝트 경로입니다."
  exit 1
fi

TEMPLATE_DIR=packages/frontend-template/react-with-styled-components

mkdir -p "$PROJECT_PATH" 
echo "✅ 새로운 프로젝트 디렉토리를 생성했습니다 : "$PROJECT_PATH""

cp -R $TEMPLATE_DIR/. $PROJECT_PATH
cp -R $TEMPLATE_DIR/.gitignore $PROJECT_PATH 

SECOND_LEVEL_DIR=$(echo "$PROJECT_PATH" | cut -d'/' -f2)
PACKAGE_NAME="@${SECOND_LEVEL_DIR}"

PACKAGE_JSON_PATH=$PROJECT_PATH/package.json
jq --arg name "$PACKAGE_NAME" '.name = $name' $PACKAGE_JSON_PATH > tmp.$$.json && mv tmp.$$.json $PACKAGE_JSON_PATH

echo "✅ package.json의 name 필드를 수정했습니다: $PACKAGE_NAME"
TSCONFIG_PATH=$PROJECT_PATH/tsconfig.json
extends="../../tsconfig.base.json"

jq '.extends = $extends' --arg extends "$extends" "$TSCONFIG_PATH" > tmp.$$.json && mv tmp.$$.json "$TSCONFIG_PATH"

pnpm install
NEW_SCRIPT_NAME="$SECOND_LEVEL_DIR"
NEW_SCRIPT="pnpm --filter $PACKAGE_NAME"

echo "🎉 HAPPY CODING!"