# myapp/views.py
from django.shortcuts import render
from .models import Task
from django.shortcuts import render, redirect

def task_list(request):
    tasks = Task.objects.all()
    return render(request, 'myapp/task_list.html', {'tasks': tasks})

def create_task(request):
    if request.method == 'POST':
        title = request.POST.get('title')
        Task.objects.create(title=title)
    return redirect('task_list')
