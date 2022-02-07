#!/usr/bin/env sh

# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
# WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
# COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
# OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

set -e

follow_link() {
  FILE="$1"
  while [ -h "$FILE" ]; do
    # On macOS, readlink -f doesn't work.
    FILE="$(readlink "$FILE")"
  done
  echo "$FILE"
}

SCRIPT_PATH=$(realpath "$(dirname "$(follow_link "$0")")")
CONFIG_PATH=${1:-${SCRIPT_PATH}/config}

mkdir -p "$CONFIG_PATH"
### Copy the example input variables.
echo
echo "> Copying the example input variables..."
cp -av "$SCRIPT_PATH"/builds/*.pkrvars.hcl.example "$CONFIG_PATH"

### Rename the example input variables.
echo
echo "> Renaming the example input variables..."
srcext=".pkrvars.hcl.example"
dstext=".pkrvars.hcl"

for f in "$CONFIG_PATH"/*"${srcext}"; do
  bname="${f%"${srcext}"}"
  echo "${bname}{${srcext} → ${dstext}}"
  mv "${f}" "${bname}${dstext}"
done

echo
echo "> Done."
