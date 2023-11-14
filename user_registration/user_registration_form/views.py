"""
views.py: responsável por recebr solicitações http como argumentos, importando o(s) modelo(s) relevante(s) e descobrindo quais dados enviar para o modelo, retornando assim, no final, o resultado.
"""

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from .models import UserRegistrationForm

class RegistrationFormView(APIView):
    def post(self, request):
        try:
            user_data = request.data
            user_name = request.data.get("user_name")
            user_surname = request.data.get("user_surname")
            user_email = request.data.get("user_email")
            print(user_data)

            return Response(
                {"message": "Usuário criado com sucesso"},
                status=status.HTTP_201_CREATED,
            )
        except:
            return Response(
                {"message": "Erro na criação do usuário"},
                status=status.HTTP_400_BAD_REQUEST,
            )
