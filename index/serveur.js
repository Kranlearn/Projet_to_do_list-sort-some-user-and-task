const express = require("express");
const app = express();
const cors = require("cors");
const db = require("./db");

app.use(express.json());
app.use(cors());
app.use(express.static("public"));

let tasks = [{ id: 1, title: "Apprendre Node",
done: false},
    {id: 2, title: "Créer une API", done: false},
    {id: 3, title: "Chercher une entreprise", done: false},
];

app.get("/tasks", (req, res) => {
    res.json(tasks);
});

app.get("/tasks", async (req, res) => {
    try {
        const [rows] = await db.query("SELECT * FROM tasks");
        res.json(rows);
    } catch (err) {
        res.status(500).json({error: err.message});
    }
});

app.post("/tasks", (req, res) => {
    const { title } = req.body;
    const newTask = {
        id: tasks.lenght + 1, title,
        donne: false};
    tasks.push(newTasks)
    res.json(newTask);
});
app.put("/tasks/:id", (req, res) => {
    const task = tasks.find(t => t.id == req.params.id);
    if (task) {
        task.done = req.body.done;
        res.json({message:"modifié"})
    } else {
        res.status(404).json({message:"introuvable" });
    }
});
app.delete("/tasks/:id", (req, res) => {
    tasks = tasks.filter(t => t.id !=req.params.id);
    res.json({message:"supprimée"});
});

app.get("/", (req, res) => {
    res.send("API ToDo fonctionne");
});
app.get("/tasks",(req, res) => {
    deb.all("SELECT * FROM tasks", [],(err, rows)=>{
        res.json(rows);
    });
});
app.post("/tasks", (req, res) =>{
    const { title } = req.body;
    db.run("INSERT INTO tasks(title) VALUES(?)", [title], function() {
        res.json({id: this.lastID, title});
    });
});
app.put("/tasks/:id",(req, res) => {
    const { done } = req.body;
    db.run("SET WHERE id=?", [done, req.params.id],() =>{
        res.json({message: "modifiée"});
    });
});
    app.delete("/tasks/:id",(req,res) => {
        db.run("DELETE FROM tasks WHERE id=?", [req.params.id], () => {
    res.json({message:"suprimée"});
    })
});

app.listen(3000, () => {
    console.log("Serveur lancé sur http://localhost:3000");
});