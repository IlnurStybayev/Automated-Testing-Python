// task-actions.js
document.addEventListener('DOMContentLoaded', function () {
  // Функция для завершения задачи на сервере
  function completeTaskOnServer(taskId) {
      fetch('/complete-task/' + taskId, {
          method: 'POST',
          headers: {
              'Content-Type': 'application/json', // Установите правильный Content-Type
          },
          // В теле запроса можно отправить дополнительные данные, если необходимо
          body: JSON.stringify({ taskId: taskId }),
      })
          .then(function (response) {
              if (response.ok) {
                  console.log('Задача завершена на сервере:', taskId);
                  // Обновляем статус задачи в интерфейсе
                  document.getElementById('task-' + taskId).classList.add('completed');
              } else {
                  console.error('Ошибка при завершении задачи на сервере:', response.status);
              }
          })
          .catch(function (error) {
              console.error('Ошибка:', error);
          });
  }

  // Обработчики для всех кнопок "Завершить"
  var completeButtons = document.querySelectorAll('.complete-task-button');
  completeButtons.forEach(function (button) {
      button.addEventListener('click', function () {
          var taskId = this.getAttribute('data-task-id');
          completeTaskOnServer(taskId);
      });
  });

  // Функция для удаления задачи на сервере
  function deleteTaskOnServer(taskId) {
      fetch('/delete-task/' + taskId, {
          method: 'DELETE',
      })
          .then(function (response) {
              if (response.ok) {
                  console.log('Задача удалена на сервере:', taskId);
                  // Удаляем элемент задачи из списка
                  var taskItem = document.getElementById('task-' + taskId);
                  taskItem.parentNode.removeChild(taskItem);
              } else {
                  console.error('Ошибка при удалении задачи на сервере:', response.status);
              }
          })
          .catch(function (error) {
              console.error('Ошибка:', error);
          });
  }

  // Обработчики для всех кнопок "Удалить"
  var deleteButtons = document.querySelectorAll('.delete-task-button');
  deleteButtons.forEach(function (button) {
      button.addEventListener('click', function () {
          var taskId = this.getAttribute('data-task-id');
          deleteTaskOnServer(taskId);
      });
  });
});