Message-ID: <FD52892BD296D71183B400065BFCB6900DD3B948@il02exm12>
From: Lewis Adam-CAL022 <Adam.Lewis@motorola.com>
Subject: FW: [Bridge] Bridging and Ethernet FCS
Date: Mon, 16 Aug 2004 11:34:39 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C483AE.ECCF066E"
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------_=_NextPart_001_01C483AE.ECCF066E
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Disposition: inline

(second retry -first was bounced due to jpg background)
 
 Hello,
 
I am trying to understand how the bridge code deals with the Ethernet FCS.  I have written a WLAN driver, and have tied it to eth0 via the bridge utilities.  What confuses me is that when my hard_start_xmit routine is called, when it is receiving data from eth0, it comes complete with the FCS.  For a typical max length TCP packet, this puts the total frame length at 1504, which exceeds the 1500 Ethernet MTU.  So if my an unknowing driver takes the full payload and sends it across the wireless link, where on the other side it is passed back to Ethernet (also via the bridge code), it is discarded since 1504 > MTU.  How is this situation typically dealt with?
 
TIA,
Adam

------_=_NextPart_001_01C483AE.ECCF066E
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: base64
Content-Disposition: inline

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBU
cmFuc2l0aW9uYWwvL0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1F
UVVJVj0iQ29udGVudC1UeXBlIiBDT05URU5UPSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9aXNvLTg4NTktMSI+DQo8VElUTEU+R2xhY2llcjwvVElUTEU+DQo8REVG
QU5HRURfU1RZTEUgfSBIZWx2ZXRpY2EgQXJpYWwsIA0KRk9OVC1GQU1JTFk6
ICMwMDY2NjY7IENPTE9SOiA1MHB4OyBNQVJHSU4tTEVGVDogMTBwdDsgRk9O
VC1TSVpFOiAyMHB4OyANCk1BUkdJTi1UT1A6IHsgQk9EWT48L0RFRkFOR0VE
X1NUWUxFPg0KPE1FVEEgY29udGVudD0iTVNIVE1MIDYuMDAuMjgwMC4xNDU4
IiBuYW1lPUdFTkVSQVRPUj48L0hFQUQ+DQo8Qk9EWSBERUZBTkdFRF9iYWNr
Z3JvdW5kPSJjaWQ6NDgzMjkyOTE0QDEzMDgyMDA0LTE5NjgiPg0KPERJVj48
U1BBTiBjbGFzcz00ODMyOTI5MTQtMTMwODIwMDQ+PFNQQU4gY2xhc3M9Nzk1
NTgzNDE2LTE2MDgyMDA0PjxGT05UIA0KZmFjZT1BcmlhbCBjb2xvcj0jODAw
MDAwIHNpemU9Mj4oc2Vjb25kIHJldHJ5IC1maXJzdCB3YXMgYm91bmNlZCBk
dWUgdG8ganBnIA0KYmFja2dyb3VuZCk8L0ZPTlQ+PC9TUEFOPjwvU1BBTj48
L0RJVj4NCjxESVY+PFNQQU4gY2xhc3M9NDgzMjkyOTE0LTEzMDgyMDA0PjxT
UEFOIA0KY2xhc3M9Nzk1NTgzNDE2LTE2MDgyMDA0PiZuYnNwOzwvU1BBTj48
L1NQQU4+PC9ESVY+DQo8RElWPjxTUEFOIGNsYXNzPTQ4MzI5MjkxNC0xMzA4
MjAwND48U1BBTiANCmNsYXNzPTc5NTU4MzQxNi0xNjA4MjAwND4mbmJzcDs8
L1NQQU4+SGVsbG8sPC9TUEFOPjwvRElWPg0KPERJVj48U1BBTiBjbGFzcz00
ODMyOTI5MTQtMTMwODIwMDQ+PC9TUEFOPiZuYnNwOzwvRElWPg0KPERJVj48
U1BBTiBjbGFzcz00ODMyOTI5MTQtMTMwODIwMDQ+SSBhbSB0cnlpbmcgdG8g
dW5kZXJzdGFuZCBob3cgdGhlIGJyaWRnZSANCmNvZGUgZGVhbHMgd2l0aCB0
aGUgRXRoZXJuZXQgRkNTLiZuYnNwOyBJIGhhdmUgd3JpdHRlbiBhIFdMQU4g
ZHJpdmVyLCBhbmQgaGF2ZSANCnRpZWQgaXQgdG8gZXRoMCB2aWEgdGhlIGJy
aWRnZSB1dGlsaXRpZXMuJm5ic3A7IFdoYXQgY29uZnVzZXMgbWUgaXMgdGhh
dCB3aGVuIG15IA0KaGFyZF9zdGFydF94bWl0IHJvdXRpbmUgaXMgY2FsbGVk
LCB3aGVuIGl0IGlzIHJlY2VpdmluZyBkYXRhIGZyb20gZXRoMCwgaXQgY29t
ZXMgDQpjb21wbGV0ZSB3aXRoIHRoZSBGQ1MuJm5ic3A7IEZvciBhIHR5cGlj
YWwgbWF4IGxlbmd0aCBUQ1AgcGFja2V0LCB0aGlzIHB1dHMgdGhlIA0KdG90
YWwgZnJhbWUgbGVuZ3RoIGF0IDE1MDQsIHdoaWNoIGV4Y2VlZHMgdGhlIDE1
MDAgRXRoZXJuZXQgTVRVLiZuYnNwOyBTbyBpZiBteSANCmFuIHVua25vd2lu
ZyBkcml2ZXIgdGFrZXMgdGhlIGZ1bGwgcGF5bG9hZCBhbmQgc2VuZHMgaXQg
YWNyb3NzIHRoZSB3aXJlbGVzcyANCmxpbmssIHdoZXJlIG9uIHRoZSBvdGhl
ciBzaWRlIGl0IGlzIHBhc3NlZCBiYWNrIHRvIEV0aGVybmV0IChhbHNvIHZp
YSB0aGUgYnJpZGdlIA0KY29kZSksIGl0IGlzIGRpc2NhcmRlZCBzaW5jZSAx
NTA0ICZndDsgTVRVLiZuYnNwOyBIb3cgaXMgdGhpcyBzaXR1YXRpb24gDQp0
eXBpY2FsbHkgZGVhbHQgd2l0aD88L1NQQU4+PC9ESVY+DQo8RElWPjxTUEFO
IGNsYXNzPTQ4MzI5MjkxNC0xMzA4MjAwND48L1NQQU4+Jm5ic3A7PC9ESVY+
DQo8RElWPjxTUEFOIGNsYXNzPTQ4MzI5MjkxNC0xMzA4MjAwND5USUEsPC9T
UEFOPjwvRElWPg0KPERJVj48U1BBTiBjbGFzcz00ODMyOTI5MTQtMTMwODIw
MDQ+QWRhbTwvU1BBTj48L0RJVj48L0JPRFk+PC9IVE1MPg0K

------_=_NextPart_001_01C483AE.ECCF066E--
