package main

import (
	"database/sql"
	"log"
	"net/http"

	"github.com/labstack/echo/v4"
	_ "github.com/go-sql-driver/mysql"
	"golang.org/x/crypto/bcrypt"
)

var db *sql.DB

type User struct {
	ID       int    `json:"id"`
	Username string `json:"username"`
	Password string `json:"password"`
}

func initDB() {
	var err error
	db, err = sql.Open("mysql", "root:None@tcp(192.168.11.73:3306)/pms")
	if err != nil {
		log.Fatal(err)
	}
}

func register(c echo.Context) error {
	u := new(User)
	if err := c.Bind(u); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	// Hash password
	hashedPassword, err := bcrypt.GenerateFromPassword([]byte(u.Password), bcrypt.DefaultCost)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "Failed to hash password")
	}

	// Insert user into database
	_, err = db.Exec("INSERT INTO auth (username, password) VALUES (?, ?)", u.Username, hashedPassword)
	if err != nil {
		return echo.NewHTTPError(http.StatusInternalServerError, "Failed to create user")
	}

	return c.JSON(http.StatusCreated, map[string]string{"message": "User created successfully"})
}

func main() {
	initDB()
	defer db.Close()

	e := echo.New()
	e.POST("/register", register)
	// e.Logger.Fatal(e.Start(":4321"))
	e.Logger.Fatal(e.Start(":4321"))
}