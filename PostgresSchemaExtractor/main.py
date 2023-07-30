import os
import psycopg2
import subprocess
import json
import argparse
import sys
import logging

# Set up logging
logging.basicConfig(level=logging.INFO, format='%(asctime)s - %(levelname)s - %(message)s')


def dump_single_file(cur, config, DUMP_DIR):
    single_file = os.path.join(DUMP_DIR, f"{config['DATABASE_NAME']}_schema.sql")
    with open(single_file, 'w') as f:
        for table in cur.fetchall():
            table = table[0]  # Get table name from tuple
            logging.info(f'Dumping schema for table {table}')
            result = subprocess.run([
                config['NEW_PG_DUMP'],
                "-U", config['PGUSER'],
                "--port", str(config['PG_PORT']),
                "--schema-only",
                "--dbname", config['DATABASE_NAME'],
                "-t", table,
            ], text=True, capture_output=True)
            f.write(result.stdout)


def dump_multiple_files(cur, config, DUMP_DIR):
    for table in cur.fetchall():
        table = table[0]  # Get table name from tuple
        logging.info(f'Dumping schema for table {table}')
        subprocess.run([
            config['NEW_PG_DUMP'],
            "-U", config['PGUSER'],
            "--port", str(config['PG_PORT']),
            "--schema-only",
            "--dbname", config['DATABASE_NAME'],
            "-t", table,
            "-f", os.path.join(DUMP_DIR, f"{table}.schema.sql")
        ])


def main(args):
    try:
        logging.info('Starting schema dump process')
        # Load configuration from JSON file
        with open(args.info, 'r', encoding='utf-8') as f:
            config = json.load(f)

        logging.info('Loaded configuration from JSON file')

        # Get the directory of the current script
        script_dir = os.path.dirname(os.path.abspath(__file__))

        # Ensure dump directory exists
        DUMP_DIR = config.get('dump_dir', script_dir)
        if not os.path.isabs(DUMP_DIR):
            DUMP_DIR = os.path.join(os.getcwd(), DUMP_DIR)
        os.makedirs(DUMP_DIR, exist_ok=True)

        logging.info(f'Using dump directory: {DUMP_DIR}')

        # Set up connection to PostgreSQL
        conn = psycopg2.connect(
            dbname=config['DATABASE_NAME'],
            user=config['PGUSER'],
            password=config['PGPASSWORD'],
            host=config['PGHOST'],
            port=config['PG_PORT']
        )

        logging.info('Connected to PostgreSQL database')

        # Create cursor to execute SQL
        cur = conn.cursor()

        # Define SQL file path
        if getattr(sys, 'frozen', False):
            application_path = sys._MEIPASS
        else:
            application_path = os.path.dirname(os.path.abspath(__file__))

        query_file_path = os.path.join(application_path, 'extract.sql')

        # Get table prefix from config
        table_prefix = config.get('TABLE_PREFIX', '')

        # Load SQL file
        with open(query_file_path, 'r', encoding='utf-8') as file:
            sql_query = file.read().format(table_prefix=table_prefix)

        # Execute SQL to get table names with prefix
        cur.execute(sql_query)

        if args.mode == 'single':
            logging.info('Mode: single file')
            dump_single_file(cur, config, DUMP_DIR)
        elif args.mode == 'multi':
            logging.info('Mode: multiple files')
            dump_multiple_files(cur, config, DUMP_DIR)

        logging.info('Schema dump process completed')

    except Exception as e:
        logging.error(f'An error occurred: {e}')
        sys.exit(1)


if __name__ == '__main__':
    parser = argparse.ArgumentParser(description='Dump PostgreSQL schema.')
    parser.add_argument('--info', required=True, help='Path to the info JSON file.')
    parser.add_argument("--mode",
                        help="Set the mode to 'single' to dump all tables into a single SQL file or 'multi' to dump each table into a separate SQL file. Default is 'single'.",
                        default='single')
    args = parser.parse_args()

    main(args)
