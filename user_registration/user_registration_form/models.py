from django.db import models
from django.contrib.auth.models import User


class UserRegistrationForm(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    user_name = models.CharField(max_length=50, unique=True)
    user_surname = models.CharField(max_length=50, unique=True)
    user_email = models.EmailField(max_length=320, unique=True)
    class Meta:
        app_label = 'user_registration_form'