Message-ID: <FD52892BD296D71183B400065BFCB6900DBF8830@il02exm12>
From: Lewis Adam-CAL022 <Adam.Lewis@motorola.com>
Date: Fri, 13 Aug 2004 13:58:17 -0500
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_000_01C48167.7E2F3D60"
Subject: [Bridge] Bridging and Ethernet FCS
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

------_=_NextPart_000_01C48167.7E2F3D60
Content-Type: multipart/alternative;
	boundary="----------=_1092423502-20056-296"
Content-Transfer-Encoding: binary
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

This is a multi-part message in MIME format...

------------=_1092423502-20056-296
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Disposition: inline

Hello,
 
I am trying to understand how the bridge code deals with the Ethernet FCS.  I have written a WLAN driver, and have tied it to eth0 via the bridge utilities.  What confuses me is that when my hard_start_xmit routine is called, when it is receiving data from eth0, it comes complete with the FCS.  For a typical max length TCP packet, this puts the total frame length at 1504, which exceeds the 1500 Ethernet MTU.  So if my an unknowing driver takes the full payload and sends it across the wireless link, where on the other side it is passed back to Ethernet (also via the bridge code), it is discarded since 1504 > MTU.  How is this situation typically dealt with?
 
TIA,
Adam

------------=_1092423502-20056-296
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: base64
Content-Disposition: inline

PCFET0NUWVBFIEhUTUwgUFVCTElDICItLy9XM0MvL0RURCBIVE1MIDQuMCBU
cmFuc2l0aW9uYWwvL0VOIj4NCjxIVE1MPjxIRUFEPg0KPE1FVEEgSFRUUC1F
UVVJVj0iQ29udGVudC1UeXBlIiBDT05URU5UPSJ0ZXh0L2h0bWw7IGNoYXJz
ZXQ9aXNvLTg4NTktMSI+DQo8VElUTEU+R2xhY2llcjwvVElUTEU+DQoNCjxE
RUZBTkdFRF9TVFlMRSBCT0RZIHsNCglNQVJHSU4tVE9QOiAyMHB4OyBGT05U
LVNJWkU6IDEwcHQ7IE1BUkdJTi1MRUZUOiA1MHB4OyBDT0xPUjogIzAwNjY2
NjsgRk9OVC1GQU1JTFk6IEFyaWFsLCBIZWx2ZXRpY2ENCn0NCj48L0RFRkFO
R0VEX1NUWUxFPg0KDQo8TUVUQSBjb250ZW50PSJNU0hUTUwgNi4wMC4yODAw
LjE0NTgiIG5hbWU9R0VORVJBVE9SPjwvSEVBRD4NCjxCT0RZIERFRkFOR0VE
X2JhY2tncm91bmQ9ImNpZDo0ODMyOTI5MTRAMTMwODIwMDQtMTk2OCI+DQo8
RElWPjxTUEFOIGNsYXNzPTQ4MzI5MjkxNC0xMzA4MjAwND5IZWxsbyw8L1NQ
QU4+PC9ESVY+DQo8RElWPjxTUEFOIGNsYXNzPTQ4MzI5MjkxNC0xMzA4MjAw
ND48L1NQQU4+Jm5ic3A7PC9ESVY+DQo8RElWPjxTUEFOIGNsYXNzPTQ4MzI5
MjkxNC0xMzA4MjAwND5JIGFtIHRyeWluZyB0byB1bmRlcnN0YW5kIGhvdyB0
aGUgYnJpZGdlIA0KY29kZSBkZWFscyB3aXRoIHRoZSBFdGhlcm5ldCBGQ1Mu
Jm5ic3A7IEkgaGF2ZSB3cml0dGVuIGEgV0xBTiBkcml2ZXIsIGFuZCBoYXZl
IA0KdGllZCBpdCB0byBldGgwIHZpYSB0aGUgYnJpZGdlIHV0aWxpdGllcy4m
bmJzcDsgV2hhdCBjb25mdXNlcyBtZSBpcyB0aGF0IHdoZW4gbXkgDQpoYXJk
X3N0YXJ0X3htaXQgcm91dGluZSBpcyBjYWxsZWQsIHdoZW4gaXQgaXMgcmVj
ZWl2aW5nIGRhdGEgZnJvbSBldGgwLCBpdCBjb21lcyANCmNvbXBsZXRlIHdp
dGggdGhlIEZDUy4mbmJzcDsgRm9yIGEgdHlwaWNhbCBtYXggbGVuZ3RoIFRD
UCBwYWNrZXQsIHRoaXMgcHV0cyB0aGUgDQp0b3RhbCBmcmFtZSBsZW5ndGgg
YXQgMTUwNCwgd2hpY2ggZXhjZWVkcyB0aGUgMTUwMCBFdGhlcm5ldCBNVFUu
Jm5ic3A7IFNvIGlmIG15IA0KYW4gdW5rbm93aW5nIGRyaXZlciB0YWtlcyB0
aGUgZnVsbCBwYXlsb2FkIGFuZCBzZW5kcyBpdCBhY3Jvc3MgdGhlIHdpcmVs
ZXNzIA0KbGluaywgd2hlcmUgb24gdGhlIG90aGVyIHNpZGUgaXQgaXMgcGFz
c2VkIGJhY2sgdG8gRXRoZXJuZXQgKGFsc28gdmlhIHRoZSBicmlkZ2UgDQpj
b2RlKSwgaXQgaXMgZGlzY2FyZGVkIHNpbmNlIDE1MDQgJmd0OyBNVFUuJm5i
c3A7IEhvdyBpcyB0aGlzIHNpdHVhdGlvbiANCnR5cGljYWxseSBkZWFsdCB3
aXRoPzwvU1BBTj48L0RJVj4NCjxESVY+PFNQQU4gY2xhc3M9NDgzMjkyOTE0
LTEzMDgyMDA0PjwvU1BBTj4mbmJzcDs8L0RJVj4NCjxESVY+PFNQQU4gY2xh
c3M9NDgzMjkyOTE0LTEzMDgyMDA0PlRJQSw8L1NQQU4+PC9ESVY+DQo8RElW
PjxTUEFOIGNsYXNzPTQ4MzI5MjkxNC0xMzA4MjAwND5BZGFtPC9TUEFOPjwv
RElWPjwvQk9EWT48L0hUTUw+DQo=

