# Generated by Django 4.2.9 on 2024-01-16 10:39

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('accounts', '0002_userauthtoken'),
    ]

    operations = [
        migrations.AddField(
            model_name='user',
            name='mobile',
            field=models.CharField(default=1, max_length=10),
            preserve_default=False,
        ),
    ]
