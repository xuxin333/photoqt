#include "context.h"

GetAndDoStuffContext::GetAndDoStuffContext(QObject *parent) : QObject(parent) { }
GetAndDoStuffContext::~GetAndDoStuffContext() { }

QStringList GetAndDoStuffContext::setDefaultContextMenuEntries() {

	// These are the possible entries
	QStringList m;
	m << "Edit with Gimp" << "gimp %f"
		<< "Edit with Krita" << "krita %f"
		<< "Edit with KolourPaint" << "kolourpaint %f"
		<< "Open in GwenView" << "gwenview %f"
		<< "Open in showFoto" << "showfoto %f"
		<< "Open in Shotwell" << "shotwell %f"
		<< "Open in GThumb" << "gthumb %f"
		<< "Open in Eye of Gnome" << "eog %f";

	QStringList ret;
	QVariantList forsaving;
	int counter = 0;
	// Check for all entries
	for(int i = 0; i < m.size()/2; ++i) {
		if(checkIfBinaryExists(m[2*i+1])) {
			ret << m[2*i+1] << "0" << m[2*i];
			QVariantMap map;
			map.insert("posInView",counter);
			map.insert("binary",m[2*i+1]);
			map.insert("description",m[2*i]);
			map.insert("quit","0");
			forsaving.append(map);
			++counter;
		}
	}

	saveContextMenu(forsaving);

	return ret;

}

QStringList GetAndDoStuffContext::getContextMenu() {

	QFile file(QDir::homePath() + "/.photoqt/contextmenu");

	if(!file.exists()) return setDefaultContextMenuEntries();

	if(!file.open(QIODevice::ReadOnly)) {
		std::cerr << "ERROR: Can't open contextmenu file" << std::endl;
		return QStringList();
	}

	QTextStream in(&file);

	QStringList all = in.readAll().split("\n");
	int numRow = 0;
	QStringList ret;
	foreach(QString line, all) {
		QString tmp = line;
		if(numRow == 0) {
			ret.append(tmp.remove(0,1));
			ret.append(line.remove(1,line.length()));
			++numRow;
		} else if(numRow == 1) {
			ret.append(line);
			++numRow;
		} else
			numRow = 0;
	}

	return ret;

}

bool GetAndDoStuffContext::checkIfBinaryExists(QString exec) {
	QProcess p;
#if QT_VERSION >= 0x050200
	p.setStandardOutputFile(QProcess::nullDevice());
#endif
	p.start("which " + exec);
	p.waitForFinished();
	return p.exitCode() != 2;
}


qint64 GetAndDoStuffContext::getContextMenuFileModifiedTime() {
	QFileInfo info(QDir::homePath() + "/.photoqt/contextmenu");
	return info.lastModified().toMSecsSinceEpoch();
}

void GetAndDoStuffContext::saveContextMenu(QVariantList l) {

	QMap<int,QVariantList> adj;

	// We re-order the data (use actual position in list as keys), if not deleted
	foreach(QVariant map, l) {
		QVariantMap data = map.toMap();
		// Invalid data can be caused by deletion
		if(data.value("description").isValid())
			adj.insert(data.value("posInView").toInt(),QList<QVariant>() << data.value("binary") << data.value("description") << data.value("quit"));
	}

	// Open file
	QFile file(QDir::homePath() + "/.photoqt/contextmenu");

	if(file.exists() && !file.remove()) {
		std::cerr << "ERROR: Failed to remove old contextmenu file" << std::endl;
		return;
	}

	if(!file.open(QIODevice::WriteOnly)) {
		std::cerr << "ERROR: Failed to write to contextmenu file" << std::endl;
		return;
	}

	QTextStream out(&file);

	QList<int> keys = adj.keys();
	qSort(keys.begin(),keys.end());

	// And save data
	for(int i = 0; i < keys.length(); ++i) {
		int key = keys[i];	// We need to check for the actual keys, as some integers might be skipped (due to deletion)
		QString bin = adj[key][0].toString();
		QString desc = adj[key][1].toString();
		// We need to check for that, as deleting an item otherwise could lead to an empty entry
		if(bin != "" && desc != "") {
			if(i != 0) out << "\n\n";
			out << adj[key][2].toInt() << bin << "\n";
			out << desc;
		}
	}

	file.close();

}