------------=_1092423502-20056-296--

------_=_NextPart_000_01C48167.7E2F3D60
Content-Type: image/jpeg;
	name="Glacier Bkgrd.jpg"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="Glacier Bkgrd.jpg"
Content-ID: <483292914@13082004-1968>

/9j/4AAQSkZJRgABAgEASABIAAD/7QSqUGhvdG9zaG9wIDMuMAA4QklNA+kA
AAAAAHgAAwAAAEgASAAAAAAC2gIo/+H/4QL5AkUDRwUoA/wAAgAAAEgASAAA
AAAC2AIoAAEAAABkAAAAAQADAwMAAAABJw8AAQABAAAAAAAAAAAAAAAAYAgA
GQGQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA4QklNA+0AAAAA
ABAASAAAAAEAAQBIAAAAAQABOEJJTQPzAAAAAAAIAAAAAAAAAAA4QklNBAoA
AAAAAAEAADhCSU0nEAAAAAAACgABAAAAAAAAAAI4QklNA/UAAAAAAEgAL2Zm
AAEAbGZmAAYAAAAAAAEAL2ZmAAEAoZmaAAYAAAAAAAEAMgAAAAEAWgAAAAYA
AAAAAAEANQAAAAEALQAAAAYAAAAAAAE4QklNA/gAAAAAAHAAAP//////////
//////////////////8D6AAAAAD/////////////////////////////A+gA
AAAA/////////////////////////////wPoAAAAAP//////////////////
//////////8D6AAAOEJJTQQAAAAAAAACAAA4QklNBAIAAAAAAAIAADhCSU0E
CAAAAAAAEAAAAAEAAAJAAAACQAAAAAA4QklNBAkAAAAAApkAAAABAAAAgAAA
AAEAAAGAAAABgAAAAn0AGAAB/9j/4AAQSkZJRgABAgEASABIAAD//gAnRmls
ZSB3cml0dGVuIGJ5IEFkb2JlIFBob3Rvc2hvcKggNC4wAP/uAA5BZG9iZQBk
gAAAAAH/2wCEAAwICAgJCAwJCQwRCwoLERUPDAwPFRgTExUTExgRDAwMDAwM
EQwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwBDQsLDQ4NEA4OEBQODg4U
FA4ODg4UEQwMDAwMEREMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwM
DAwMDP/AABEIAAEAgAMBIgACEQEDEQH/3QAEAAj/xAE/AAABBQEBAQEBAQAA
AAAAAAADAAECBAUGBwgJCgsBAAEFAQEBAQEBAAAAAAAAAAEAAgMEBQYHCAkK
CxAAAQQBAwIEAgUHBggFAwwzAQACEQMEIRIxBUFRYRMicYEyBhSRobFCIyQV
UsFiMzRygtFDByWSU/Dh8WNzNRaisoMmRJNUZEXCo3Q2F9JV4mXys4TD03Xj
80YnlKSFtJXE1OT0pbXF1eX1VmZ2hpamtsbW5vY3R1dnd4eXp7fH1+f3EQAC
AgECBAQDBAUGBwcGBTUBAAIRAyExEgRBUWFxIhMFMoGRFKGxQiPBUtHwMyRi
4XKCkkNTFWNzNPElBhaisoMHJjXC0kSTVKMXZEVVNnRl4vKzhMPTdePzRpSk
hbSVxNTk9KW1xdXl9VZmdoaWprbG1ub2JzdHV2d3h5ent8f/2gAMAwEAAhED
EQA/APTqPon4/wAAir5XSQGyn6oSXyukip+qEl8rpJKfqhJfK6SSn6oSXyuk
kp+qEl8rpJKfqhJfK6SSn6oSXyukkp//2QA4QklNBAYAAAAAAAcABAAAAAEB
AP/+ACdGaWxlIHdyaXR0ZW4gYnkgQWRvYmUgUGhvdG9zaG9wqCA0LjAA/+4A
DkFkb2JlAGQAAAAAAf/bAIQABgQEBwUHCwYGCw4KCAoOEQ4ODg4RFhMTExMT
FhEMDAwMDAwRDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAEHCQkTDBMi
ExMiFA4ODhQUDg4ODhQRDAwMDAwREQwMDAwMDBEMDAwMDAwMDAwMDAwMDAwM
DAwMDAwMDAwMDAwM/8AAEQgAAwZAAwERAAIRAQMRAf/dAAQAyP/EAaIAAAAH
AQEBAQEAAAAAAAAAAAQFAwIGAQAHCAkKCwEAAgIDAQEBAQEAAAAAAAAAAQAC
AwQFBgcICQoLEAACAQMDAgQCBgcDBAIGAnMBAgMRBAAFIRIxQVEGE2EicYEU
MpGhBxWxQiPBUtHhMxZi8CRygvElQzRTkqKyY3PCNUQnk6OzNhdUZHTD0uII
JoMJChgZhJRFRqS0VtNVKBry4/PE1OT0ZXWFlaW1xdXl9WZ2hpamtsbW5vY3
R1dnd4eXp7fH1+f3OEhYaHiImKi4yNjo+Ck5SVlpeYmZqbnJ2en5KjpKWmp6
ipqqusra6voRAAICAQIDBQUEBQYECAMDbQEAAhEDBCESMUEFURNhIgZxgZEy
obHwFMHR4SNCFVJicvEzJDRDghaSUyWiY7LCB3PSNeJEgxdUkwgJChgZJjZF
GidkdFU38qOzwygp0+PzhJSktMTU5PRldYWVpbXF1eX1RlZmdoaWprbG1ub2
R1dnd4eXp7fH1+f3OEhYaHiImKi4yNjo+DlJWWl5iZmpucnZ6fkqOkpaanqK
mqq6ytrq+v/aAAwDAQACEQMRAD8A9N/vv+Lv+SWFhv5/7F377/i7/kliu/n/
ALFbJ63H/dv0+lTFd/P/AGKj++/y/wDkliu/n/sVa29Tl8fSn7fCn/JPfFIR
H/AYGTv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq
7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFX
f8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wAB
irv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gM
Vd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Bi
rv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+
AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/w
GKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8A
gMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3
/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/
4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd
/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq
7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFX
f8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wAB
irv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gM
Vd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Bi
rv8AgMVd/wABirv+AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+
AxV3/AYq7/gMVd/wGKu/4DFXf8Birv8AgMVd/wABirv+AxV3/AYq/wD/2Q==

