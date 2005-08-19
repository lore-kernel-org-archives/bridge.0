Message-ID: <34d8b2fe05081823522b9bc5b6@mail.gmail.com>
Date: Fri, 19 Aug 2005 08:52:21 +0200
From: Louis Croisez <louis.croisez@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3494_2616467.1124434341294"
Subject: [Bridge] Problem of lock when deleting a bridge
List-Id: Linux Ethernet Bridging  <bridge.lists.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/bridge>
List-Post: <mailto:bridge@lists.osdl.org>
List-Help: <mailto:bridge-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/bridge>,
	<mailto:bridge-request@lists.osdl.org?subject=subscribe>
To: bridge@lists.osdl.org

This is a multi-part message in MIME format...

------=_Part_3494_2616467.1124434341294
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When i want to delete my test bridge, using:
ifconfig eth0 down
ifconfig eth1 down
ifconfig br0 down
brctl delif br0 eth0
brctl delif br0 eth1
brctl delbr br0

i get this error message from the kernel on the console:
unregister_netdevice: waiting for br0 to become free. Usage count =3D 2
The brctl user-level command is blocked.

Could you explain me what could likely be the cause of this error?

Thanks in advance,
#Louis.

------=_Part_3494_2616467.1124434341294
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

When i want to delete my test bridge, using:<br>
<font size=3D"1"><span DEFANGED_style=3D"font-family: courier new,monospace=
; background-color: rgb(255, 153, 0);">ifconfig eth0 down</span><br DEFANGE=
D_style=3D"font-family: courier new,monospace; background-color: rgb(255, 1=
53, 0);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(255, 153, 0);">ifconfig eth1 down</span><br DEFANGED_style=3D"font-f=
amily: courier new,monospace; background-color: rgb(255, 153, 0);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(255, 153, 0);">ifconfig br0 down</span><br DEFANGED_style=3D"font-fa=
mily: courier new,monospace; background-color: rgb(255, 153, 0);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(255, 153, 0);">brctl delif br0 eth0</span><br DEFANGED_style=3D"font=
-family: courier new,monospace; background-color: rgb(255, 153, 0);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(255, 153, 0);">brctl delif br0 eth1</span><br DEFANGED_style=3D"font=
-family: courier new,monospace; background-color: rgb(255, 153, 0);">
<span DEFANGED_style=3D"font-family: courier new,monospace; background-colo=
r: rgb(255, 153, 0);">brctl delbr br0</span></font><br>
<br>
i get this error message from the kernel on the console:<br>
<font size=3D"1"><span DEFANGED_style=3D"background-color: rgb(255, 153, 0)=
; font-family: courier new,monospace;">unregister_netdevice: waiting for br=
0 to become free. Usage count =3D 2</span></font><br>
The brctl user-level command is blocked.<br>
<br>
Could you explain me what could likely be the cause of this error?<br>
<br>
Thanks in advance,<br>
#Louis.<br>

------=_Part_3494_2616467.1124434341294--
