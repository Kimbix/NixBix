const entry = App.configDir + "/ts/main.ts";
const outdir = "/tmp/ags/js";

const entrycss = App.configDir + "/scss/style.scss";
const outcss = "/tmp/ags/css";

Utils.exec(`sassc ${entrycss} ${outcss}`)

try {
	await Utils.execAsync([
		"bun", "build", entry,
		"--outdir", outdir,
		"--external", "resource://*",
		"--external", "gi://*",
	]);
	await import(`file://${outdir}/main.js`);
} catch (error) {
	console.error(error);
}
