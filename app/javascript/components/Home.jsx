import React from "react";
import { Link } from "react-router-dom";

export default () => (
  <div className="vw-100 vh-100 primary-color d-flex align-items-center justify-content-center">
    <div className="jumbotron jumbotron-fluid bg-transparent">
      <div className="container secondary-color">
        <h1 className="display-4">Todo List</h1>
        <p className="lead">
          A list of todo items
        </p>
        <hr className="my-4" />
        <Link
          to="/todos"
          className="btn btn-lg btn-primary"
          role="button"
        >
          Log in
        </Link>
      </div>
    </div>
  </div>
);