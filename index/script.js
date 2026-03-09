const form = document.getElementById("taskForm");
form.addEventListener("submit", function(e) {
    e.preventDefault();

    const input = document.getElementById("taskInput");
    const title = input.value;

    console.log("Tache Accomplie :", title);
});
const tableBody = document.getElementById("tasks-body");
tasks.forEach(task => {
    const row = `
     <tr>
        <td>${task.name}</td>
            <td>${task.statue}</td>
                <td>${task.deadline}</td>

    </tr>`;
    
    tableBody.innerHTML += row;
});