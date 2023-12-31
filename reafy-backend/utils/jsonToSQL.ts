import { JSONArray, JSONValue } from '../types/jsonTypes'


export const jsonToSql = (arr: JSONArray, id?: JSONValue, numberOfColumns?: number) => {
    const array: JSONValue[][] = [];
    arr.forEach((row) => {
        if (numberOfColumns) {
            Object.values(row).forEach((value, index) => {
                if (index < numberOfColumns) {
                    if (!array[index]) {
                        array.push([])
                    }

                    array[index].push(value)
                }
            })
        } else {
            Object.values(row).forEach((value, index) => {
                if (!array[index]) {
                    array.push([])
                }
                array[index].push(value)
            })
        }
    })
    if (id) {
        console.log("runds")
        array.push([])
        arr.forEach(() => {
            array[array.length - 1].push(id)
        })
    }
    return array
}

/*
export const jsonToSql = (obj:JSONArray,id?:JSONValue) => {
    let string = ''
    obj.forEach((row) => {
        let tempString = '('
        Object.values(row).forEach((value) => {
            console.log(value)
            
            if(typeof value == 'string'){
                value = "'"+value+"'"
            }
            tempString += value.toString() + ', '
        })
        if(id){
            tempString += id + ','
        }
        tempString = tempString.slice(0, -2)
        tempString += '), '
        string += tempString
    })
    string = string.slice(0, -2) 
    return string
}
*/