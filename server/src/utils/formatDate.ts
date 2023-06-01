const formatDate = (date:any) => {
    let year = date.substr(0, 4);
    let month = date.substr(5, 2);
    let day = date.substr(8, 2);
    return day + '-' + month + '-' + year;
}

export default formatDate;