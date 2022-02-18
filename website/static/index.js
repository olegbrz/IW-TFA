function deleteReading(idLectura) {
	fetch('/delete-reading', {
		method: 'POST',
		body: JSON.stringify({ idLectura: idLectura })
	}).then((_res) => {
		window.location.href = "/readings";
	});
}
