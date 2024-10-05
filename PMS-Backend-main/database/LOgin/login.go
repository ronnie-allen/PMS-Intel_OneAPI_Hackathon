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

func login(c echo.Context) error {
	u := new(User)
	if err := c.Bind(u); err != nil {
		return echo.NewHTTPError(http.StatusBadRequest, err.Error())
	}

	var storedUser User
	err := db.QueryRow("SELECT id, username, password FROM auth WHERE username = ?", u.Username).Scan(&storedUser.ID, &storedUser.Username, &storedUser.Password)
	if err != nil {
		if err == sql.ErrNoRows {
			return echo.NewHTTPError(http.StatusUnauthorized, "Invalid credentials")
		}
		return echo.NewHTTPError(http.StatusInternalServerError, "Failed to retrieve user")
	}

	err = bcrypt.CompareHashAndPassword([]byte(storedUser.Password), []byte(u.Password))
	if err != nil {
		return echo.NewHTTPError(http.StatusUnauthorized, "Invalid credentials")
	}

	return c.JSON(http.StatusOK, map[string]string{"message": "Login successful"})
}

func main() {
	initDB()
	defer db.Close()

	e := echo.New()
	e.POST("/login", login)
	// e.Logger.Fatal(e.Start(":1234"))
	e.Logger.Fatal(e.Start(":1234"))
}