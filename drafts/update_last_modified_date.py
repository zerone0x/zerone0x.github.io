import os
import toml
from pathlib import Path
from datetime import datetime

# Define your date format
DATE_FORMAT = '%Y-%m-%d'

# Define your markdown files path
# This will find all the .md files in the provided directory and sub directories
md_files_path = Path('/Users/sober/Downloads/blog/craft/content').rglob('*.md')

for md_file_path in md_files_path:
    update_date = datetime.fromtimestamp(os.path.getmtime(md_file_path))
    with open(md_file_path, 'r+') as file:
        content = file.read()
        try:
            front_matter, body = content.split('+++', 2)[1:]
            front_matter = toml.loads(front_matter) or {}
            if isinstance(front_matter, dict):
                front_matter['update_date'] = update_date.strftime(DATE_FORMAT)

                file.seek(0)
                file.write('+++\n')
                toml.dump(front_matter, file)
                file.write('+++' + body)
            else:
                print(f'Skipping {md_file_path}, Front Matter not found or not a dictionary.')
        except:
            print(f'Parsing error for file {md_file_path}, skipping...')