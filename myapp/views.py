# myapp/views.py
import json
from django.http import HttpResponse, JsonResponse
from django.shortcuts import render, redirect, get_object_or_404
from .models import Task
from django.views.decorators.csrf import csrf_exempt
from django.views.decorators.http import require_http_methods

from django.shortcuts import render
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
        # return HttpResponse("Задача успешно удалена")
        return redirect('task_list')
    except Task.DoesNotExist:
        return HttpResponse("Задача не найдена", status=404)
    except Exception as e:
        return HttpResponse(f"Произошла ошибка: {str(e)}", status=500)
    
@csrf_exempt  # Отключите CSRF для этого view, используйте с осторожностью
@require_http_methods(["POST"])  # Разрешите только POST-запросы
def edit_task(request, task_id):
    try:
        # Получите данные из POST-запроса
        data = json.loads(request.body)
        title = data.get('title')
        
        # Найдите задачу и обновите ее
        task = get_object_or_404(Task, id=task_id)
        task.name = title
        task.save()
        
        # Отправьте ответ об успешном обновлении
        return JsonResponse({'status': 'success', 'message': 'Задача успешно обновлена.'})
    except Task.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Задача не найдена.'}, status=404)
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Произошла ошибка: {str(e)}'}, status=500)
    
def save_task(request, task_id):
    try:
        # Получите данные из POST-запроса
        data = json.loads(request.body)
        name = data.get('name')
        
        # Найдите задачу и обновите ее
        task = get_object_or_404(Task, id=task_id)
        task.name = name
        task.save()
        
        # Отправьте ответ об успешном сохранении
        return JsonResponse({'status': 'success', 'message': 'Задача успешно сохранена.'})
    except Task.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Задача не найдена.'}, status=404)
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Произошла ошибка: {str(e)}'}, status=500)
    
@csrf_exempt
@require_http_methods(["POST"])
def update_task(request, task_id):
    try:
        # Получите данные из POST-запроса
        data = json.loads(request.body)
        title = data.get('title')
        
        # Найдите задачу и обновите ее
        task = get_object_or_404(Task, id=task_id)
        task.name = title
        task.save()
        
        # Отправьте ответ об успешном обновлении
        return JsonResponse({'status': 'success', 'message': 'Задача успешно обновлена.'})
    except Task.DoesNotExist:
        return JsonResponse({'status': 'error', 'message': 'Задача не найдена.'}, status=404)
    except Exception as e:
        return JsonResponse({'status': 'error', 'message': f'Произошла ошибка: {str(e)}'}, status=500)
