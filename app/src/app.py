from flask import Flask, render_template, request, url_for, redirect, jsonify, flash
from flask_mysqldb import MySQL
from flask_login import LoginManager, login_user, logout_user, login_required, current_user
app = Flask(__name__)
if __name__ == '__main__':
    app.run(debub=True)
