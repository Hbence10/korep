async function getAllProducts() {
    try {
        const urlList = [] //A promise-okat tartalmazo lista
        const apiData = [] //A kivant objecteket tartalmazo lista
        for(let i = 1; i<= 20; i++){
            urlList.push(fetch(`https://fakestoreapi.com/products/${i}`) )
        }

        const apiCall = await Promise.all(urlList)
        for(let i = 0; i< 20; i++){
            apiData.push(await apiCall[i].json())
        }

        document.getElementById("mainContainer").style.display = ""
        
        writeDetails(apiData)

    } catch (error) {
        console.log("ajjaj")
    }
}

function writeDetails(response){
    let counter = 0;
    for(let j = 0; j < response.length; j+=3){
        let row = document.createElement("div")
        row.classList.add("row", "my-4")
        const rowItems = response.slice(j, j+3)
        rowItems.forEach(element => {
            row.innerHTML += `
                <div class="col-lg-4">
                            <div class="card">
                                <img src="${element.image}" class="card-img-top my-4" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">${element.title}</h5>
                                    <h6></h6>
                                    <div class="paragraphDiv">
                                        <p class="card-text mt-4">${element.description}</p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-between align-items-center">
                                        <h5>Category: ${element.category} </h5>
                                        <h3 class="text-end my-4">${element.price} $</h3>
                                    </div>

                                    <div class="d-flex justify-content-end align-items-center">
                                        <button href="#" class="btn btn-outline-primary">Add to Cart <i class="fa-solid fa-cart-shopping"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>
            `
        });
        
        document.getElementById("mainContainer").appendChild(row)
    }
}

document.addEventListener("DOMContentLoaded", () => {
    getAllProducts()
})


/* 
HATTER ISMERET
    "Fogalmak" amiket erdemes tudni:
        synchronous: Ez a fajta "muvelet" van alapbol a javascriptben. A syncronous fajta kod az amikor sorrol sora hajtódik végre a kód.

        asyncronous:
                A kovetkezo "muveletek" esetekor beszelunk asyncronikus kodrol: 
                                                - HTTP kereskor a fetch() methoddal
                                                - Hozzaferes kerese a user kamerajahoz/mikrofonhoz a getUserMedia()-val
                                                - Fajl kivalasztaskor a shownOpenFilePicker()-el
                                                - setTimeOut() & setInterval()

        Promise: Lenyegeben objectek, amik testesitik az adott event vegrehajtasat (siker/kudarc). Ezzel jobb lekezelhetoseget ad az asyncronikus kodnak
        async function: Promies-t returnolo function 
        await: Csak async fugvenyben lehet hasznalni. Promise tipusu adatok elle rakjuk. Szerepe az, hogy addig nem megy tovabb a kodban amig meg nem kapja a kivant adatot, azaz teljesul maga a promise
        fetch: HTTP (Hyper Text Transfer Protocol) keresekhez szokas hasznalni. A fetchelni kivant adat asyncronikus adatkent ternek vissza. Ez is egy mod hogy adatot szerezzunk/kuldjunk weben keresztul.
        Promise.all(): Egyetlen egy promise-t returnol egy promise-okkal teli listabol amikor az osszes promise beteljesult. 
*/

// API DOCS: https://fakestoreapi.com/docs

/*
    Forrasok:
        https://www.geeksforgeeks.org/asynchronous-javascript/
        https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Asynchronous/Introducing#synchronous_programming
        https://www.youtube.com/watch?v=QSqc6MMS6Fk
*/