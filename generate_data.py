import csv
import random
from faker import Faker

# Initialize Faker for generating fake data
fake = Faker()

# Function to generate a fake movie/show record
def generate_fake_record():
    return {
        "show_id": fake.unique.bothify(text='???#####'),
        "type": random.choice(["Movie", "TV Show"]),
        "title": fake.sentence(nb_words=4).rstrip('.'),
        "director": fake.name(),
        "cast": ', '.join([fake.name() for _ in range(random.randint(1, 5))]),
        "country": fake.country(),
        "date_added": fake.date_between(start_date='-10y', end_date='today').strftime('%Y-%m-%d'),
        "release_year": random.randint(1980, 2021),
        "rating": random.choice(["TV-MA", "TV-14", "TV-PG", "R", "PG-13", "PG", "G"]),
        "duration": f"{random.randint(30, 180)} min",
        "listed_in": fake.sentence(nb_words=3).rstrip('.'),
        "description": fake.paragraph(nb_sentences=3)
    }

# Number of new records to generate
num_new_records = 50

# Generate new records
new_records = [generate_fake_record() for _ in range(num_new_records)]

# Output file name
filename = 'generated_netflix_titles.csv'

# Write new records to a CSV file
with open(filename, 'w', newline='', encoding='utf-8') as file:
    writer = csv.DictWriter(file, fieldnames=new_records[0].keys())
    writer.writeheader()
    writer.writerows(new_records)

print(f"Generated {num_new_records} new records in the file '{filename}'")
