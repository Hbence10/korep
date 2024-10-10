/* API Lekeresnek a menete: 
    1. async tipusu fugvenyt (async fugveny: Promise-t returnol)
    2. fetch() method alkalmazasa --> a fetchet lementjuk egy kulon valtozoba, a fetch ele await-ot --> addig nem fog tovabb menni mig meg nem kapja a kivant adatokat
    3. a lefetchelt valtozot "atvaltjuk" json tipussa
*/

async function apiCall(){
    let apiCall = await fetch('https://fakestoreapi.com/products') //A Promise tipusu valtozo
    let apiData = await apiCall.json(); //A lekert object json (Javascript Object Notation) --> object = kulcs ertek paron alapulo tipus. FONTOS az object nem primitive.

    console.log(apiData)
    writeDetails(apiData)

    return apiData
};

// Informacio kiirasa:
function writeDetails(response){ //response = a fogadott adattal
    for(let i = 0; i <= response.length; i+=3){
        const row = document.createElement("div"); //HTML element letrehozasa, a zarojelben mindig a kivant tag-nek a nevet irjuk
        row.classList.add("row", "my-2") //classlist.add --> az adott elementre osztaly adasa, ha tobb ossztaly van akkor a kulon osztalyokat ""-ba irjuk es ,-vel valasztjuk el
        const eachRow = response.slice(i, i+3) //visszaadja az adott listanak az x es y index kozotti elemeket. FONTOS! ha pl 0. es 4. elem kozotti elemeket szeretnenk kikerni akkor a 4. elem nincs benne
        eachRow.forEach(element => { //element = a lista adott eleme azaz object
            // ` = template literal -->  annak ellenere, hogy string tudunk bele valtozot irni --> ${valtozoNev}
            // innertHTML = A HTML-be irja bele a kivant dolgot
            row.innerHTML += `
                        <div class="col-lg-4">
                            <div class="card">
                                <img src="${element.image}" class="card-img-top my-4" alt="...">
                                <div class="card-body">
                                    <h5 class="card-title">${element.title}</h5> 
                                    <div class="paragraphDiv">
                                        <p class="card-text mt-4">${element.description}</p>
                                    </div>
                                    <div class="d-flex flex-row justify-content-between align-items-center">
                                        <h5>Category:  ${element.category}</h5>
                                        <h3 class="text-end my-4">${element.price} $</h3>
                                    </div>

                                    <div class="d-flex justify-content-end align-items-center">
                                        <button href="#" class="btn btn-outline-primary">Add to Cart <i class="fa-solid fa-cart-shopping"></i></button>
                                    </div>
                                </div>
                            </div>
                        </div>`
            
        });
        document.getElementById("mainContainer").appendChild(row)

    }
};

apiCall() //meghivjuk a fugvenyt az oldal betoltesekor

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
        fetch: HTTP (Hyper Text Transfer Protocol) keresekhez szokas hasznalni. A fetchelni kivant adat asyncronikus adatkent ternek vissza
*/

// API DOCS: https://fakestoreapi.com/docs

/*
    Forrasok:
        https://www.geeksforgeeks.org/asynchronous-javascript/
        https://developer.mozilla.org/en-US/docs/Learn/JavaScript/Asynchronous/Introducing#synchronous_programming
        https://www.youtube.com/watch?v=QSqc6MMS6Fk
*/