async function f() {
    var result = await fetchPubspec();
    document.getElementById("content").textContent = result;
}

f();
