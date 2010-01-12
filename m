MIME-Version: 1.0
In-Reply-To: <20100112152317.GB23219@kallisti.us>
Message-ID: <001485e72564c1387e047cf94f54@google.com>
Date: Tue, 12 Jan 2010 15:28:53 +0000
From: jhautbois@gmail.com
Content-Type: multipart/alternative; boundary=001485e72564c13866047cf94f51
Subject: [Bridge] =?iso-8859-1?q?Re=A0=3ARe=3A__Bridging_LACP_=28802=2E3ad?=
	=?iso-8859-1?q?=29_frames_not_working?=
List-Id: Linux Ethernet Bridging <bridge.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.linux-foundation.org>
List-Help: <mailto:bridge-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/bridge>, 
	<mailto:bridge-request@lists.linux-foundation.org?subject=subscribe>
To: Ross Vandegrift <ross@kallisti.us>, Jean-Michel Hautbois <jhautbois@gmail.com>
Cc: bridge@lists.linux-foundation.org

--001485e72564c13866047cf94f51
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Content-Transfer-Encoding: base64

SGkgUm9zcywNCg0KTGUgMTIgamFudi4gMjAxMCAxNjoyMywgUm9zcyBWYW5kZWdyaWZ0IDxyb3Nz
QGthbGxpc3RpLnVzPiBhIOljcml0IDoNCj4gWW91IGNhbid0IGJyaWRnZSBMQUNQIC0gaXQgZG9l
c24ndCBldmVuIG1ha2Ugc2Vuc2UuIExBQ1AgYnVuZGxlcyBtdXN0DQoNCj4gYmUgYmV0d2VlbiBh
ZGphY2VudCBkZXZpY2VzLiBNb3Jlb3ZlciwgTEFDUERVcyBhcmUgZGVzdGluZWQgZm9yIGENCg0K
PiBicmlkZ2UtbWFuYWdlbWVudCBhZGRyZXNzIHRoYXQgaXMgcHJvaGliaXRlZCBmcm9tIGJlaW5n
IGJyaWRnZWQgYnkNCg0KPiA4MDIuMUQuDQoNCg0KT0ssIEkgYWdyZWUsIGl0IGRvZXNuJ3QgbWFr
ZSBzZW5zZSwgYnV0IEkgd2FudCB0byBiZSB0cmFuc3BhcmVudCB1c2luZyAgDQpicmlkZ2luZy4g
SSBjYW4ndCBleHBsYWluIG15IGlkZWEgOikuDQoNCj4gV2hhdCBhcmUgeW91IHRyeWluZyB0byBh
Y2NvbXBsaXNoPyBJZiB5b3Ugd2FudCB0byB0cmFuc3BhcmVudGx5DQoNCj4gYnJpZGdlIHdpdGgg
TEFDUCBjaGFubmVscywgeW91IHNob3VsZCB0ZXJtaW5hdGUgdGhlIExBQ1AgYnVuZGxlcyBvbg0K
DQo+IHRoZSBMaW51eCBib3ggYW5kIGJyaWRnZSB0aGUgYnVuZGxlczoNCg0KDQoNCj4gZXRoMCBc
IC8gZXRoMg0KDQo+IGJvbmQwIC0tLS0tIGJyMCAtLS0tIGJvbmQxDQoNCj4gZXRoMSAvIFwgZXRo
Mw0KDQoNCllvdSBtZWFuIEkgbmVlZCB0byBoYXZlIGZvdXIgcGh5c2ljYWwgaW50ZXJmYWNlcyA/
DQpJIGNhbid0IHVuZGVyc3RhbmQgaG93IHRvbyBhY2NvbXBsaXNoIHRoaXMuDQpDdXJyZW50bHks
IEkgYW0gZG9pbmcgOg0KYnJjdGwgYWRkaWYgZXRoMQ0KYnJjdGwgYWRkaWYgZXRoMg0KDQo+IEFu
ZCB0aGVuIGNhYmxlIGV0aDAvZXRoMSB0byBvbmUgZGV2aWNlIGFuZCBldGgyL2V0aDMgdG8gdGhl
IG90aGVyLg0KSG93ID8NCg0KDQpUaGFua3MgIQ0KSk0NCg==
--001485e72564c13866047cf94f51
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Ross,<br /><br />Le 12 janv. 2010 16:23, Ross Vandegrift &lt;ross@kallis=
ti.us&gt; a =E9crit=A0:<br />&gt; You can&#39;t bridge LACP - it doesn&#39;=
t even make sense. =A0LACP bundles must<br />&gt; <br />&gt; be between adj=
acent devices. =A0Moreover, =A0LACPDUs are destined for a<br />&gt; <br />&=
gt; bridge-management address that is prohibited from being bridged by<br /=
>&gt; <br />&gt; 802.1D.<br />&gt; <br /><br />OK, I agree, it doesn&#39;t =
make sense, but I want to be transparent using bridging. I can&#39;t explai=
n my idea :). <br /> <br />&gt; What are you trying to accomplish? =A0If yo=
u want to transparently<br />&gt; <br />&gt; bridge with LACP channels, you=
 should terminate the LACP bundles on<br />&gt; <br />&gt; the Linux box an=
d bridge the bundles:<br />&gt; <br />&gt; <br />&gt; <br />&gt; eth0 \ =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/ eth2<br />&gt; <br />&gt;=
  =A0 =A0 =A0bond0 ----- br0 ---- bond1<br />&gt; <br />&gt; eth1 / =A0 =A0=
 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0\ eth3<br />&gt; <br /><br />Yo=
u mean I need to have four physical interfaces ?<br />I can&#39;t understan=
d how too accomplish this.<br />Currently, I am doing :<br />brctl addif et=
h1<br />brctl addif eth2<br /> <br />&gt; And then cable eth0/eth1 to one d=
evice and eth2/eth3 to the other.<br />How ?<br /> <br /><br />Thanks !<br =
/>JM
--001485e72564c13866047cf94f51--
