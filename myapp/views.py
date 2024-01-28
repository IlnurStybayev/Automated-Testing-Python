# myapp/views.py
from django.http import HttpResponse
from django.shortcuts import render, redirect, get_object_or_404
from .models import Task

def task_list(request):
    tasks = Task.objects.all()
    return render(request, 'myapp/task_list.html', {'tasks': tasks})

def create_task(request):
    if request.method == 'POST':
        name = request.POST.get('name') 
        Task.objects.create(name=name)
    return redirect('task_list')

def delete_task(request, task_id):
    try:
        # Попробуйте найти задачу по идентификатору
        task = get_object_or_404(Task, id=task_id)
        # Удалите задачу
        task.delete()
        return HttpResponse("Задача успешно удалена")
    except Task.DoesNotExist:
        return HttpResponse("Задача не найдена", status=404)
    except Exception as e:
        return HttpResponse(f"Произошла ошибка: {str(e)}", status=500)
