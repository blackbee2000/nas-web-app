-- User
CREATE TABLE IF NOT EXISTS Users (
    email TEXT,
    password TEXT,
    fullName TEXT,
    phone TEXT,
    province TEXT,
    district TEXT,
    ward TEXT,
    street TEXT,
    birthday DATETIME,
    sex TEXT,
    avt TEXT,
    uid INT
);

CREATE TABLE IF NOT EXISTS News (
    id INT,
    title TEXT,
    content TEXT,
    imageURL TEXT,
    createDate DATETIME,
    type TEXT,
    isFavorite INT,
    createAt TEXT,
    avt TEXT
);

CREATE TABLE IF NOT EXISTS HistoryBookings (
    id INT,
    storeId INT,
    technicianId INT,
    note TEXT,
    bookDate DATETIME
);

CREATE TABLE IF NOT EXISTS Stores (
    id INT,
    storeName TEXT,
    storeAddress TEXT,
    isFavorite INT,
    hotline TEXT,
    distance TEXT,
    description TEXT,
    latitude DOUBLE,
    longitude DOUBLE,
    rating DOUBLE
);

CREATE TABLE IF NOT EXISTS DateTimeBookStores (
    id INT,
    technicianId INT,
    dateTime DATETIME,
    isBook INT
);

CREATE TABLE IF NOT EXISTS Technicians (
    id INT,
    storeId INT,
    fullName TEXT,
    phone TEXT,
    address TEXT,
    rating DOUBLE
);