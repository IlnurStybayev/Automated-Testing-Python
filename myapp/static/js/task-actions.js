document.addEventListener('DOMContentLoaded', function () {
    // Текущий редактируемый taskId
    var currentEditingTaskId = null;

    // Функция для завершения задачи на сервере
    function completeTaskOnServer(taskId) {
        console.log('Запрос на завершение задачи:', taskId);
        fetch('/complete-task/' + taskId, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken')  // Получение CSRF-токена
            },
            body: JSON.stringify({ taskId: taskId }),
        })
        .then(handleResponse)
        .then(function (data) {
            console.log('Задача успешно завершена:', data);
            document.getElementById('task-' + taskId).classList.add('completed');
        })
        .catch(handleError);
    }

    // Функция для удаления задачи на сервере
    function deleteTaskOnServer(taskId) {
        console.log('Запрос на удаление задачи:', taskId);
        fetch('/delete-task/' + taskId, {
            method: 'DELETE',
            headers: {
                'X-CSRFToken': getCookie('csrftoken')  // Получение CSRF-токена
            },
        })
        .then(handleResponse)
        .then(function (data) {
            console.log('Задача успешно удалена:', data);
            var taskItem = document.getElementById('task-' + taskId);
            taskItem.parentNode.removeChild(taskItem);
        })
        .catch(handleError);
    }

    // Функция для редактирования задачи на сервере
    function saveTaskChanges(taskId) {
        console.log('Функция saveTaskChanges вызвана для задачи:', taskId);
        var updatedTitle = document.getElementById('edit-task-title').value;
        console.log('Запрос на редактирование задачи:', taskId, 'Новый заголовок:', updatedTitle);
        fetch('/update-task/' + taskId + '/', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCookie('csrftoken')  // Получение CSRF-токена
            },
            body: JSON.stringify({ title: updatedTitle }), // Передаем title в теле запроса
        })
        .then(handleResponse)
        .then(function (data) {
            console.log('Задача успешно отредактирована:', data);
            document.getElementById('task-' + taskId).querySelector('.task-title').textContent = updatedTitle;
            document.getElementById('edit-task-modal').style.display = 'none';
            currentEditingTaskId = null; // Сброс текущего редактируемого ID задачи
        })
        .catch(handleError);
    }

    // Обработка ответа сервера
    function handleResponse(response) {
        if (!response.ok) {
            console.error('Ошибка сервера:', response.status, response.statusText);
            throw new Error('Server response was not ok.');
        }
        return response.json();  // Можно адаптировать в зависимости от ответа сервера
    }

    // Обработка ошибок запроса
    function handleError(error) {
        console.error('Fetch error:', error);
    }

    // Функция для получения значения cookie (например, CSRF-токена)
    function getCookie(name) {
        let cookieValue = null;
        if (document.cookie && document.cookie !== '') {
            const cookies = document.cookie.split(';');
            for (let i = 0; i < cookies.length; i++) {
                const cookie = cookies[i].trim();
                if (cookie.substring(0, name.length + 1) === (name + '=')) {
                    cookieValue = decodeURIComponent(cookie.substring(name.length + 1));
                    break;
                }
            }
        }
        return cookieValue;
    }

    // Функция для открытия модального окна при нажатии "Редактировать"
    function openEditModal(taskId) {
        currentEditingTaskId = taskId;
        var modal = document.getElementById('edit-task-modal');
        modal.style.display = 'block';
        var currentTaskTitle = document.getElementById('task-' + taskId).querySelector('.task-title').textContent;
        document.getElementById('edit-task-title').value = currentTaskTitle;
    }

    // Добавление обработчика событий для кнопки "Сохранить изменения"
    document.getElementById('save-edit-task').addEventListener('click', function () {
        if (currentEditingTaskId) {
            saveTaskChanges(currentEditingTaskId);
        }
    });

    // Добавьте обработчик события для кнопок "Редактировать"
    document.querySelectorAll('.edit-task-button').forEach(function (button) {
        button.addEventListener('click', function () {
            var taskId = this.getAttribute('data-task-id');
            openEditModal(taskId);
        });
    });

    // Добавление обработчиков событий для кнопок "Завершить" и "Удалить"
    document.querySelectorAll('.complete-task-button').forEach(function (button) {
        button.addEventListener('click', function () {
            var taskId = this.getAttribute('data-task-id');
            console.log('Кнопка "Завершить" нажата для задачи:', taskId);
            completeTaskOnServer(taskId);
        });
    });

    document.querySelectorAll('.delete-task-button').forEach(function (button) {
        button.addEventListener('click', function () {
            var taskId = this.getAttribute('data-task-id');
            console.log('Кнопка "Удалить" нажата для задачи:', taskId);
            deleteTaskOnServer(taskId);
        });
    });
});
