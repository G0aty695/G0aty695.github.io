from django.urls import path
from . import views
app_name = 'to_dos'
urlpatterns = [
    # Home page
    path('', views.index, name='index'),
    # To do page
    path('jobs/', views.jobs, name='jobs'),
    # New job page
    path('new_job/', views.new_job, name='new_job'),
    # Delete job page
    path('delete_job/<job_id>', views.delete_job, name='delete_job'),
]