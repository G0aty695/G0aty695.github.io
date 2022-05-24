from django.db import models
from django.contrib.auth.models import User

class Job(models.Model):
    """A task someone needs to do"""
    text = models.CharField(max_length=200)
    date_added = models.DateTimeField(auto_now_add=True)
    owner = models.ForeignKey(User, on_delete=models.CASCADE)

    def __str__(self):
        """Return a string"""
        return self.text