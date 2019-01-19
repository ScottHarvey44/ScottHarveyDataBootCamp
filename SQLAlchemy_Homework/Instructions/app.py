import numpy as np

import datetime as dt

import sqlalchemy
from sqlalchemy.ext.automap import automap_base
from sqlalchemy.orm import Session
from sqlalchemy import create_engine, func

from flask import Flask, jsonify


#################################################
# Database Setup
#################################################
engine = create_engine("sqlite:///Resources/hawaii.sqlite")

# reflect an existing database into a new model
Base = automap_base()
# reflect the tables
Base.prepare(engine, reflect=True)

# Save reference to the table
Measurement = Base.classes.measurement
Station = Base.classes.station

# Create our session (link) from Python to the DB
session = Session(engine)

#################################################
# Flask Setup
#################################################
app = Flask(__name__)


#################################################
# Flask Routes
#################################################

@app.route("/")
def welcome():
    """List all available api routes."""
    return (
        f"Available Routes:<br/>"
        f"/api/v1.0/precipitation<br/>"
        f"/api/v1.0/stations<br/>"
        f"/api/v1.0/tobs<br/"
    )


@app.route("/api/v1.0/precipitation")
def percipitation():
    "Convert the query results to a Dictionary using `date` as the key and `prcp` as the value."
    percip = session.query(Measurement.date, Measurement.prcp).all()

   # Create a dictionary from the row data and append to a list of all_passengers
    all_results = []
    for rows in percip:
        results_dict = {}
        results_dict["date"] = rows.date
        results_dict["prcp"] = rows.prcp
        all_results.append(results_dict)

    return jsonify(all_results)


@app.route("/api/v1.0/stations")
def stations():
    """Return a JSON list of stations from the dataset."""
    # Query all stations
    results = session.query(Station.name).all()

    # Convert list of tuples into normal list
    all_names = list(np.ravel(results))

    return jsonify(all_names)

@app.route("/api/v1.0/tobs")
def tobs():

    query_date = dt.date(2017, 8, 23) - dt.timedelta(days=365)
    temp = session.query(Measurement.date, Measurement.tobs).filter(Measurement.date > query_date ).all()

    all_results = []
    for rows in temp:
        results_dict = {}
        results_dict["date"] = rows.date
        results_dict["tobs"] = rows.tobs
        all_results.append(results_dict)

    return jsonify(all_results)


if __name__ == '__main__':
    app.run(debug=True)