------_=_NextPart_000_01C48167.7E2F3D60
Content-Type: text/plain; name="SpamAssassinReport.txt"
Content-Disposition: inline; filename="SpamAssassinReport.txt"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Mailer: MIME-tools 5.411 (Entity 5.404)

Spam detection software, running on the system "fire-1.osdl.org", has
identified this incoming email as possible spam.  The original message
has been attached to this so you can view it (if it isn't spam) or block
similar future email.  If you have any questions, see
the administrator of that system for details.

Content preview:  This message is in MIME format. Since your mail reader
  does not understand this format, some or all of this message may not be
  legible. ------_=3D_NextPart_001_01C48167.7E2F3D60 =1D=E9eI am trying to
  understand how the bridge code deals with the Ethernet FCS. I have
  written a WLAN driver, and have tied it to eth0 via the bridge
  utilities. What confuses me is that when my hard_start_xmit routine is
  called, when it is receiving data from eth0, it comes complete with the
  FCS. For a typical max length TCP packet, this puts the total frame
  length at 1504, which exceeds the 1500 Ethernet MTU. So if my an
  unknowing driver takes the full payload and sends it across the
  wireless link, where on the other side it is passed back to Ethernet
  (also via the bridge code), it is discarded since 1504 > MTU. How is
  this situation typically dealt with? L=80=00u=A9 [...]=20

Content analysis details:   (6.7 points, 5.0 required)

 pts rule name              description
---- ---------------------- -----------------------------------------------=
---
 1.1 MIME_BASE64_LATIN      RAW: Latin alphabet text using base64 encoding
 1.1 MIME_BASE64_TEXT       RAW: Message text disguised using base64 encodi=
ng
 0.2 MIME_BASE64_NO_NAME    RAW: base64 attachment does not have a file name
 4.3 FORGED_IMS_TAGS        IMS mailers can't send HTML in this format



------_=_NextPart_000_01C48167.7E2F3D60--
