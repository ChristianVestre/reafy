export const createIdentifier = (name: string) => {
    return name.toLocaleLowerCase().split(" ").join("")
}

export const getUrlParams = (url: string) => {
    return Object.fromEntries(new URLSearchParams(url.substring(url.indexOf("?") + 1)))
}