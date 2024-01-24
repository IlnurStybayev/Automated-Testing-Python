document.addEventListener('DOMContentLoaded', function () {
    // Функция для отправки запроса на завершение задачи
    function completeTask(taskId) {
      // Здесь должен быть код для отправки запроса на сервер
      console.log('Задача завершена:', taskId);
      // Обновление статуса задачи в интерфейсе
      document.getElementById('task-' + taskId).classList.add('completed');
    }
  
    // Функция для отправки запроса на удаление задачи
    function deleteTask(taskId) {
      // Здесь должен быть код для отправки запроса на сервер
      console.log('Задача удалена:', taskId);
      // Удаление элемента задачи из списка
      var taskItem = document.getElementById('task-' + taskId);
      taskItem.parentNode.removeChild(taskItem);
    }
  
    // Добавляем обработчики для всех кнопок "Завершить"
    var completeButtons = document.querySelectorAll('.complete-task-button');
    completeButtons.forEach(function (button) {
      button.addEventListener('click', function () {
        var taskId = this.getAttribute('data-task-id');
        completeTask(taskId);
      });
    });
  
    // Добавляем обработчики для всех кнопок "Удалить"
    var deleteButtons = document.querySelectorAll('.delete-task-button');
    deleteButtons.forEach(function (button) {
      button.addEventListener('click', function () {
        var taskId = this.getAttribute('data-task-id');
        deleteTask(taskId);
      });
    });
  });
  