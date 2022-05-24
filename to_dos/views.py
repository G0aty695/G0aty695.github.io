from django.shortcuts import render, redirect
from django.contrib.auth.decorators import login_required

from .models import Job
from .forms import JobForm



def index(request):
    """Home page for to do app"""
    return render(request, 'to_dos/index.html')

@login_required
def jobs(request):
    """Show all jobs"""
    jobs = Job.objects.filter(owner=request.user).order_by('date_added')
    context = {'jobs': jobs}
    return render(request, 'to_dos/jobs.html', context)

@login_required
def new_job(request):
    """Add a knew job"""
    if request.method != 'POST':
        # No data submitted? Create a blank form!
        form = JobForm()
    else:
        # POST the submitted data.
        form = JobForm(data=request.POST)
        if form.is_valid():
            new_job = form.save(commit=False)
            new_job.owner = request.user
            new_job.save()
            return redirect('to_dos:jobs')

    # Display a blank or invalid form
    context = {'form': form}
    return render(request, 'to_dos/new_job.html', context)

@login_required
def delete_job(request, job_id):
     job = Job.objects.get(pk=job_id)
     job.delete()
     return redirect('to_dos:jobs')