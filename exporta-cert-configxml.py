import xml.etree.ElementTree as ET
import base64
import OpenSSL
tree = ET.ElementTree(file='config.xml')
root=tree.getroot()

def buscacert(raiz,usr,refid,senha=''):
	#refid type caref crt prv
	for inst in root.findall('./cert'):
		ref = inst.find('refid')
		typ = inst.find('type')
		car = inst.find('caref')
		crt = inst.find('crt')
		prv = inst.find('prv')
		if ref != None and ref.text == refid:
			print("Carregando chave privada "+usr+'',prv)
			print("Carregando chave publica "+',crt)
			pkdoze = OpenSSL.crypto.PKCS12()
			pequi=OpenSSL.crypto.load_privatekey(OpenSSL.crypto.FILETYPE_PEM, base64.b64decode(prv.text))
			caqui=OpenSSL.crypto.load_certificate(OpenSSL.crypto.FILETYPE_PEM, base64.b64decode(crt.text))
			pkdoze.set_privatekey(pequi)
			pkdoze.set_certificate(caqui)
			with open(usr+'.p12', 'wb') as file:
				file.write(pkdoze.export(passphrase=senha))

llo=[]
for instance in root.findall('./system/user'):
	nome = instance.find('./name')
	cert = instance.find('./cert')
	if(cert != None):
		llo.append([nome.text,cert.text])

for l in llo:
	buscacert(root,l[0],l[1])
	
