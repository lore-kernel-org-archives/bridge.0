Message-ID: <FD52892BD296D71183B400065BFCB6900DD3B95A@il02exm12>
From: Lewis Adam-CAL022 <Adam.Lewis@motorola.com>
Date: Mon, 16 Aug 2004 11:37:53 -0500
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C483AF.607F618A"
Subject: [Bridge] Was SKB receive from a bridge or local?
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

------_=_NextPart_001_01C483AF.607F618A
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Disposition: inline

Hi,
 
This sort of relates to the last e-mail I sent out, but different enough to warrant its own thread.
I have written a WLAN driver which I am tying to eth0 via Linux bridging.  Is there any way, inside my hard_start_xmit() routine, to know if I have received this from the eth0 (via the bridge) vs. it was sourced locally?  I am hoping a flag gets set somewhere in the skb, but I cannot find one.
 
Thanks again,
Adam 

------_=_NextPart_001_01C483AF.607F618A
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
Z3JvdW5kPSJjaWQ6MzY3Mjk1OTE4QDEzMDgyMDA0LTM3MmEiPg0KPERJVj4N
CjxESVY+PFNQQU4gY2xhc3M9MzY3Mjk1OTE4LTEzMDgyMDA0PjxGT05UIGZh
Y2U9QXJpYWwgY29sb3I9IzgwMDAwMCANCnNpemU9Mj5IaSw8L0ZPTlQ+PC9T
UEFOPjwvRElWPg0KPERJVj48U1BBTiBjbGFzcz0zNjcyOTU5MTgtMTMwODIw
MDQ+PEZPTlQgZmFjZT1BcmlhbCBjb2xvcj0jODAwMDAwIA0Kc2l6ZT0yPjwv
Rk9OVD48L1NQQU4+Jm5ic3A7PC9ESVY+DQo8RElWPjxTUEFOIGNsYXNzPTM2
NzI5NTkxOC0xMzA4MjAwND48Rk9OVCBmYWNlPUFyaWFsIGNvbG9yPSM4MDAw
MDAgc2l6ZT0yPlRoaXMgDQpzb3J0IG9mIHJlbGF0ZXMgdG8gdGhlIGxhc3Qg
ZS1tYWlsIEkgc2VudCBvdXQsIGJ1dCBkaWZmZXJlbnQgZW5vdWdoIHRvIHdh
cnJhbnQgDQppdHMgb3duIHRocmVhZC48L0ZPTlQ+PC9TUEFOPjwvRElWPg0K
PERJVj48U1BBTiBjbGFzcz0zNjcyOTU5MTgtMTMwODIwMDQ+PEZPTlQgZmFj
ZT1BcmlhbCBjb2xvcj0jODAwMDAwIHNpemU9Mj5JIGhhdmUgDQp3cml0dGVu
IGEgV0xBTiBkcml2ZXIgd2hpY2ggSSBhbSB0eWluZyB0byBldGgwIHZpYSBM
aW51eCBicmlkZ2luZy4mbmJzcDsgSXMgDQp0aGVyZSBhbnkgd2F5LCBpbnNp
ZGUgbXkgaGFyZF9zdGFydF94bWl0KCkgcm91dGluZSwgdG8ga25vdyBpZiBJ
IGhhdmUgcmVjZWl2ZWQgDQp0aGlzIGZyb20gdGhlIGV0aDAgKHZpYSB0aGUg
YnJpZGdlKSB2cy4gaXQgd2FzIHNvdXJjZWQgbG9jYWxseT8mbmJzcDsgSSBh
bSANCmhvcGluZyBhIGZsYWcgZ2V0cyBzZXQgc29tZXdoZXJlIGluIHRoZSBz
a2IsIGJ1dCBJIGNhbm5vdCBmaW5kIA0Kb25lLjwvRk9OVD48L1NQQU4+PC9E
SVY+DQo8RElWPjxTUEFOIGNsYXNzPTM2NzI5NTkxOC0xMzA4MjAwND48Rk9O
VCBmYWNlPUFyaWFsIGNvbG9yPSM4MDAwMDAgDQpzaXplPTI+PC9GT05UPjwv
U1BBTj4mbmJzcDs8L0RJVj4NCjxESVY+PFNQQU4gY2xhc3M9MzY3Mjk1OTE4
LTEzMDgyMDA0PjxGT05UIGZhY2U9QXJpYWwgY29sb3I9IzgwMDAwMCBzaXpl
PTI+VGhhbmtzIA0KYWdhaW4sPC9GT05UPjwvU1BBTj48L0RJVj4NCjxESVY+
PFNQQU4gY2xhc3M9MzY3Mjk1OTE4LTEzMDgyMDA0PjxGT05UIGZhY2U9QXJp
YWw+PEZPTlQgY29sb3I9IzgwMDAwMD48Rk9OVCANCnNpemU9Mj5BZDxTUEFO
IGNsYXNzPTMyMjExMzgxNi0xNjA4MjAwND5hbTwvU1BBTj48U1BBTiANCmNs
YXNzPTMyMjExMzgxNi0xNjA4MjAwND4mbmJzcDs8L1NQQU4+PC9GT05UPjwv
Rk9OVD48L0ZPTlQ+PC9TUEFOPjwvRElWPjwvRElWPjwvQk9EWT48L0hUTUw+
DQo=

------_=_NextPart_001_01C483AF.607F618A--
