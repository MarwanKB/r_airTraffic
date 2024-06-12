CREATE TABLE airports (
    faa CHAR(3) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100) NOT NULL,
    state CHAR(2) NOT NULL,
    country VARCHAR(50) NOT NULL,
    lat DOUBLE NOT NULL,
    lon DOUBLE NOT NULL,
    CONSTRAINT chk_faa_format CHECK (faa REGEXP '^[A-Z]{3}$')
);

CREATE TABLE planes (
    tailnum VARCHAR(10) PRIMARY KEY,
    type VARCHAR(50),
    manufacturer VARCHAR(50),
    issue_date DATE,
    model VARCHAR(50),
    status VARCHAR(20),
    aircraft_type VARCHAR(50),
    engine_type VARCHAR(50),
    year INT,
    CONSTRAINT chk_tailnum_format CHECK (tailnum REGEXP '^[A-Z0-9]{3,10}$')
);

CREATE TABLE airlines (
    carrier CHAR(2) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    CONSTRAINT chk_carrier_format CHECK (carrier REGEXP '^[A-Z0-9]{2}$')
);

CREATE TABLE weather (
    year INT,
    month INT,
    day INT,
    hour INT,
    origin CHAR(3),
    temp DOUBLE,
    dewp DOUBLE,
    humid DOUBLE,
    wind_dir INT,
    wind_speed DOUBLE,
    wind_gust DOUBLE,
    precip DOUBLE,
    pressure DOUBLE,
    visib DOUBLE,
    time_hour TIMESTAMP NOT NULL,
    PRIMARY KEY (year, month, day, hour, origin),
    CONSTRAINT fk_weather_origin FOREIGN KEY (origin) REFERENCES airports(faa),
    CONSTRAINT chk_origin_format CHECK (origin REGEXP '^[A-Z]{3}$')
);

CREATE TABLE flights (
    id INT AUTO_INCREMENT PRIMARY KEY,
    year INT NOT NULL,
    month INT NOT NULL,
    day INT NOT NULL,
    dep_time INT,
    sched_dep_time INT,
    dep_delay INT,
    arr_time INT,
    sched_arr_time INT,
    arr_delay INT,
    carrier CHAR(2),
    flight_num INT,
    tailnum VARCHAR(10),
    origin CHAR(3),
    dest CHAR(3),
    air_time INT,
    distance INT,
    hour INT,
    minute INT,
    CONSTRAINT fk_flights_carrier FOREIGN KEY (carrier) REFERENCES airlines(carrier),
    CONSTRAINT fk_flights_tailnum FOREIGN KEY (tailnum) REFERENCES planes(tailnum),
    CONSTRAINT fk_flights_origin FOREIGN KEY (origin) REFERENCES airports(faa),
    CONSTRAINT fk_flights_dest FOREIGN KEY (dest) REFERENCES airports(faa),
    CONSTRAINT chk_carrier_format CHECK (carrier REGEXP '^[A-Z0-9]{2}$'),
    CONSTRAINT chk_tailnum_format CHECK (tailnum REGEXP '^[A-Z0-9]{3,10}$'),
    CONSTRAINT chk_origin_format CHECK (origin REGEXP '^[A-Z]{3}$'),
    CONSTRAINT chk_dest_format CHECK (dest REGEXP '^[A-Z]{3}$')
);
