"""
user_registration_form: criado com o comando `django-admin startapp user_registration_form`.
"""

from django.urls import path
from user_registration_form.views import RegistrationFormView

urlpatterns = [
    path('user-authentication/', RegistrationFormView.as_view(), name='user-authentication'),
]
