function deleteReading(idLectura) {
	fetch('/delete-reading', {
		method: 'POST',
		body: JSON.stringify({ idLectura: idLectura })
	}).then((_res) => {
		window.location.href = "/readings";
	});
}

function deletePatient(nif) {
	fetch('/delete-patient', {
		method: 'POST',
		body: JSON.stringify({ nif: nif })
	}).then((_res) => {
		window.location.href = "/doctor-patients";
	});
}

function deletePrescription(idReceta) {
	fetch('/delete-prescription', {
		method: 'POST',
		body: JSON.stringify({ idReceta: idReceta })
	}).then((_res) => {
		window.location.href = "/doctor-prescriptions";
	});
}

